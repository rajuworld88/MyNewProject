@isTest
global class AnimalLocatorMockInvalidResponse implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request) {
        // Create a fake response for an invalid scenario
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal": {"id": 1, "eats": "grass"}}'); // No 'name' field present
        response.setStatusCode(200); 
        return response;
    }
}