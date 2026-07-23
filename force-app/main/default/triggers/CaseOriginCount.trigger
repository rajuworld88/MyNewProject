trigger CaseOriginCount on Case (after insert,after update,after delete,after undelete) {
    
    
    if(trigger.isafter ){
        if(trigger.isinsert || trigger.isupdate || trigger.isdelete || trigger.isundelete){
               if(trigger.new != null){
        
        
    // Casehandler.totalcasecountonContact(trigger.new,trigger.oldmap);
       // aggregapractice.countcases(trigger.new);
            Casehandler.latestcaseonaccount(Trigger.new);       
    }
            
                   if(trigger.old != null){
        
        
    // Casehandler.totalcasecountonContact(trigger.old,trigger.oldmap);
      //  aggregapractice.countcases(trigger.old);
    }
        }
    }
 
    
}