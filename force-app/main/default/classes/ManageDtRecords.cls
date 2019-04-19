public class ManageDtRecords {
	 @AuraEnabled
    public static List<SObject> getRecords(List<Object> dataModel, String dataModelTarget, String searchType, String searchFilter) {
        List<SObject> recordset;
        String columnsToQuery = '';
        String whereCondition = '';

        for (Object qc : dataModel) {
        	String queryColumn = (String) qc;
        	columnsToQuery += queryColumn + ',';
        }

        // Establish if we're running a simple search, advanced search or simple get all records
        if (String.isNotBlank(searchType)) {
            if (searchType.equals('simple')) {
                if (String.isNotBlank(searchFilter)) {
                    whereCondition = columnsToQuery.replace(',',' LIKE\'%' + searchFilter + '%\' OR ');
                    whereCondition = ' WHERE ' + whereCondition;
                    whereCondition = whereCondition.removeEnd(' OR ');
                }
            }
            else
            {
                searchFilter = searchFilter.removeStart('[').removeEnd(']').replace('},{','@').remove('{').remove('}');
                searchFilter = searchFilter.remove('"fieldName":').remove('"operator":');
                searchFilter = searchFilter.remove('"fieldValue":').remove('"chainCondition":') .remove('"');

                System.debug('Primo=' + searchFilter);
                List<String> lstFilter = searchFilter.split('@');
                String chainCondition = '';

                for (String ops : lstFilter) {
                    List<String> tmp = ops.split(',');
                    String fieldName = tmp[0];
                    String operator = tmp[1];
                    String fieldValue = tmp[2];
                    chainCondition = tmp[3];

                    System.debug('myfieldName=' + fieldName);
                    System.debug('myoperator' + operator);
                    System.debug('myfieldValue=' + fieldValue);
                    System.debug('chainCondition=' + chainCondition);

                    if (!fieldValue.equals('null')) {
                        if (operator.equals('EqualsTo')) {
                            whereCondition += fieldName + '=\'' + fieldValue + '\' ' + chainCondition + ' ';
                        }
                        if (operator.equals('Contains')) {
                            whereCondition += fieldName + ' LIKE\'%' + fieldValue + '%\' ' + chainCondition + ' ';
                        }
                    }
                }

                whereCondition = ' WHERE ' + whereCondition;
                whereCondition = whereCondition.removeEnd(' ' + chainCondition + ' ');
            }
        }

        columnsToQuery = columnsToQuery.substring(0, columnsToQuery.length() - 1);

        String soql = 'SELECT ' + columnsToQuery + ' FROM ' + dataModelTarget + whereCondition + ' ORDER BY Id';
        System.debug('mysql=' + soql);

        try{
            System.debug('ManageDtRecords::getRecords::void');
            recordset = Database.Query(soql);
        } catch (Exception ex) {
            System.debug('Retrieve failed!');
        }
        return recordset;
    }
    @AuraEnabled
    public static Boolean deleteRecords(String[] recordsToDelete) {
        Boolean operationSucceeded = true;

        try{
            System.debug('ManageCandidateRecord::deleteRecords::' + recordsToDelete);
            Database.DeleteResult[] result = Database.Delete(recordsToDelete,true);
        } catch (Exception ex){
            operationSucceeded = false;
            System.debug('Delete failed!');
        }
        return operationSucceeded;
    }
    @AuraEnabled
    public static void createRecord (SObject record) {
        try{
            System.debug('ManageDtRecords::createRecord::record'+record);
                    
            if(record != null){
                upsert record;
            }
        } catch (Exception ex){
            System.debug('Insert failed!');
        }
    }
}