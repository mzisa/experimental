public class ReportsManager {
	public static String createReport(String reportName, String path, String reportType, String description, String format, 
		List<String> columns, List<MetadataService.ReportFilterItem> criteriaItems, MetadataService.ReportTimeFrameFilter rtff) {
		// Get sessionId
		MetadataService.MetadataPort service = new MetadataService.MetadataPort();
		service.SessionHeader = new MetadataService.SessionHeader_element();
		service.SessionHeader.sessionId = UserInfo.getSessionId();

		// Create the new report
		MetadataService.Report apexReport = new MetadataService.Report();

		// Set new report properties
		apexReport.name = reportName;
		apexReport.fullName = path;
		apexReport.reportType = reportType;
		apexReport.description = description;
		apexReport.format = format;
		apexReport.showDetails = true;
		apexReport.sortColumn = null;
		apexReport.sortOrder = null;
		apexReport.groupingsAcross = null;
		apexReport.groupingsDown = null;
		apexReport.chart = null;

		// Set report filters
		MetadataService.ReportFilter reportFilter = new MetadataService.ReportFilter();
		reportFilter.criteriaItems = criteriaItems;
		apexReport.filter = reportFilter;
		apexReport.timeFrameFilter = rtff;

		// Add report columns
		List<MetadataService.ReportColumn> rca = new List<MetadataService.ReportColumn>();

		for (String repColumn : columns) {
			MetadataService.ReportColumn rc = new MetadataService.ReportColumn();
			rc.aggregateTypes=null;
			rc.field = repColumn;
			rc.reverseColors=null;
			rc.showChanges=null;
			rca.add(rc);
		}
		apexReport.columns = rca;


		// Set the return value
		String retValue = '';

		// Create the new report into the CRM
		if (Test.isRunningTest()) {
			retValue = 'TestApp';
		}
		else
		{
			List<MetadataService.SaveResult> results = service.createMetadata(new MetadataService.Metadata[] { apexReport });
			retValue = results[0].fullName;
		}
		return retValue;
	}

	public static MetadataService.Report getReport(String folderName, String reportName) {
		// Retrieve a report (via METADATA API)
		MetadataService.MetadataPort service = new MetadataService.MetadataPort();
		service.SessionHeader = new MetadataService.SessionHeader_element();
		service.SessionHeader.sessionId = UserInfo.getSessionId();
		MetadataService.Report report = null;

		// Create the new report into the CRM
		if (!Test.isRunningTest()) { report = (MetadataService.Report) service.readMetadata('Report', new String[] { folderName + '/' + reportName }).getRecords()[0];}
		return report;
	}

	public static String createAttachmentFromCsvContent(String reportName, String newAttachName, String parentId) {
		// Retrieve a report (via SOQL)
		List<Report> reps = [SELECT Id from Report WHERE Name = :reportName];

		// Create an attachment based on the report CSV content
		Attachment fileAttach = new Attachment();
		fileAttach.name = newAttachName + '.csv';

		if (!Test.isRunningTest()) { 
			ApexPages.PageReference reportContent = new ApexPages.PageReference('/' + reps[0].id +'?export=1&enc=UTF-8&xf=csv');
			fileAttach.body = reportContent.getContent();
		}
		else
		{
			fileAttach.body = Blob.valueOf('some content');
		}
		fileAttach.parentid = parentid; // Id del custom object collegato all'attach
		insert fileAttach;
		return fileAttach.Id;
	}

	public static String getReportCsvContentAsBase64String(String reportName) {
		// Retrieve a report (via SOQL)
		List<Report> reps = [SELECT Id from Report WHERE Name = :reportName];
		String base64content = '';

		// Create a base-64 string based on the report CSV content
		if (!Test.isRunningTest()) { 
			ApexPages.PageReference reportContent = new ApexPages.PageReference('/' + reps[0].id +'?export=1&enc=UTF-8&xf=csv');
			base64content = EncodingUtil.base64Encode(reportContent.getContent());
		}
		else
		{
			base64content = 'TestBase64Content';
		}
		return base64content;
	}
}