public with sharing class uploadfilestoshareWhatsapp {
    @AuraEnabled
    public static String uploadFile(String base64Data, String fileName) {
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.VersionData = EncodingUtil.base64Decode(base64Data);
        contentVersion.Title = fileName;
        contentVersion.PathOnClient = fileName;
        insert contentVersion;

        ContentVersion insertedContentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id LIMIT 1];

        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = insertedContentVersion.ContentDocumentId;
        contentDocumentLink.LinkedEntityId = UserInfo.getUserId(); // Link to current user
        contentDocumentLink.ShareType = 'V';
        contentDocumentLink.Visibility = 'AllUsers';
        insert contentDocumentLink;

        return '/sfc/servlet.shepherd/document/download/' + insertedContentVersion.ContentDocumentId;
    }
}