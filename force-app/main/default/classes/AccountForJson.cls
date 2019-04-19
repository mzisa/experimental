public class AccountForJson {
	private String name;
	private String address;
    private String city;
    private String country;
    private List<ContactForJson> contacts = new List<ContactForJson>();
    private List<OpportunityForJson> opportunities = new List<OpportunityForJson>();
    
    public AccountForJson(String accountIdToProcess) {
        Account aj = setAccount(accountIdToProcess);
		setRelatedContacts(accountIdToProcess);
		setRelatedOpportunities(accountIdToProcess);
    }
	
	private Account setAccount(String accountId) {
		Account a = [SELECT Name, BillingStreet, BillingCity, BillingCountry FROM Account WHERE ID = :accountId];
		name = a.Name;
        address = a.BillingStreet;
        city = a.BillingCity;
        country = a.BillingCountry;
		
		return a;
	}
	
	private void setRelatedContacts(String accountId) {
		for (Contact con : [SELECT Name, Email FROM Contact WHERE AccountId = :accountId])
        {
            ContactForJson c = new ContactForJson(con);
			contacts.add(c);
        }
	}
	
	private void setRelatedOpportunities(String AccountId) {
		for (Opportunity opp : [SELECT CreatedDate, StageName FROM Opportunity WHERE AccountId = :accountId])
        {
            OpportunityForJson o = new OpportunityForJson(opp);
            opportunities.add(o);
        }
	}
	
	public static String doSerialize(AccountForJson element) {
        return JSON.serialize(element);
    }
}