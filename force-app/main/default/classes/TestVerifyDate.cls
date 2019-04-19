@isTest
private class TestVerifyDate {
	@isTest static void CheckDatesWithin30Days() {
        Date date1 = Date.newInstance(2016, 10, 25);
        Date date2 = Date.newInstance(2016, 11, 18);
        VerifyDate.CheckDates(date1, date2);
    }
    
    @isTest static void CheckDatesNotwithin30days() {
        Date date1 = Date.newInstance(2016, 10, 25);
        Date date2 = Date.newInstance(2016, 11, 28);
        VerifyDate.CheckDates(date1, date2);
    }
}