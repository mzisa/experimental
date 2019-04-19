public class RetrieveOpportunitiesAccounts {
	public static void getNumberOfOpportuniesHavingAccounts()
    {
        Integer counter = [SELECT COUNT() FROM Opportunity WHERE AccountId != null];
        System.debug('Number of opportunies with account=' + counter);
    }
}

//Usage
//RetrieveOpportunitiesAccounts.getNumberOfOpportuniesHavingAccounts();