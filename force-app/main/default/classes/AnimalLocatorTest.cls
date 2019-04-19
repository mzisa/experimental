@isTest
public with sharing class AnimalLocatorTest {
    @isTest static void testGetCallout() {
        AnimalLocatorMock mock = new AnimalLocatorMock();
        Test.setMock(HttpCalloutMock.class, mock);
        // Verify that the response received contains fake values
        String actualValue = AnimalLocator.getAnimalNameById(1);
        String expectedValue = 'chicken';
        System.assertEquals(actualValue, expectedValue );
    }
}