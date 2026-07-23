public class Wrapperclass {
    
    public class Wrapperexample {
        public list<Account> acclist;
        public contact con;
        
            
        
    } 
    public void accdata (){
        Wrapperexample wr = new Wrapperexample();
        wr.acclist=[select id ,Name from Account ];
        Contact c = new Contact();
        c.LastName = 'abc';
        insert c;
        wr.con = c;
    }
    

   
}