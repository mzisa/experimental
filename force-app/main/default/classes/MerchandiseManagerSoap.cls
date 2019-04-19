global class MerchandiseManagerSoap {
    WebService static Merchandise__c getMerchandise(String merchId) {
        RestRequest req = RestContext.request;
        //String merchId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Merchandise__c result = [SELECT Name, Description__c, Price__c, Quantity__c
            FROM Merchandise__c
            WHERE Id = :merchId];
        
        return result;
    }
    
    WebService static String createMerchandise(String name, String description, Decimal price, Double inventory) {
        Merchandise__c m = new Merchandise__c(
            Name=name,
            Description__c=description,
            Price__c=price,
            Quantity__c=inventory);
        
        insert m;
        return m.Id;
    }
}