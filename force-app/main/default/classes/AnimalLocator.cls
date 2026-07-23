public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        String strResp;
        
        if (response.getStatusCode() == 200) {
            // Parse the JSON response to a map
            Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animals = (Map<String, Object>) mapData.get('animal');
            
            // Check if the 'name' key is available and assign its value
            if (animals != null && animals.containsKey('name')) {
                strResp = String.valueOf(animals.get('name'));
            } else {
                strResp = 'Error: Unable to fetch animal details';
            }
        }
        
        return strResp;
    }
}