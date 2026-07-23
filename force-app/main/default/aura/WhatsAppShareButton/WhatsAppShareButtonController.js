({
    shareToWhatsApp : function(component, event, helper) {
        var record = component.get("v.record");

        // Creating a simple text-based table format
        var message = "Sharing Salesforce Record Details:\n\n" +
                      "--------------------------------\n" +
                      "| Field       | Value          |\n" +
                      "--------------------------------\n" +
                      "| Name        | " + record.Name + " |\n" +
                      "| Phone       | " + record.Phone + " |\n" +
                      "--------------------------------";

        // The extra spaces might need adjustment depending on the actual length of the content to align the columns properly

        
        var encodedMessage = encodeURIComponent(message);
        var whatsappUrl = "https://wa.me/?text=" + encodedMessage;
        window.open(whatsappUrl, '_blank');
    }
})