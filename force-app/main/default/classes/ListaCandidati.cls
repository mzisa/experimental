public class ListaCandidati {
	@AuraEnabled
    public static List<Candidate__c> getRecords() {
        List<Candidate__c> candidates;
        try{
            System.debug('ListaCandidati::getRecords::list');
            candidates = [SELECT First_name__c, Last_name__c, Email__c FROM Candidate__c ORDER BY Id];
        } catch (Exception ex){
            System.debug('Retrieve failed!');
        }
        return candidates;
    }
}