public class UploadCSVController {
    private String errorMessages;
    public String nameFile {get; set;}
    public Blob contentFile {get; set;}
    public List<Line> linesToShow {get; set;}
    public List<Line> correctLines {get; set;}
    public List<Line> errorLines {get; set;}
    
    public UploadCSVController() {
        linesToShow = new List<Line>();
        correctLines = new List<Line>();
        errorLines = new List<Line>();
    }
    
    private List<List<String>> parseCSV(String contents) {
        List<List<String>> allFields = new List<List<String>>();
        // replace instances where a double quote begins a field containing a comma
        // in this case you get a double quote followed by a doubled double quote
        // do this for beginning and end of a field
        contents = contents.replaceAll('","', '"DBLQT,DBLQT"');
        
        List<String> lines = new List<String>();
        
        try {
            lines = contents.split('\r\n'); // using carriage return accomodates windows, unix, and mac files
        } catch (System.ListException e) {
            System.debug(logginglevel.ERROR, 'Limits exceeded?' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error while parsing CSV file'));
            errorMessages += ' ' + e.getMessage();
        }

		// Skip first row of the CSV file because it contains the row headers        
        if (lines.size() > 0) lines.remove(0);
    
        for(String line : lines) {
            //Check for blank CSV lines (only commas)
            if(line.replaceAll(',', '').trim().length() == 0)
            continue;
    
            List<String> fields = line.split('DBLQT,DBLQT');
            List<String> cleanFields = new List<String>();
            String compositeField;
            for(String field : fields) {
                System.debug(logginglevel.ERROR, 'DEBUGRF field: ' + field);
                field = field.substring(1, field.length()-1);
                cleanFields.add(field);
            }
        
            System.debug(logginglevel.ERROR, 'DEBUGRF line after: ' + cleanFields);
            allFields.add(cleanFields);
        }
        
        return allFields;
    }
    
    public PageReference readFile() {
        List<List<String>> allLinesFromFile = parseCSV(contentFile.toString());
        Integer rowCounter = 0;
        
        Set<String> ownerKeys = new Set<String>();
        Map<String, Id> ownerMap = new Map<String, Id>();
        
        Set<String> contactKeys = new Set<String>();
        Map<String, Id> contactMap = new Map<String, Id>();
        
        //Init lists
        linesToShow.clear();
        correctLines.clear();
        errorLines.clear();
        
        for (List<String> aFileRow : allLinesFromFile)  {
            Line l = new Line(aFileRow, ++rowCounter);
            linesToShow.add(l);
        }
    
    	for (Line l : linesToShow) {
            // Add owner to owner's list
            ownerKeys.add(l.owner);
            
            // Add contact email to contact keys
            contactKeys.add(l.contactEmail);
        }
        
        // Create a Owners Map
        for (User u : [SELECT Id, External_Key__c FROM User WHERE External_Key__c IN :ownerKeys]) {
            ownerMap.put(u.External_Key__c, u.Id);
        }
        
        // Create Contacts Map
        for (Contact c : [SELECT Id, FirstName, LastName, Email, Phone, MobilePhone FROM Contact WHERE Email IN :contactKeys])
        {
            contactMap.put(c.Email, c.Id);
        }
        
        for (Line l : linesToShow) {
            Boolean ok = true;
            
            //01. Check for owner match
            if (ownerMap.get(l.owner)!=null) {
                l.ownerId = ownerMap.get(l.owner);
            }
            else
            {
                ok = false;
                l.owner_error = true;
            }
            
            //02. Check for account blank fields
            if (String.isBlank(l.name))
            {
                ok = false;
                l.name_error = true;
            }
            
            if (String.isBlank(l.phone))
            {
                ok = false;
                l.phone_error = true;
            }
            
            if (String.isBlank(l.fax))
            {
                ok = false;
                l.fax_error = true;
            }
            
            if (String.isBlank(l.billingState))
            {
                ok = false;
                l.billingState_error = true;
            }
            
            if (String.isBlank(l.billingCountry))
            {
                ok = false;
                l.billingCountry_error = true;
            }
            
            // 03. Check for contact blank fields
            if (String.isBlank(l.contactFirstName))
            {
                ok = false;
                l.contactFirstName_error = true;
            }
            
            if (String.isBlank(l.contactLastName))
            {
                ok = false;
                l.contactLastName_error = true;
            }
            
            if (String.isBlank(l.contactEmail))
            {
                ok = false;
                l.contactEmail_error = true;
            }
            
            if (String.isBlank(l.contactPhone))
            {
                ok = false;
                l.contactPhone_error = true;
            }
            
            if (String.isBlank(l.contactMobile))
            {
                ok = false;
                l.contactMobile_error = true;
            }
            
            //Fill line list with errors and line list without errors
            if (ok) {
                Account a = new Account(Name=l.name, External_Key__c = l.externalKey, Phone = l.phone, 
           			Fax = l.fax, BillingState = l.billingState, BillingCountry = l.billingCountry, OwnerId = l.ownerId);
                
                l.account = a;
                
                Contact contact;
                
                if (contactMap.containsKey(l.contactEmail))
                {
                    contact.FirstName = l.contactFirstName;
                    contact.LastName = l.contactLastName;
                    contact.Phone = l.contactPhone;
                    contact.MobilePhone = l.contactMobile;
                }
                else
                {
                    contact = new Contact(FirstName=l.contactFirstName, 
                    	LastName=l.contactLastName, Email=l.contactEmail, Phone=l.contactPhone, MobilePhone=l.contactMobile);
                }
                
                l.contact = contact;
                correctLines.add(l);
            }
            else
            {
                errorLines.add(l);
            }
        }
        
        //Free heap cloud space
        contentFile = null;
        
        return null;
    }
    
    public PageReference insertObjects() {
        Database.UpsertResult[] resultsAccounts;
        Database.UpsertResult[] resultsContacts;
        
        List<Account> accountsToUpsert = new List<Account>();
        List<Contact> contactsToUpsert = new List<Contact>();
        Set<String> accountsIdInserted = new Set<String>();
        Set<String> contactsIdInserted = new Set<String>();
        
        for (Line l : correctLines)
        {
            if(!accountsIdInserted.contains(l.account.External_Key__c))
            {
                accountsToUpsert.add(l.account);
                accountsIdInserted.add(l.account.External_Key__c);
            }
        }
        
        // Create a system savepoint
        System.savePoint sp = Database.setSavepoint();
        
        // Try to insert the account
        try {
        	resultsAccounts = Database.upsert(accountsToUpsert, Schema.Account.External_Key__c, true);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Accounts were successfully inserted'));
        } 
        catch(Exception e) {
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error in the insertion of the Accounts in the Database'));
        }
            
        // If there are no errors go ahead with inserting the related contact
        if (resultsAccounts!=null  && resultsAccounts[0].getErrors().isEmpty()) {
            // Check for duplicated contacts
            for (Line l : correctLines)
            {
                if (!contactsIdInserted.contains(l.contact.Email)) {
                    l.contact.AccountId = l.account.Id;
                    contactsToUpsert.add(l.contact);
                    contactsIdInserted.add(l.contact.Email);
                }
            }
            
            // Insert contacts related to this account
            try {
                resultsContacts = Database.upsert(contactsToUpsert, Schema.Contact.Id, true);
                
                // if there are no errors, go ahead
                if (resultsAccounts!=null  && resultsAccounts[0].getErrors().isEmpty()) {
                    linesToShow.clear();
                    correctLines.clear();
                    errorLines.clear();
                } 
                else {
                    Database.rollback(sp);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'One or more rows did not insert correctly please check CSV content and try again'));
                }
            }
            catch (Exception e)
            {
                // In case of any errors rollback to previous state
                Database.rollback(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error in the insertion of the Contacts in the Database'));
            }
        }
        
        return null;
    }
}