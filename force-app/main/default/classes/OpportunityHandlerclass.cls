public class OpportunityHandlerclass {
   

    
    public static void updatestagefield(List<Opportunity>  opplist){
 List<Opportunity> oppdata = new List<Opportunity>();
 for(Opportunity opp : opplist){
 if(opp.Amount > 1500000){
 opp.StageName = 'Closed Won';
 oppdata.add(opp);
   }
 }
        update oppdata;
    }

public static void updateavarageamout(List<Opportunity> opplist2 , map<Id,Opportunity> oldmaps){
 set<Id> accids = new set<Id>();
for(Opportunity opp : opplist2){
accids.add(opp.AccountId);
}
List<Account> updateacc = new List<Account>();

List<Account> acclist =[select id, averageAmount__c ,(select id,Amount,AccountId from Opportunities) from
 Account where Id IN: accids];
 for(Account a : acclist){
 Decimal TotalAmount= 0;
 for(Opportunity op : a.Opportunities){
 TotalAmount += op.Amount;
 
// a.averageAmount__c= TotalAmount/op.size();
 updateacc.add(a);
 
}
 
}
update updateacc;
}
    
    
    
    
   // A Sales Organization wants to track the largest Opportunity associated with each of its Accounts.
    //  This information could be used to prioritize sales efforts, allocate resources, or identify opportunities for 
    //  cross-selling or upselling.

    //Pre Work: Create a Custom field on Account Object named maxOpp__c (Text) to store Opportunity Name.
 
    public static void tracklargestopp (List<Opportunity> opplist1,map<Id,Opportunity> oldmpasss){
        set<Id> accids = new set<Id>();
        
        for (Opportunity o : opplist1){
             if (oldmpasss.get(o.Id) != null && oldmpasss.get(o.Id).AccountId != o.AccountId) {
            accIds.add(o.AccountId);
             }}
    List<Account> listToUpdate = new List<Account>();
    
        
        
        List<Account> accList = [SELECT Id, maxOpp__c,
                         (SELECT Name, Amount FROM Opportunities WHERE Amount != null ORDER BY Amount DESC LIMIT 1)
                         FROM Account WHERE Id IN :accIds];

        
        
        for (Account acc : accList) {
 
    if (acc.Opportunities.size() > 0) {
         acc.maxOpp__c = acc.Opportunities[0].Name;
        
        listToUpdate.add(acc);
    }


}
        if(!listToUpdate.isempty()){
            update listToUpdate;
        }
    }


//  When a Opportunity Stage (field) is changed, create a Task record onOpportunity and
//   assign it to Logged In User/Opportunity Owner / Any User.

    public static  void createtakandassigntouser (List<Opportunity> opplist3,map<id,Opportunity> oldMap){
        List<Task> tList = new List<Task>();
    
    for (Opportunity opp : opplist3) {
      
        if (opp.StageName != oldMap.get(opp.Id).StageName) {
            Task t = new Task();
            t.WhatId = opp.Id;
            t.Subject = 'Follow up on Stage Change'; // Change the subject if necessary
            t.Priority = 'Normal';
            t.Status = 'Not Started'; 
            t.OwnerId = UserInfo.getUserId(); 
            tList.add(t); 
        }
    }

    
    if (!tList.isEmpty()) {
        insert tList;
    }
    }



//  7.Write a trigger when ever opportunity stageName is closed won then update the Amount to the Annual Revenue of Account.
//  

    public static void updateannualrevenue  (List<Opportunity> opplist12){
        set<Id> acclistids = new set<Id>();
        for(Opportunity oppp : opplist12){
            if(oppp.stageName == 'closed won' && oppp.stageName != null ){
                acclistids.add(oppp.AccountId);
            }
        }
        list<Account> accda = new list<Account>();
        List<Account> acclistdata = [select id,AnnualRevenue from Account where Id IN :acclistids];
        
    
            
        for (Opportunity opp : opplist12) {
            if (opp.StageName == 'Closed Won' && opp.AccountId != null) {
                for (Account acc : acclistdata) {
                    if (acc.Id == opp.AccountId) {
                        opp.Amount = acc.AnnualRevenue;
                        break; // Exit loop once the matching account is found
                    }
                }
            }
        }}
        
      
//  8.Write a Trigger to get the Sum of amount of opportunity of the related Account and update the Amount in the Account field.
//  
    public static void sumofopportunity (List<Opportunity> optyamount){
        set<Id> accids = new set<Id>();
        for(Opportunity opty : optyamount){
            accids.add(opty.AccountId);
            
        }
    List<Account> updateacclist = new List<Account>();
        List<Account> acclist = [ select id,Amount__c,(SELECT AccountId, AMOUNT 
      FROM Opportunities) from Account where Id in :accids ];
        
        for(Account a :acclist){
             Decimal total = 0;
            
        for(Opportunity op : a.Opportunities){
            if(op.Amount!= Null){
                 total += op.Amount;
            }
         
            
          
        }
            
             a.Amount__c=total;
            updateacclist.add(a);
        }
       
        if(!updateacclist.isempty()){
            update updateacclist;
        }
        
        
    }

    
 // 9.Write a Trigger to get the Max and Min amounts of opportunity of the related Account and update the Amount in the Account fields.
  

    public static void OpportunityminmaxAmount (List<Opportunity> opplist){
        set<Id> accids = new set<Id>();
        Map<Id,Account> mapids = new Map<Id,Account>();
        for(Opportunity op :opplist){
            accids.add(op.AccountId);
        }
       
        List<AggregateResult> agrlist = [select AccountId, min(Amount) mini ,max(Amount) max from Opportunity 
                                         where AccountId IN : accids Group by AccountId];
        
    
        List<Account> accupdate = new List<Account>();
        for(AggregateResult agr : agrlist){
            if(agr.get('AccountId') != Null){
        Account a = new Account();
            a.Id=(String)agr.get('AccountId');
           

            a.Max_Amount__c=(Decimal)agr.get('max');
            a.Min__c=(Decimal)agr.get('mini');
            mapids.put(a.Id,a);
            accupdate.add(a);
            }}
        if(!accupdate.isempty()){
            update accupdate;
        }
        
    }














}