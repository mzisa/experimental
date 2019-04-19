public with sharing class DettagliAccountController {
	private final Account acct;
    public Boolean contactIsShowed {get; set;}
    public Boolean opportunityIsShowed {get; set;}
    public String descriptionForContactToggle {get; set;}
    public String descriptionForOpportunityToggle {get; set;}

	public String serializedAccount { 
        get {
            AccountForJson element = new AccountForJson(acct.Id);
            return AccountForJson.doSerialize(element);
        } 
    }
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public DettagliAccountController(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        descriptionForContactToggle = Label.Mostra_contatti;
        descriptionForOpportunityToggle = Label.Mostra_opp;
        contactIsShowed = false;
        opportunityIsShowed = false;
    }
    
    public void toggleContacts() {
        if (contactIsShowed)
        {
        	descriptionForContactToggle = Label.Mostra_contatti;
        }
        else
        {
            descriptionForContactToggle = Label.Nascondi_contatti;
        }
        
        contactIsShowed = !contactIsShowed;
    }
    
    public void toggleOpportunities() {
        if (opportunityIsShowed)
        {
        	descriptionForOpportunityToggle = Label.Mostra_opp;
        }
        else
        {
            descriptionForOpportunityToggle = Label.Nascondi_opp;
        }
        
        opportunityIsShowed = !opportunityIsShowed;
    }
    
    public PageReference doSerialize() {
        Map<String,CustomPath__c> allCodes = CustomPath__c.getAll();
        
        PageReference newocp = new PageReference(allCodes.get('PathToExportJSON').RelativePath__c + acct.Id);
        newocp.setRedirect(true);
        return newocp;
    }
}