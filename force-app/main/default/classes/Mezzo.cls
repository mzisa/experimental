global class Mezzo {

    //webservice String parameter { get; set; }



    webservice static Macchina__c getCarInfo(string targa) {

        Macchina__c m = [SELECT Id,Name,Cilindrata__c,Modello__c,Targa__c 
                         FROM Macchina__c
                         WHERE Targa__c = : targa];
        return m;
    }

    webservice static Macchina__c putCarInfo(string targa, string cilindrata) {
        
        

        Macchina__c m = [SELECT Id,Name,Cilindrata__c,Modello__c,Targa__c 
                         FROM Macchina__c
                         WHERE Targa__c = : targa];
        

        m.Cilindrata__c = cilindrata;

        upsert m;

        return m;
    }

    
}