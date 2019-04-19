@isTest
private class ReportsManagerTest {
    /*
    @isTest static void runAllTests() {
        // Set new report properties START --
        String reportName = 'RapportoCandidatiTest';
        String folder = 'Mifid';
        String path = folder + '/' + reportName;

        String reportType = 'Candidate_extract__c';
        String description = 'Candidati di fine gennaio';
        String format = 'Tabular';

        List<String> columns = new List<String>();
        columns.add('Candidate__c$First_Name__c');
        columns.add('Candidate__c$Last_Name__c');
        columns.add('Candidate__c$Email__c');

        MetadataService.ReportTimeFrameFilter rtff = new MetadataService.ReportTimeFrameFilter();
        rtff.dateColumn = 'Candidate__c$CreatedDate';
        rtff.endDate = Date.newInstance(2017, 12, 1);
        rtff.interval = 'INTERVAL_CUSTOM';
        rtff.startDate = Date.newInstance(2017, 12, 1);

        List<MetadataService.ReportFilterItem> criteriaItems = new List<MetadataService.ReportFilterItem>();

        MetadataService.ReportFilterItem filterItem = new MetadataService.ReportFilterItem();
        filterItem.column = 'Candidate__c$Last_Name__c';
        filterItem.operator = 'notEqual';
        filterItem.value = 'Adams';
        criteriaItems.add(filterItem);
        // Set new report properties END --
        
        // Create the report
        String output = ReportsManager.createReport(reportName, path, reportType, description, format, columns, criteriaItems, rtff);
        // Check mock return
        System.assertEquals('TestApp', output);
        // Get a report
        MetadataService.Report out = ReportsManager.getReport('Mifid','RapportoCandidatiTest');
        // Check the mock return
        System.assertEquals(null, out);

        // Create fake record to generate parent object id for the attachment -- START
        Candidate__c candidateTest = new Candidate__c();
        candidateTest.First_Name__c = 'Sergio';
        candidateTest.Last_Name__c = 'Nava';
        candidateTest.Email__c = 'sergio.nava@wr.it';
        candidateTest.SSN__c = '12345';
        insert candidateTest;
        // Create fake record to generate parent object id for the attachment -- END

        // Create attachment from report content
        String attachId = ReportsManager.createAttachmentFromCsvContent('RapportoCandidatiTest','testAttach.csv',candidateTest.Id);
        // Check mock return
        System.assertNotEquals(null, attachId);
        // Create base64 string from csv report content
        String output2 = ReportsManager.getReportCsvContentAsBase64String('RapportoCandidatiTest');
        // Check mock return
        System.assertEquals('TestBase64Content',output2);
    }
    */
}