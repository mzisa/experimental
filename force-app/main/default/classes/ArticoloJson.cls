public class ArticoloJson {
	public String Codice_articolo;	//473768233-0
	public String Descrizione;	//Scallops - 10/20
	public Integer Prezzo;	//932
	public Integer Quantita;	//9
	
	public static ArticoloJson parse(String json){
		return (ArticoloJson) System.JSON.deserialize(json, ArticoloJson.class);
	}

	/*
	static testMethod void testParse() {
		String json=		'[{'+
		'		"Codice_articolo__c": "473768233-0",'+
		'		"Descrizione__c": "Scallops - 10/20",'+
		'		"Prezzo__c": 932,'+
		'		"Quantita__c": 9'+
		'	}, {'+
		'		"Codice_articolo__c": "597759602-2",'+
		'		"Descrizione__c": "Pepper - Chili Powder",'+
		'		"Prezzo__c": 1043,'+
		'		"Quantita__c": 12'+
		'	}'+
		']';
		ArticoloJson obj = parse(json);
		System.assert(obj != null);
	}
	*/
}