public class OpportunityForJson {
	private DateTime creationDate;
    private String status;
    
    public OpportunityForJson(Opportunity element)
    {
        creationDate = element.CreatedDate;
        status = element.StageName;
    }
}