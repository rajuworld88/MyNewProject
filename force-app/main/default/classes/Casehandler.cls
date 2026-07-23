//  Create an Apex trigger that rolls up the total number of related Cases to a custom field on the Contact object.

public class Casehandler {
    public static void totalcasecountonContact (List<Case> caselist,map<Id,Case> oldmaps){
        set<Id> accids = new set<Id>();
       
        for(Case ca : caselist){
            
            // if(oldmap.get(ca.Id).ContactId != ca.ContactId){
            // accids.add(ca.ContactId)
            //  }
            
            
                accids.add(ca.ContactId);
            
          
        }
        List<Contact> updatecontacts = new List<Contact>();
        List<Contact> conlist = [select id,Total_Case_Count__c ,(select id,ContactId from Cases) from Contact where Id In: accids] ;
        for(Contact con : conlist){
            
             con.Total_Case_Count__c = con.Cases.size();
            updatecontacts.add(con);
        }
        
       
            update updatecontacts;
        
            
        
    }
    // 11.Write a trigger when ever case has been inserted then put the latest case number to the Account filed.

     public static void latestcaseonaccount (List<Case> caselist){
        set<Id> accids = new set<Id>();
        for(Case cs : caselist){
            accids.add(cs.AccountId);
        }
        List<Account> accupdate = new List<Account>();
       List<Account> accountList = [
        SELECT Id, Latest_Case_Number__c,
               (SELECT CaseNumber FROM Cases ORDER BY CreatedDate DESC LIMIT 1)
        FROM Account
        WHERE Id IN :accids ];
        
           for(Account a:accountList){
           
            if(a.Cases.size() > 0){
            a.Latest_Case_Number__c = a.Cases[0].CaseNumber;
            accupdate.add(a);
             
            }
        }
        if(!accupdate.isempty()){
          update accupdate;  
        }
       
    }
    // When a case is created and its origin is Email, assign the case to a specific queue or user using Apex Trigger.
    public static void AutoAssignCase(List<case> caselist3){
        for(Case css : caselist3){
            if(css.Origin == 'Email' && css.Origin != Null) {
                
                
                
            }
        }
        
    }


}