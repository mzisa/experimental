public with sharing class CreateCandidateRecord {
    /**
    * Create a new candidate Record
    *
    * @param Candidate__c candidate  candidate record to be inserted
    * 
    */

    @AuraEnabled
    public static void createRecord (Candidate__c candidate) {
        try{
            System.debug('CreateCandidateRecord::createRecord::candidate'+candidate);
                    
            if(candidate != null){
                upsert candidate;
            }
        } catch (Exception ex){
            System.debug('Insert failed!');
        }
    }
}