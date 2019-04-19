public with sharing class MerchandiseCallout {
	public MerchandiseCallout() {
		
	}
	
	public String getMerchandise() {
		HttpRequest req = new HttpRequest();
		
		//req.setEndpoint('https://eu11.salesforce.com/services/apexrest/Merchandise/a0J0Y0000006kGl');
		//req.setEndpoint('https://mytestmz01-developer-edition.eu11.force.com/wstest01/services/apexrest/Merchandise/a0J0Y0000006kGl');
		req.setEndpoint('https://mztestinglightning-dev-ed.my.salesforce.com/services/apexrest/Merchandise/a0J0Y0000006kGl');
		req.setMethod('GET');
		
		String authorizationHeader = 'Bearer ' + UserInfo.getSessionId();
		req.setHeader('Authorization', authorizationHeader);
		
		Http http = new Http();
		HttpResponse res = http.send(req);
		
		System.debug(authorizationHeader);
		return res.getBody();
	}
}