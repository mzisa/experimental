public class ExpShowReportAsPdfController {
	public String getReportRendering() {
		String allPage = new PageReference('/00O0Y000001NskV').getContent().toString();
		String report = allPage.substringBetween('<div class="bGeneratedReport">', '<div class="bg"></div></div></div></div>');
		report = '<div class="bGeneratedReport">' + report + '<div class="bg"></div></div></div></div>';
		System.debug(report);
		return report;
	}
}