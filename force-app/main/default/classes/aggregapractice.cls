public class aggregapractice {
    public static void countcases (list<Case> caselist ){
         set<Id> accids = new set<Id>();
       
        for(Case ca : caselist){
            
                accids.add(ca.ContactId);
            
        }
         List<Contact> listcon = new List<Contact>();
       AggregateResult[] aggres = [select ContactId conid, Count(Id) countcase from Case where ContactId in : accids  Group By ContactId];
        for(AggregateResult res : aggres){
            
      
            
          Id contactId = (Id)res.get('conid');
            Integer countcase = (Integer)res.get('countcase');
            Contact cs = new Contact (Id = contactId,Total_Case_Count__c=countcase);
            
            listcon.add(cs);
        }
        
       
update listcon;
            
        
    }

}

 /*  map<Id,Integer> mapids = new map<Id,Integer>();
        for(AggregateResult res : aggres){
            mapids.put((Id)res.get('conid'),(Integer)res.get('countcase'));
            
        }
        List<Contact> listcon = new List<Contact>();
        List<Contact> updatecontacts = [select id,Total_Case_Count__c from Contact where id in : mapids.keyset()];
        for(Contact c : updatecontacts){
            c.Total_Case_Count__c=mapids.get(c.Id);
            listcon.add(c);
        } */
                   
         /*   Contact con = new Contact();  
            con.Id=(Id)res.get('ContactId');
            con.Total_Case_Count__c=(Integer)res.get('countcase');
            system.debug('size' + con.Total_Case_Count__c );
            updatecontacts.add(con);  */