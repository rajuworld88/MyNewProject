@isTest
public class bOMComparisonTest {

    @isTest
    static void testCompareBoMAndDisti() {
       
        List<BoM__c> bomList = new List<BoM__c>{
            new BoM__c(Part_Number__c = 'PN001', Quantity__c = 10),
            new BoM__c(Part_Number__c = 'PN002', Quantity__c = 15), 
            new BoM__c(Part_Number__c = 'PN004', Quantity__c = 25)  
        };
        insert bomList;

        List<Disti__c> distiList = new List<Disti__c>{
            new Disti__c(Part_Number__c = 'PN001', Quantity__c = 10),
            new Disti__c(Part_Number__c = 'PN003', Quantity__c = 20),  
            new Disti__c(Part_Number__c = 'PN004', Quantity__c = 30)  
        };
        insert distiList;

   
        Test.startTest();
        bOMComparison.compareBoMAndDisti();
        Test.stopTest();

     
        List<Unified_List__c> unifiedListRecords = [
            SELECT BoM_Part_Number__c, Disti_Part_Number__c, Error_Flag__c 
            FROM Unified_List__c
        ];
        
  
        System.assert(unifiedListRecords.size() == 4, 'Expected 4 Unified_List__c records to be inserted.');

 
        Integer errorCount = 0;
        for (Unified_List__c record : unifiedListRecords) {
            if (record.Error_Flag__c == true) {
                errorCount++;
            }
        }
        
   
        System.assertEquals(3, errorCount, 'Expected 3 records with Error_Flag__c set to true.');
    }
    
    
    
    
     @isTest
    static void testCompareAndFetchRecords() {
        // Create test BoM and Disti records
        insert new BoM__c(Part_Number__c = 'PN001', Quantity__c = 10);
        insert new Disti__c(Part_Number__c = 'PN001', Quantity__c = 10);

        // Insert a record into Unified_List__c to simulate the comparison result
        insert new Unified_List__c(BoM_Part_Number__c = 'PN001', BoM_Quantity__c = 10, Disti_Part_Number__c = 'PN001', Disti_Quantity__c = 10, Error_Flag__c = false);

        // Initialize the controller
        ApexPages.StandardController sc = new ApexPages.StandardController(new Unified_List__c());
        BoMAndDistiComparisonController controller = new BoMAndDistiComparisonController(sc);

        // Call the compareAndFetchRecords method
        controller.compareAndFetchRecords();

        // Verify that unifiedListRecords is populated
        System.assertNotEquals(null, controller.unifiedListRecords, 'Unified list records should not be null.');
        System.assertEquals(1, controller.unifiedListRecords.size(), 'Expected 1 Unified_List__c record.');
    }
    
}