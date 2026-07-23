@isTest
global class AnimalLocatorTest { 

    @isTest
    static void testValidAnimalResponse() {
        // Set up the mock response for a valid animal
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        // Test the method with a valid ID
        String result = AnimalLocator.getAnimalNameById(1);
        String expectedResult = 'cow';

        // Assert that the result is as expected
        System.assertEquals(result, expectedResult, 'Expected animal name does not match.');
    }
    
    @isTest
    static void testInvalidAnimalResponse() {
        // Set up the mock response for an invalid animal (missing name key)
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMockInvalidResponse());

        // Test the method with an invalid response
        String result = AnimalLocator.getAnimalNameById(999);
        String expectedResult = 'Error: Unable to fetch animal details';

        // Assert that the result is as expected
        System.assertEquals(result, expectedResult, 'Expected error message does not match.');
    }
}