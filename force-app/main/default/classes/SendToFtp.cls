public with sharing class SendToFtp {
	public Document document {
    	get {
      		if (document == null) document = new Document();
      	return document;
    	}
    	set;
	}
 
	public PageReference upload() {
    	try {
    		//insert document;
    		String base64Content = EncodingUtil.base64Encode(document.body);
    		String theFileName = document.name;
    		SendToFtp.doSendToFtp(theFileName, base64Content, 'zisa', 'Wrts2018');
    	} 
    	catch (Exception e) {
      		ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
      		return null;
    	}
    	finally {
    		document.body = null; // clears the viewstate
      		document = new Document();
    	}
    	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully to FTP'));
    	return null;
	}

	private static void doSendToFtp(String fileName, String base64Content, String user, String pass) {
		String ENDPOINT = 'http://dev.wrts.net/sfdc-formtask2/SendToFtpWs/SendToFtpWS.asmx';
		String soap='';
		soap+= '<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">';
	    soap+= '<x:Header/>';
	    soap+= '<x:Body>';
	    soap+= '<tem:PostDataToFtp>';
	    soap+= '<tem:fileName>' + fileName + '</tem:fileName>';
	    soap+= '<tem:base64Content>' + base64Content + '</tem:base64Content>';
	    soap+= '<tem:user>' + user + '</tem:user>';
	    soap+= '<tem:pass>' + pass + '</tem:pass>';
	    soap+= '</tem:PostDataToFtp>';
	    soap+= '</x:Body>';
		soap+= '</x:Envelope>';
		
		HttpRequest req = new HttpRequest();
	    req.setEndpoint(ENDPOINT);
	    req.setMethod('POST');
	    req.setBody(soap);
	    req.setHeader('Content-Type', 'text/xml; charset=utf-8');
	    req.setHeader('SOAPAction', 'http://tempuri.org/PostDataToFtp');
	    Http http = new Http();
	    HTTPResponse res = http.send(req);
	    System.debug('risp=' + res.getBody());
	}
}