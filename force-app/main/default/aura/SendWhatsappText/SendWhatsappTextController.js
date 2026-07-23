({
    sendToWhatsApp: function(component, event, helper) {
        // Get the message input by the user
        var message = component.get("v.message");
        
        // Ensure the message is not empty
        if (message.trim() === "") {
            alert("Please enter a message to send.");
            return;
        }

        // Encode the message to make it URL-safe
        var encodedMessage = encodeURIComponent(message);

        // WhatsApp URL format with the message
        var whatsappUrl = `https://wa.me/?text=${encodedMessage}`;

        // Open the WhatsApp link in a new tab
        window.open(whatsappUrl, '_blank');
    }
})