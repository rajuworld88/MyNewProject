@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request) {
        // Create a fake response for a valid animal
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal": {"id": 1, "name": "cow", "eats": "grass"}}'); // Corrected 'animal' key
        response.setStatusCode(200);
        return response;
    }
}