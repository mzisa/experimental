public class AccountHandler {
    public static Account insertNewAccount(string acctName) {
        Account acct = new Account(Name=acctName);
        
        try {
            insert acct;
        }
        catch(DmlException ex)
        {
            System.debug('You must put a valid Account Name');
            return null;
        }
        
        System.debug('New Account is:' + acct.Name);
        return acct;
    }
}