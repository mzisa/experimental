public class CreaCandidato {
	@AuraEnabled
    public static void createRecord (Candidate__c candidate) {
        try{
            System.debug('CreateCandidateRecord::createRecord::candidate'+candidate);
                    
            if(candidate != null){
            	// Inseriamo il nuovo record
                insert candidate;
            }
        } catch (Exception ex){
            System.debug('Insert failed!');
        }
    }
}