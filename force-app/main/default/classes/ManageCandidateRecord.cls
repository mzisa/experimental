public with sharing class ManageCandidateRecord {
    @AuraEnabled
    public static List<Candidate__c> getRecords() {
        List<Candidate__c> candidates;
        /*
        try{
            System.debug('ManageCandidateRecord::getRecords::void');
            candidates = [SELECT First_name__c, Last_name__c, Email__c, SSN__c FROM Candidate__c ORDER BY Id];
        } catch (Exception ex){
            System.debug('Retrieve failed!');
        }
        */
        return candidates;
    }
    @AuraEnabled
    public static Boolean deleteRecords(String[] recordsToDelete) {
        Boolean operationSucceeded = true;

        try{
            System.debug('ManageCandidateRecord::deleteRecords::' + recordsToDelete);
            Database.DeleteResult[] result = Database.Delete(recordsToDelete,true);
        } catch (Exception ex){
            operationSucceeded = false;
            System.debug('Delete failed!');
        }
        return operationSucceeded;
    }
}