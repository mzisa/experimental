// Autore: Pio Lavorgna

global class Motorizzazione {
    
    //Istanzio una lista di tipo Macchina__c
    public static List<Macchina__c> listMacchina = new List<Macchina__c>();
    
    //Dichiaro una variabile di tipo stringa
    public static String info_Macchina;
    
    //Prenderà un valore alfanumerico e restituirà il modello e la cilindrata della macchina
    webservice static String extract_Modello(String targa) {
		
		//Controllo che il valore inserito non sia null e che sia di lunghezza 7	
    	if(!String.isBlank(targa) && targa.length() == 7) {
    	
    		listMacchina = [SELECT id, Modello__c, Cilindrata__c FROM Macchina__c WHERE Targa__c =: targa];
    		
    		//Controllo che la targa sia presente nel CRM
    		if(listMacchina.size() > 0) info_Macchina = 'Modello: ' + listMacchina[0].Modello__c + '\r\nCilindrata: ' + listMacchina[0].Cilindrata__c;
    		else info_Macchina = '****** Targa non presente o dato inserito ERRATO ******';
    	} else {
    		info_Macchina = '****** Targa non presente o dato inserito ERRATO ******';
    	}
    	return info_Macchina;
	}
	
    //Prenderà come valore la targa e la cilindrata presente nel CRM
    //aggiornando il valore dei campi
    webservice static String target_Car(String targa, Integer cilindrata) {
    	
    	//Controllo che il valore inserito della targa non sia null e che sia di lunghezza 7	
    	//Controllo che il valore inserito della cilindrata non sia null e che sia di lunghezza minore o uguale a 4	
    	if((!String.isBlank(targa) && targa.length() == 7) && 
    				(!String.isBlank(String.valueOf(cilindrata)) && cilindrata <= 4)) {
    	   System.debug('uno');
    		listMacchina = [SELECT id, Modello__c, Cilindrata__c FROM Macchina__c WHERE Targa__c =: targa];
    		
    		//Controllo che la targa sia presente nel CRM
    		if(listMacchina.size() > 0) {
    			listMacchina[0].Targa__c = targa;
    			listMacchina[0].Cilindrata__c = String.valueOf(cilindrata);
    			//Aggiorno i valori dei campi del record legati alla targa inserita
    			update listMacchina;
    			info_Macchina = 'Modello: \r\n' + listMacchina[0].Modello__c + 'Cilindrata: ' + listMacchina[0].Cilindrata__c;
    		} else info_Macchina = '****** Targa non presente o dato inserito ERRATO ******';
    	} else {
            System.debug('due');
    		info_Macchina = '****** Targa non presente o dato inserito ERRATO ******';
    	}
    	return info_Macchina;
    }
}