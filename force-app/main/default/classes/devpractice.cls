public class devpractice {
    
   
    
    /* public static void method(List<Account> acclist) {
        List<Contact> conlist = new List<Contact>();
        
        for (Account acc : acclist) {
            if (acc.Phone == '123') {
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                con.Phone = acc.Phone;
                conlist.add(con);
            }
        }
        
        if (!conlist.isEmpty()) {
            insert conlist;
        }
    } */
    
    
    // without trigger code 
    
    public static void accountupdate(){
        Map<Id,Account> mapids = new Map<Id,Account>();
        List<Account> acc = [select id,Phone from Account];
        for(Account acclist : acc){
            mapids.put(acclist.Id,acclist);
        }
        List<Contact> con = [select id,AccountId ,phone from Contact where AccountId IN: mapids.keyset()];
        for(Contact conlist1 : con){
            Account acc2 = mapids.get(conlist1.AccountId);
            conlist1.phone=acc2.phone;
            
        }
        update con;
        
        
        
    }

}