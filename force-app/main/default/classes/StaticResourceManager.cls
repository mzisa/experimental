public with sharing class StaticResourceManager {
	public class MetadataServiceExamplesException extends Exception { }
	
	public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }

	public static void createStaticResource(String fullName, String contentType, String cacheControl, Blob content)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.StaticResource staticResource = new MetadataService.StaticResource();
        staticResource.fullName = fullName;
        staticResource.contentType = contentType;
        staticResource.cacheControl = cacheControl;
        staticResource.content = EncodingUtil.base64Encode(content);
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { staticResource });
        handleSaveResults(results[0]);
    }

    public static void updateStaticResource(String fullName, String contentType, String cacheControl, Blob content)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.StaticResource staticResource = new MetadataService.StaticResource();
        staticResource.fullName = fullName;
        staticResource.contentType = contentType;
        staticResource.cacheControl = cacheControl;
        staticResource.content = EncodingUtil.base64Encode(content);
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { staticResource });
        handleSaveResults(results[0]);
    }

    public static void deleteStaticResource(String fullName)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results =
            service.deleteMetadata(
                'StaticResource', new String[] { fullName });
        handleDeleteResults(results[0]);
    }
}