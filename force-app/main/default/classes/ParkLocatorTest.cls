@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String[] result = ParkLocator.country('Germany'); 
        // Verify that a fake result is returned
        String[] fakeResponse = new String[]{'Hamburg Wadden Sea National Park','Hainich National Park, Bavarian Forest National Park'};
        System.assertEquals(fakeResponse, result);
    }
}