public  class listofaccbasedontorf {
    @AuraEnabled(cacheable=true)
    public static List<Account> accdataa(Boolean isActive) {
        String query = 'SELECT Id, Name, isActive__c,Phone FROM Account WHERE isActive__c = :isActive';
        return Database.query(query);
    }
   
}