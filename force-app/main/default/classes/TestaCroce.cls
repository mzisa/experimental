// This class simulates the "Testa o Croce" italian game

public class TestaCroce {
	final Integer rounds = 1000;
	Integer teste = 0;
	Integer croci = 0;

	public TestaCroce() {
		// Simulates a coin throws 1000 times
		for (Integer counter=0; counter < rounds; counter++)
		{
			Double randomNumber = Math.random();

			if (randomNumber <= 0.5) {
				teste++;
			}
			else
			{
				croci++;
			}
		}

		sendCompletionNotification();
	}

	private void sendCompletionNotification() {
		// Send an email to the Apex job's submitter notifying of job completion.
	   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	   //String[] toAddresses = new String[] {a.CreatedBy.Email};
	   String[] toAddresses = new String[] {'marco.zisa@webresults.it'};
	   mail.setToAddresses(toAddresses);
	   mail.setSubject('TestaCroce simulazione:' + System.now());
	   mail.setPlainTextBody('Numero di volte che è uscito TESTA:' + teste +
	   		'\nNumero di volte che è uscito CROCE:' + croci);
	   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}