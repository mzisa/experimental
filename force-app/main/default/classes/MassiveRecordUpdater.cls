// This class performs a massive record update on the given Entity using the given query as record selection criterion

global class MassiveRecordUpdater implements Database.Batchable<sObject> {
	final String query;
	final String entity;
	final String fieldToUpdate;
	final String newValue;
	
	global MassiveRecordUpdater(String pQuery, String pEntity, String pField, string pValue) {
		query=pQuery;
		entity=pEntity;
		fieldToUpdate=pField;
		newValue=pValue;
		// HioSxaSfhclsfhrw000rrtdr!
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		for (sObject o : scope) {
			o.put(fieldToUpdate, newValue);
		}
		update scope;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
}