public class AccountHelper {
 public static Account getAccountById(Id accountId) {
        return [SELECT Id, Name, Industry FROM Account WHERE Id = :accountId];
    }
}