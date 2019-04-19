// This class runs the MassiceRecordUpdater once a minute via System.scheduleBatch method.
// This class basically enqueue a new job instance to run only once after a minute

public with sharing class MassiveRecordUpdaterScheduler {
	public MassiveRecordUpdaterScheduler() {
		String query = 'SELECT description FROM Account LIMIT 10';
		String entity = 'Account';
		String field = 'description';
		String value = 'Ehi! Campo aggiornato nuovamente alle ' + System.now();

		MassiveRecordUpdater mru = new MassiveRecordUpdater(query, entity, field, value);
		
		String cronID = System.scheduleBatch(mru, 'MassiveRecordUpdater', 1);

		CronTrigger ct = [SELECT Id, TimesTriggered, NextFireTime
		                FROM CronTrigger WHERE Id = :cronID];

		// TimesTriggered should be 0 because the job hasn't started yet.
		System.assertEquals(0, ct.TimesTriggered);
		System.debug('Next fire time: ' + ct.NextFireTime); 
		// For example:
		// Next fire time: 2013-06-03 13:31:23
	}
}