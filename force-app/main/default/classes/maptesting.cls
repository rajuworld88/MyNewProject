public class maptesting {
    // to store the  accoount id and there names to quick retrivel
    public static void accountmapp(){
        map<Id,String> mapids = new Map<Id,String>();
       
           List<Account> acclist = [SELECT Id, Name FROM Account];
        
        for(Account a :acclist){
            mapids.put(a.Id,a.Name);
      
            
        }
        
        for(Id accid : mapids.keyset()){
            system.debug('account id' + accid + ' , Account Name' + mapids.get(accid));
            
        }
        
    }
    
    
    public static void accmp (){
        map<Id,Account> mapids2 = new Map<Id,Account>();
        List<Account> accdata =[select id,Name,Phone from Account];
            for (Account acc : accdata) {
            mapids2.put(acc.Id, acc);
        }
       
        for(Id accids2 : mapids2.keyset()){
            Account ac = mapids2.get(accids2);
            system.debug('account id :'+accids2 + 'Name:'+ac.Name +', Phone:  :'+ac.Phone);
        }
    }
    
    
    // List<account ,list<contact>>
    public static void maptest(){
        map<Account, List<Contact>> mapacccon = new map<Account, List<Contact>>();
        List<Account> accda = [select id,name from Account];
        for(Account a : accda){
            List<Contact> conda = [select id,FirstName  FROM Contact WHERE AccountId = :a.Id];
            mapacccon.put(a,conda);
            
        }
        for(Account acd :mapacccon.keyset()){
            system.debug('account name'+acd.Name);
            for(Contact c : mapacccon.get(acd)){
                system.debug('conid'+ c.id +',  firstname '+ c.FirstName);
            }
        }
    }
    
    public static void recordcount1(){
        Integer recordcount = [select count() from Account];
        system.debug('records count'+recordcount);
    }

}