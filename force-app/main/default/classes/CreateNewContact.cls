public class CreateNewContact {
    public static void create(String fn, String ln, String account) {
        Contact cont = new Contact(FirstName=fn, LastName=ln, AccountId=account);
        insert cont;
    }
}