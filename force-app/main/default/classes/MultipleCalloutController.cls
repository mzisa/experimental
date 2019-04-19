public with sharing class MultipleCalloutController {
    // Unique labels collection for the request
    public List<String> requestLabels;
    
    // Result of first callout
    public List<String> results {get;set;}

    // Endpoints of long-running service
    private static final String LONG_RUNNING_SERVICE_URL = 'http://dev.wrts.net/sfdc-formtask2/Web_services_Task/FattureWS.asmx';
           
    // Action method
    public Object startRequestsInParallel() {
        // Create continuation with a timeout
        Continuation con = new Continuation(60);
        // Set callback method
        con.continuationMethod='processAllResponses';
      
        for (Integer rounds=0; rounds < 10; rounds++) {
            // Create callout request
            String s='<soapenv:Envelope xmlns:soapenv="<a href=\'http://schemas.xmlsoap.org/soap/envelope/"\' target="_blank" rel="nofollow">' + 
                'http://schemas.xmlsoap.org/soap/envelope/"</a> ><soapenv:Header>headers here,refer WSDL</soapenv:Header><soapenv:Body> ' + 
                'request body.Refer WSDL</soapenv:Body></soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(LONG_RUNNING_SERVICE_URL);
            req.setMethod('POST');
            req.setBody(s);
            req.setHeader('Content-Type', 'text/xml');
            req.setHeader('SOAPAction', '""');

            // Add callout request to continuation
            this.requestLabels.add(con.addHttpRequest(req));
        }
          
        // Return the continuation
        return con;  
    }
    
    // Callback method.
    // Invoked only when responses of all callouts are returned.
    public Object processAllResponses() {
        for (Integer rounds=0; rounds < 10; rounds++)
        {
            // Get the response of the requests
            HttpResponse response = Continuation.getResponse(this.requestLabels[rounds]);
            this.results.add(response.getBody());
            System.debug('risposta' + rounds + '=' + this.results[rounds]);
        }
                 
        // Return null to re-render the original Visualforce page
        return null;
    }
}