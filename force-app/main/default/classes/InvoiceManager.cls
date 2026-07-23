public class InvoiceManager {
    public static List<Invoice__c> invoicelist(Id AccountId){
      return [select id,Invoice_Amount__c,Account__c,Invoice_Date__c,Status__c FROM Invoice__c
                                     where Account__c =: AccountId ];
       
    }

}