// This class creates queue a new account creation
// Once the account has been created, it chains the request to send an email
// to confirm the account was created properly

public with sharing class ApexQueueAccountCreation implements Queueable {
	public void execute(QueueableContext context) {
		Account a = new Account(Name='Manitto Cars',Phone='(415) 555-1214');
        insert a;

        ID jobID = System.enqueueJob(new AqSendMailAfterCreation('Manitto Cars'));
	}

	// Command line example for this class
	// ID jobID = System.enqueueJob(new ApexQueueAccountCreation('[Account name]'));
}