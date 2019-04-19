public class Line {
    // Indice per ciascuna riga
    public Integer num {get; set;}
    
    // Account object
    public Account account {get; set;}
    public Contact contact {get; set;}
            
    // Campi d’appoggio
    public String externalKey {get; set;}
    public String name {get; set;}
    public String phone {get; set;}
    public String fax {get; set;}
    public String billingState {get; set;}
    public String billingCountry {get; set;}
    public string owner {get; set;}
    public string ownerId {get; set;}
    
    public String contactId {get; set;}
    public String contactFirstName {get; set;}
    public String contactLastName {get; set;}
    public String contactEmail {get; set;}
    public String contactPhone {get; set;}
    public String contactMobile {get; set;}
    
    // Check sulle condizioni d'errore
    public Boolean name_error {get; set;}
    public Boolean phone_error {get; set;}
    public Boolean fax_error {get; set;}
    public Boolean billingState_error {get; set;}
    public Boolean billingCountry_error {get; set;}
    public Boolean owner_error {get; set;}
    
    public Boolean contactFirstName_error {get; set;}
    public Boolean contactLastName_error {get; set;}
    public Boolean contactEmail_error {get; set;}
    public Boolean contactPhone_error {get; set;}
    public Boolean contactMobile_error {get; set;}
    
    // Costruttore
    public Line(List<String> element, Integer rowNum) {
        num = rowNum;
        externalKey = element.get(0);
        name = element.get(1);
        phone = element.get(2);
        fax = element.get(3);
        billingState = element.get(4);
        billingCountry = element.get(5);
        owner = element.get(6);
        contactFirstName = element.get(7);
        contactLastName = element.get(8);
        contactEmail = element.get(9);
        contactPhone = element.get(10);
        contactMobile = element.get(11);
    }
}