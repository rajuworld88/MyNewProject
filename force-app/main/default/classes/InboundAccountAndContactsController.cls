@RestResource(urlMapping='/inboundAccountAndContacts/*')
global with sharing class InboundAccountAndContactsController {
  @HttpPost
    global static void createAccountAndContacts() {
        // Retrieve the request body
        RestRequest req = RestContext.request;
        String jsonString = req.requestBody.toString();
        
        // Parse the payload
        Map<String, Object> payloadMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        
        // Extract the account and contact data from the payload
        String accountName = (String)payloadMap.get('accountName');
        String contact1Name = (String)payloadMap.get('contact1Name');
        String contact1LastName = (String)payloadMap.get('contact1LastName');
        String contact1Email = (String)payloadMap.get('contact1Email');
        String contact2Name = (String)payloadMap.get('contact2Name');
        String contact2LastName = (String)payloadMap.get('contact2LastName');
        String contact2Email = (String)payloadMap.get('contact2Email');
        
        // Create the account
        Account acc = new Account();
        acc.Name = accountName;
        insert acc;
        
        // Create the first contact
        Contact con1 = new Contact();
        con1.FirstName = contact1Name;
        con1.LastName=contact1LastName;
        con1.Email = contact1Email;
        con1.AccountId = acc.Id;
        insert con1;
        
        // Create the second contact
        Contact con2 = new Contact();
        con2.FirstName = contact2Name;
        con2.LastName=contact2LastName;
        con2.Email = contact2Email;
        con2.AccountId = acc.Id;
        insert con2;
    }
}