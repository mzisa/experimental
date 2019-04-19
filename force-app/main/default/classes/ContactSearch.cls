public class ContactSearch {
    public static List<Contact> searchForContacts(string pLastName, string pMailingContact)
    {
        List<Contact> getter = [SELECT Name FROM Contact WHERE LastName=:pLastName AND MailingPostalCode=:pMailingContact];
        return getter;
    }
}