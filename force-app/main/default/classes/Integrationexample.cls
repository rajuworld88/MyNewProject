public class Integrationexample {
    /*curl -i -H "Accept:application/json" -H "Content-Type:application/json" -H "Authorization:
     *  Bearer 9860b84c9de108cf8d841fdfb76f56adc2499fb273c857a98f0b99703ee6f5df" -XPOST "https://gorest.co.in/public/v2/users" -d 
     * '{"name":"Tenali Ramakrishna", "gender":"male", "email":"tenali.ramakrishna@15ce.com", "status":"active"}' */
    
  /*  public static void exampleofintegation (string userid){
        http h= new http();
        httprequest req = new httprequest();

        req.setendpoint('https://gorest.co.in/public/v2/users/'+userid);
        req.setheader('Authorization','Bearer 9860b84c9de108cf8d841fdfb76f56adc2499fb273c857a98f0b99703ee6f5df');
        req.setheader('Content-Type' ,'application/json');
        req.setmethod('GET');
        httpresponse re = new httpresponse();
        re=h.send(req);
        if(re.getstatuscode()==200){
            system.debug(' the response is success'+ re.getbody());
            map<String,Object> mapids = (map<String,Object>) json.Deserializeuntyped(re.getbody());
            String accname = (String)mapids.get('name');
            String accstatus = (String)mapids.get('status');
            Account acc = new Account();
            acc.name=accname;
            //acc.Status__c=accstatus;
            insert  acc;
            system.debug('The id of account'+ acc.Id);
            
        }
        
    } */
    
    public static void postdata(string na, string em ){
              http h= new http();
        httprequest req = new httprequest();

        req.setendpoint('https://gorest.co.in/public/v2/users/');
        req.setheader('Authorization','Bearer 9860b84c9de108cf8d841fdfb76f56adc2499fb273c857a98f0b99703ee6f5df');
        req.setheader('Content-Type' ,'application/json');
        req.setmethod('POST');
        string rbody ='{"name":"'+na+'", "gender":"male", "email":"'+em+'", "status":"active"}' ;
        req.setbody(rbody);
        httpresponse re = new httpresponse();
        re=h.send(req);
        if(re.getstatuscode()==201){
            system.debug('The responese of '+ re.getbody());
        }
        
    }
    
  
    
    
public static void sendContacts() {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email FROM Contact];
        String jsonBody = JSON.serialize(contacts);

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        Http http = new Http();
        HttpResponse res = http.send(req);

        System.debug('Status: ' + res.getStatus());
        System.debug('Response: ' + res.getBody());
    }


}