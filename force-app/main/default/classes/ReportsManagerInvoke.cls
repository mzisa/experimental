public class ReportsManagerInvoke {
	public static void doInvoke() {
		String reportName = 'RapportoCandidatiClone9';
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

		ReportsManager.createReport(reportName, path, reportType, description, format, columns, criteriaItems, rtff);
	}
}