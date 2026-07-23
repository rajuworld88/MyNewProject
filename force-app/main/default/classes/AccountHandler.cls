public class AccountHandler {
    public static void UpdatedividedAmount(List<Account> acclist ,Map<Id,Account> oldmaps){
        set<Id> accids = new set<Id>();
        for(Account acc : acclist){
            if(oldmaps.get(acc.Id).Amount__c != acc.Amount__c){
                      accids.add(acc.Id);
            }
       }
        List<Contact> condata= new List<Contact>();
         System.debug('before Query : ' + Limits.getHeapSize());
        
        List<Account> accdata = [select id,Amount__c ,(select id,AccountId,Devided_Amount__c from Contacts)from Account where Id In :accids];
        
        System.debug('After Query : ' + Limits.getHeapSize());
        
        for(Account acc : accdata){
            if(acc.Contacts.size()>0){
                Decimal DevidedAmount=acc.Amount__c / acc.Contacts.size();
                for(Contact con : acc.Contacts){
                    con.Devided_Amount__c=DevidedAmount;
                    condata.add(con);
                }
            }
        }
        if(!condata.isempty()){
            
            update condata;
        }
            
    }
    public static Account insertNewAccount(String name){
        Account acc = new Account();
        acc.name = name;
        try {
            insert acc;
            return acc;
        }
        Catch (Exception e){
            return null;
        }
            
        }
    public static void preventionofaccdeletion (List<Account> preacclist){
        set<Id> accids = new set<Id>();
        for(Account preacc  : preacclist){
            accids.add(preacc.Id);
        }
         List<Contact> preconlist = [select id,AccountId from Contact where AccountId IN:accids Limit 1];
        For(Account ap : preacclist){
            ap.AddError('you cant delete if you have a relted contact');
        }
    }
    // 
//17.Write a trigger when ever Account phone is updated then update that phone number to all related contacts phone number.
    public static void updatephoneallcontacts(List<Account> acclist,map<Id,Account> oldmaps){
        set<Id> accids = new set<Id>();
        for(Account acc : acclist){
            if(oldmaps.get(acc.Id).Phone != acc.Phone){
                accids.add(acc.Id);
            }
        }
        List<Contact> contsupdate = new List<Contact>();
        List<Account> acclist12 = [select id,Phone ,(select id ,AccountId,phone from Contacts) from Account where Id  IN : accids];
        for(Account a : acclist12){
            for(Contact c : a.Contacts){
                if(c.AccountId != null){
                    c.Phone = a.Phone;
                    contsupdate.add(c);
                }
            }
            if(!contsupdate.isempty()){
                update contsupdate;
            }
        }
        
    }
    
    //  Problem Statement:
//When an Account's Type is changed to 'Customer', count the number of related active Contacts and update a
//custom field Total_Contacts__c on the Account. The logic must be bulk-safe and avoid unnecessary DML.
   public static void contactscountonacc(List<Account> accconlist, Map<Id,Account> oldmaps){

    Set<Id> accids = new Set<Id>();

    for(Account ac : accconlist){
        Account olddata = oldmaps.get(ac.Id);

        if(olddata != null &&
           olddata.Type != 'Customer - Direct' &&
           ac.Type == 'Customer - Direct'){
            accids.add(ac.Id);
        }
    }

    if(accids.isEmpty()) return;

    Map<Id, Integer> mapids = new Map<Id, Integer>();

    for(AggregateResult agr : [
        SELECT AccountId, COUNT(Id) totalcontacts
        FROM Contact
        WHERE AccountId IN :accids
       
        GROUP BY AccountId
    ]) {
        mapids.put((Id)agr.get('AccountId'), (Integer)agr.get('totalcontacts'));
    }

    List<Account> acclist = new List<Account>();

    for(Id accid : accids){
        Account a = new Account();
        a.Id = accid;

        a.related_contats_on_account__c =
            mapids.containsKey(accid) ? mapids.get(accid) : 0;

        acclist.add(a);
    }

    update acclist;
}
    
    Public static void processApprovedAccounts(List<Account> accaccounts , map<Id,Account> oldmaps){
        set<Id> accids = new set<Id>();
        for(Account a : accaccounts){
            Account olddata = oldmaps.get(a.Id);
            if(a.Status2__c =='Approved' && olddata.Status2__c !=  'Approved'){
                accids.add(a.Id);
            }
        }
        List<Id> acclist = new List<Id>(accids);
        AccountFutureclass.createFollowupTasks(acclist);
    }
}