@isTest
private class TestRestrictContactByName {
    @isTest static void CheckContactValidity() {
        Contact testContact = new Contact(LastName='invalidname');
        insert testContact;
    }
}