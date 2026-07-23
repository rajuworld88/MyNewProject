// we have  a contacts for that they have realated account  for they have same owner id
//  for all if when any data sending or any update happen if change owner id you have to change orgial owner id for this contacts
Global class batchpractice implements Database.Batchable <Sobject> {
    global Database.QueryLocator Start(Database.BatchableContext bcontext){
        string Query = 'Select id,OwnerId,Account.OwnerId, from Contact where AccountId != Null AND OwnerId != Account.OwnerId';
        return Database.getQueryLocator(Query);
    }
    Global void Execute(Database.BatchableContext bcontext , List<Contact> Scope){
        for(Contact con : Scope){
            con.OwnerId = con.Account.OwnerId;
        }
        update scope;
    }
    Global void Finish(Database.BatchableContext bcontext){
        
    }

}