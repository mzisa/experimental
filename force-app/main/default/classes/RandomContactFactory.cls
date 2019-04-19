public class RandomContactFactory {
	public static List<Contact> generateRandomContacts(Integer numContactsToCreate, String aString)
    {
        List<Contact> conList = new List<Contact>();
        for (Integer i=0; i < numContactsToCreate; i++)
        {
        	Contact con = New Contact(FirstName='Test ' + numContactsToCreate, LastName = aString);
            conList.add(con);
        }
        
        return conList;
    }
}