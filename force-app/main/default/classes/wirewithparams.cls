public with sharing class wirewithparams {
    @AuraEnabled(cacheable=true)
  public static List<Account> acclistdata (string accratingapex){
    List<Account> acclist = [select id,Name,Rating from Account where Rating =: accratingapex ];
    return acclist;
  }
}