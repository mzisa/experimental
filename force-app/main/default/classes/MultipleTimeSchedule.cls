public with sharing class MultipleTimeSchedule {
	public MultipleTimeSchedule(Integer startDay, Integer startMonth, Integer startHour, Integer startMinute, Integer rounds) {
		for (Integer iterator=0; iterator < rounds; iterator++)
		{
			TestaCroceScheduler tcs = new TestaCroceScheduler();
			Integer cronMinute =  Math.mod(startMinute + iterator, 60);

			String schedule = '0 ' + 
				String.valueOf(cronMinute) + ' ' + 
				String.valueOf(startHour) + ' ' + 
				String.valueOf(startDay) + ' ' + 
				String.valueOf(startMonth) + ' ?';

			System.schedule('TestaCroceRunFromApex' + iterator, schedule, tcs);
		}
	}

	// Command line example:
	// MultipleTimeSchedule mts = new MultipleTimeSchedule(17,3,15,55,3);
	// This runs on March 17th at 15:55, 15:56 and 15:57 (3 times total: once per minute)
}