Global class MonthlyRentBatch implements Database.Batchable<SObject> {
    
    Global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select Id, Monthly_Rent__c,Status__c from Tenant__c where Status__c = \'Active\'');
    }
    
    Global Void Execute ( Database.BatchableContext bc  , List<Tenant__c> tenantlist){
        List<Payment__c> paylist = new List<Payment__c>();
        for(Tenant__c tnt : tenantlist){
            Payment__c pmt = new Payment__c();
            pmt.Tenant__c= tnt.Id;
            pmt.Amount__c=tnt.Monthly_Rent__c;
            pmt.Status__c='Pending';
            pmt.Payment_Date__c=Date.today().addDays(5);
            paylist.add(pmt);
        }
        if(!paylist.isempty()){
            insert paylist;
        }
    }
    Global void finish (Database.BatchableContext bc){
        
    }
    }