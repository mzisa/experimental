public class ScaricoProdottiMagController {
	@RemoteAction
	public static List<Prodotto_Magazzino__c> getFamigliaProdotti() {
		List<Prodotto_Magazzino__c> famiglieProdotti = [SELECT Codice_Tipologia__c, Descrizione_Tipologia__c FROM Prodotto_Magazzino__c];
		return famiglieProdotti;
	}

	@RemoteAction
	public static List<Prodotto_Magazzino__c> getAreeStoccaggio() {
		List<Prodotto_Magazzino__c> areeStoccaggio = [SELECT Codice_area_di_stoccaggio__c, Descrizione_area_di_stoccaggio__c FROM Prodotto_Magazzino__c];
		return areeStoccaggio;
	}

	@RemoteAction
	public static String getTemplate() {
		Blob content = null;
        
        PageReference pr = new PageReference('/resource/TemplateProdotti/contenuto/templateprodotti.xml');
        content = pr.getContent();
        String template = content.toString();

        return template;
	}

	@RemoteAction
	public static List<Prodotto_Magazzino__c> getExcel() {
		List<Prodotto_Magazzino__c> record = [SELECT Nome__c,Codice_area_di_stoccaggio__c,Codice_pallet__c FROM Prodotto_Magazzino__c];
		return record;
	}
}