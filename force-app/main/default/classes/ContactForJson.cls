public class ContactForJson {
	private String name;
    private String email;
    
    public ContactForJson(Contact element)
    {
        name = element.Name;
        email = element.Email;
    }
}