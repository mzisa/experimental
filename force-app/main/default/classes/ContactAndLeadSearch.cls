public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String pSearch)
    {
        List<List<sObject>> soslQuery = [FIND :pSearch IN NAME FIELDS 
                                         RETURNING Contact(FirstName, LastName WHERE FirstName=:pSearch OR LastName=:pSearch), 
                                         Lead(FirstName, LastName WHERE FirstName=:pSearch OR LastName=:pSearch)];
        return soslQuery;
    }
}