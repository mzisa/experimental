public with sharing class OpportunitySendMailVFController {
	private final Opportunity opp;
    private final Opportunity oppx;
    private final Integer appliedDiscount;
    
    public List<EmailFromOpportunityLink__c> code {get;set;}
	
	// The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public OpportunitySendMailVFController(ApexPages.StandardController stdController) {
        this.opp = (Opportunity)stdController.getRecord();
        this.oppx = [SELECT Discount__c FROM Opportunity WHERE id=:opp.Id];
    }
	
	public PageReference checkDiscount() {
		if (oppx.discount__c > 20) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, Label.Max_Discount_Exceeded));
        	return null;
		}
		else
        {
            //PageReference newocp = new PageReference('/_ui/core/email/author/EmailAuthor?p2_lkid=0010Y000004i4BC&rtype=003&p3_lkid=' + opp.id + '&retURL=%2F' + opp.id);
            
            Map<String,EmailFromOpportunityLink__c> allCodes = EmailFromOpportunityLink__c.getAll();
            
            PageReference newocp = new PageReference(allCodes.get('Def').Code__c + opp.id + allCodes.get('Def').ReturnUrl__c + opp.id);
        	newocp.setRedirect(true);
        	return newocp;
        	return null;
        }
	}
    
    public PageReference goBack() {
        PageReference newocp = new PageReference('/' + opp.id);
        newocp.setRedirect(true);
        return newocp;
    }
}