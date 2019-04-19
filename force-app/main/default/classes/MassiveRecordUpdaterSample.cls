public with sharing class MassiveRecordUpdaterSample {
	public MassiveRecordUpdaterSample() {
		String query = 'SELECT description FROM Account LIMIT 10';
		String entity = 'Account';
		String field = 'description';
		String value = 'Ehi! Campo aggiornato';

		MassiveRecordUpdater mru = new MassiveRecordUpdater(query, entity, field, value);
		Id batchInstanceId = Database.executeBatch(mru);
	}
}