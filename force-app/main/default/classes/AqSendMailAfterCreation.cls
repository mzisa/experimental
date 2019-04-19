public with sharing class AqSendMailAfterCreation implements Queueable {
	public String acName = '';

	public AqSendMailAfterCreation(String accountName) {
		this.acName = accountName;
	}

	public void execute(QueueableContext context) {
		// Send an email notifying of job completion
	   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	   //String[] toAddresses = new String[] {a.CreatedBy.Email};
	   String[] toAddresses = new String[] {'marco.zisa@webresults.it'};
	   mail.setToAddresses(toAddresses);
	   mail.setSubject('Account ' + acName + ' created on:' + System.now());
	   mail.setPlainTextBody('L\'account ' + acName + ' è stato creato');
	   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}