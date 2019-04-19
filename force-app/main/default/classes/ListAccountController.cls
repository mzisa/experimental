public with sharing class ListAccountController {
    private final Account acct;
    
    private Integer index = 0;
    private Integer blockSize = 20;
    private Integer totalRecs = 0;
    
    public String contextAccount {get;set;}
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public ListAccountController(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        totalRecs = [SELECT COUNT() From Account];
        
        try
        {
        	contextAccount = acct.Id;    
        }
        catch(Exception ex) {
            contextAccount = null;
        }
        
        try {
            index = Integer.valueOf(System.currentPageReference().getParameters().get('currentIndex'));
        }
        catch(Exception ex) {
            index = 0;
        }
    }
    
    public List<Account> getAccountPagination() {
       	List<Account> accts = [SELECT Name FROM Account ORDER BY Name LIMIT :blockSize OFFSET :index];
       	return accts;
    }
    
    public void beginning() {
        index = 0;
    }
    
    public void previous() {
        index = index - blockSize;
    }
    
    public void next() {
        index = index + blockSize;
    }
    
    public void end() {
        index = totalrecs - math.mod(totalRecs,blockSize);
    }
    
    public boolean getPreceed() {
        if (index == 0) return true; else return false;
    }
    
    public boolean getFollow() {
        if ((index+blockSize) > totalRecs ) return true; else return false;
    }
    
    public PageReference redirectToAccountDetail() {
        PageReference newocp = new PageReference(CustomPath__c.getInstance('PathToDettagliAccount').RelativePath__c + contextAccount);
        newocp.setRedirect(true);
        return newocp;
    }
    
    public PageReference toggleDetail() {
        contextAccount = System.currentPageReference().getParameters().get('passTheAccountId');
        
        PageReference newocp = new PageReference(CustomPath__c.getInstance('PathToListAccount').RelativePath__c + contextAccount + '&currentIndex=' + index);
        newocp.setRedirect(true);
        return newocp;
    }
    
    public void closeDetail() {
        contextAccount = null;
    }
    
}