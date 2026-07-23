@isTest
public class OpportunityHandlerclassTest {
  @isTest
    public static void updateStageFieldTest() {
        List<Opportunity> testOpps = new List<Opportunity>();
        
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opp ' + i;
            opp.Amount = 2000000; // Set the amount to greater than $1,000,000
            opp.StageName =  'Closed Won';
            testOpps.add(opp);
        }
        
        Test.startTest();
        update testOpps;
        Test.stopTest();
        
        List<Opportunity> updatedOpps = [SELECT Id, StageName FROM Opportunity WHERE Id =:testOpps[0].Id];
        
        for (Opportunity opp : updatedOpps) {
            System.assertEquals( 'Closed Won', opp.StageName);
        }
    }}