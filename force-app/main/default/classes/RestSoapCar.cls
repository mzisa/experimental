// Author : Gianluca Esposito
// Date   : 26/01/2018

global class RestSoapCar {
        
    webservice static String getModel(String targa) {
        
     Car__c carOpel = [SELECT Name, Cilindrata__c, Targa__c FROM Car__c WHERE Name = 'Opel']; 
     
     Car__c carFiat = [SELECT Name, Cilindrata__c, Targa__c FROM Car__c WHERE Name = 'Fiat'];     
        
        if(targa == carOpel.Targa__c) {
           return 'Modello : '+ carOpel.Name + '\n\t\t\t '+ 'Cilindrata : ' + carOpel.Cilindrata__c ;
        }
        
        if(targa == carFiat.Targa__c) {
           return 'Modello : '+ carFiat.Name + '\n\t\t\t '+ 'Cilindrata : ' + carFiat.Cilindrata__c ;
        }
 
        return 'Nessun modello trovato' ;
    }
    
    webservice static String setModel(String targa,String cilindrata) {
        
        Car__c carOpel = [SELECT Name, Cilindrata__c, Targa__c FROM Car__c WHERE Name = 'Opel']; 
     
        Car__c carFiat = [SELECT Name, Cilindrata__c, Targa__c FROM Car__c WHERE Name = 'Fiat'];    
         
        if(targa == carOpel.Targa__c) {
           
           carOpel.Cilindrata__c = cilindrata;
            
           update carOpel;
            
           return 'Modello : '+ carOpel.Name + '\n\t\t\t '+ 'Cilindrata : ' + carOpel.Cilindrata__c ;
        }
        
        
        if(targa == carFiat.Targa__c) {
           
           carFiat.Cilindrata__c = cilindrata;
            
           update carFiat;
            
           return 'Modello : '+ carFiat.Name + '\n\t\t\t '+ 'Cilindrata : ' + carFiat.Cilindrata__c ;
        }
 
        return 'Inserita targa non valida' ;
    }
       
}