public class ListaFattureController {
	@RemoteAction
	public static List<Fattura__c> getFattureComplete() {
		List<Fattura__c> elencoFatture = [SELECT Name, Codice_articolo__c, Descrizione__c, Prezzo__c, Quantita__c FROM Fattura__c];
		return elencoFatture;
	}
	@RemoteAction
	public static List<Fattura__c> getFattura(String descrizione) {
		List<Fattura__c> elencoFatture = 
			Database.query('SELECT Name, Codice_articolo__c, Descrizione__c, Prezzo__c, Quantita__c FROM Fattura__c WHERE Descrizione__c LIKE \'%' + descrizione + '%\'');
		return elencoFatture;
	}
	@RemoteAction
	public static Integer getFattureIndex() {
		Integer elencoFatture = [SELECT COUNT() FROM Fattura__c];
		return elencoFatture;
	}
	@RemoteAction
	public static List<Fattura__c> getFatture(String idx) {
		List<Fattura__c> elencoFatture;
		if (String.isEmpty(idx)) {
			elencoFatture = [SELECT Name, Codice_articolo__c, Descrizione__c, Prezzo__c, Quantita__c FROM Fattura__c ORDER BY Id LIMIT 1000];
		}
		else
		{
			elencoFatture = [SELECT Name, Codice_articolo__c, Descrizione__c, Prezzo__c, Quantita__c FROM Fattura__c WHERE Id > :idx ORDER BY Id LIMIT 1000];
		}
		return elencoFatture;
	}
}