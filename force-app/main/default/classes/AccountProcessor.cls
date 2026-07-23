public class AccountProcessor {
    @Future
    public static void countContacts(List<Id> accids ){
        List<Account> acclist =[select id,Number_Of_Contacts__c,(select id,AccountId from Contacts) from Account Where ID IN: accids];
        for(Account acc:acclist){
            acc.Number_Of_Contacts__c=acc.Contacts.size();
        }
        
        update acclist;
    }

}