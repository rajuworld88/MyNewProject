({
    generatePDF: function(record, callback) {
        var pdf = new jsPDF();

        pdf.setFontSize(12);
        pdf.text('Record Details:', 10, 10);
        pdf.text('Name: ' + record.Name, 10, 20);
        pdf.text('Phone: ' + record.Phone, 10, 30);
        // Add more fields as necessary

        var pdfDataUri = pdf.output('datauristring'); // This generates a data URI of the PDF
        callback(pdfDataUri);
    }
})