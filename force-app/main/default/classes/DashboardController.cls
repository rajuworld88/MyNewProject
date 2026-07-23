public with sharing class DashboardController {
    @AuraEnabled(cacheable=true)
    public static DashboardWrapper getDashboardController() {
    DashboardWrapper  wrap = new DashboardWrapper();
    wrap.Totaltenents = [SELECT count() FROM Tenant__c];
    wrap.TotalOccufiedrooms = [SELECT count() FROM Room__c where Status__c = 'Occupied'];
    wrap.TotalVacantrooms = [SELECT count() FROM Room__c where Status__c = 'Vacant'];
    wrap.TotalRooms = [SELECT count() FROM Room__c];
    wrap.pendingPayments = [SELECT count() FROM Payment__c where Status__c = 'Pending'];
      AggregateResult agr = [select  SUM(Amount__c) TotalAmount from Payment__c Where Status__C='Paid'];
      wrap.AnnuvalRevenue = (Decimal)agr.get('TotalAmount');
    return wrap;
    }
}