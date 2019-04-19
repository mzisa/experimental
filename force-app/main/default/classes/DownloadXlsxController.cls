/*
SFEDE - Salesforce Excel download Engine - v.1.1
Copyright (c) 2017 Marco Zisa
*/

global class DownloadXlsxController {
	public String xlsContentType {get; set;}
	public String xlsDataFields {get; set;}
	public String xlsRels {get; set;}
	public String xlsDocPropsApp {get; set;}
	public String xlsDocPropsCore {get; set;}
	public String xlsWorkbookRels {get; set;}
	public String xlsTheme {get; set;}
	public String xlsSheet {get; set;}
	public String xlsSharedStrings {get; set;}
	public String xlsStyles {get; set;}
	public String xlsWorkbook {get; set;}

	global DownloadXlsxController() {
    PageReference pr = new PageReference('/resource/SgExpXlsTemplate/Content_Types.xml');
    Blob content = pr.getContent();
    xlsContentType = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/DataFields.map');
    content = pr.getContent();
    xlsDataFields = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/rels/rels.xml');
    content = pr.getContent();
    xlsRels = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/docProps/app.xml');
    content = pr.getContent();
    xlsDocPropsApp = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/docProps/core.xml');
    content = pr.getContent();
    xlsDocPropsCore = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/rels/workbook.xml.rels');
    content = pr.getContent();
    xlsWorkbookRels = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/theme/theme1.xml');
    content = pr.getContent();
    xlsTheme = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/worksheets/sheet1.xml');
    content = pr.getContent();
    xlsSheet = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/sharedStrings.xml');
    content = pr.getContent();
    xlsSharedStrings = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/styles.xml');
    content = pr.getContent();
    xlsStyles = content.toString();

    pr = new PageReference('/resource/SgExpXlsTemplate/xl/workbook.xml');
    content = pr.getContent();
    xlsWorkbook = content.toString();
	}

	@RemoteAction
	@ReadOnly
	global static List<SObject> getData() {
		transient List<SObject> result = new List<SObject>();
		/*
		String soql = 'SELECT Cod_s_nsg__c, Des_s_nsg__c, Cod_port__c, Descr_filiale__c, Cod_gruppo__c,' +
			'Descr_grp_map__c, Cod_industry__c, Descr_industry__c,Cod_gru_grm__c, Cod_grm__c, Anag_grm__c,' +
			'Cod_gestore__c, Anag_gestore__c, Tot_imp_margini__c FROM SObject LIMIT 15000';
		*/
		String soql = 'SELECT First_name__c, Last_name__c, Email__c, SSN__c FROM Candidate__c';

		for (SObject x : Database.query(soql))
    {
    	result.add(x);
    }
    return result;
	}
}