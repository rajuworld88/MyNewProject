@isTest
public class ContactHandlerTest {
    @isTest
    public static void testDuplicateEmailCheck() {
        // Insert a Lead with a specific email
        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead',
            Company = 'Test Company',
            Email = 'duplicate@example.com'
        );
        insert testLead;

        // Try to insert a Contact with the same email
        Test.startTest();
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'duplicate@example.com'
        );

        try {
            insert testContact;
        } catch (DmlException e) {
            System.debug('Actual Error Message: ' + e.getMessage()); // Debugging purpose
            System.assert(e.getMessage().contains('You have already use this email on lead'),  
                'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();
    }
}