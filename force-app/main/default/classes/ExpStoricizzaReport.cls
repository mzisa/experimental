public class ExpStoricizzaReport {
	public static void doStoricizzazione() {
		PageReference reportDaStoricizzare = new PageReference('/apex/ExpShowReportAsPdf');
		Blob reportContent = reportDaStoricizzare.getContent();
		Document reportDoc = new Document();
		reportDoc.FolderId = '00l1n000000OYN3AAO';
        reportDoc.Body = reportContent;
        reportDoc.ContentType = 'application/pdf';
        reportDoc.Name = 'reportDoc001';
        insert reportDoc;
	}
}