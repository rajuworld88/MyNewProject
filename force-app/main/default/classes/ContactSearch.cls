public class ContactSearch {
    public static List<Contact> searchForContacts(String lastname , String mailingpostalcode){
        List<Contact> conlist = [select id,LastName,MailingPostalCode from Contact where
                                 LastName =:lastname AND MailingPostalCode =: mailingpostalcode];
        system.debug('contats' +conlist);
        return conlist;
        
    }

}