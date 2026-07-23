import { LightningElement, track } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import PDFMAKE from '@salesforce/resourceUrl/pdfMake1';
import MY_PDF_IMAGE from '@salesforce/resourceUrl/MyPDFImage';
import uploadFile from '@salesforce/apex/uploadfilestoshareWhatsapp.uploadFile';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class pdfdirectlysharetowhatsapp extends LightningElement {
    @track num_of_kgs_per_bag = '';
    @track num_of_bags = '';
    @track cost_per_kg = '';
    @track email = '';

    pdfLibInitialized = false;

    renderedCallback() {
        if (!this.pdfLibInitialized) {
            console.log('Loading pdfMake library...');
            Promise.all([
                loadScript(this, PDFMAKE + '/pdfmake.min.js'),
                loadScript(this, PDFMAKE + '/vfs_fonts.js')
            ])
            .then(() => {
                this.pdfLibInitialized = true;
                console.log('pdfMake loaded successfully');
            })
            .catch(error => console.error('Error loading pdfMake:', error));
        }
    }

    handleInputChange(event) {
        const field = event.target.dataset.field;
        if (field) {
            this[field] = event.target.value;
            console.log(`Field ${field} updated to ${this[field]}`);
        }
    }

    fetchImageAsBase64(url) {
        return fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.blob();
            })
            .then(blob => new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.onloadend = () => resolve(reader.result);
                reader.onerror = reject;
                reader.readAsDataURL(blob);
            }))
            .catch(error => console.error('Error fetching image:', error));
    }

    generatePdf(base64Image) {
        const docDefinition = {
            content: [
                {
                    image: base64Image,
                    width: 450,
                    alignment: 'center',
                    margin: [0, 0, 0, 20]
                },
                {
                    style: 'tableExample',
                    table: {
                        widths: ['*', '*'],
                        body: [
                            ['Category', 'Details'],
                            ['Number of Kgs per bag', this.num_of_kgs_per_bag + ' Kg/Bag'],
                            ['Number of Bags', this.num_of_bags + ' Bags'],
                            ['Cost Per Kg', this.cost_per_kg + ' Rupees'],
                            ['Total cost', this.cost_per_kg * this.num_of_bags * this.num_of_kgs_per_bag + ' Rupees']
                        ]
                    },
                    layout: {
                        fillColor: function (rowIndex) {
                            return (rowIndex === 0) ? '#CCCCCC' : null;
                        },
                        hLineWidth: function (i, node) {
                            return (i === 0 || i === node.table.body.length) ? 2 : 1;
                        },
                        vLineWidth: function (i, node) {
                            return (i === 0 || i === node.table.widths.length) ? 2 : 1;
                        },
                        hLineColor: function (i, node) {
                            return (i === 0 || i === node.table.body.length) ? 'black' : 'gray';
                        },
                        vLineColor: function (i, node) {
                            return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray';
                        }
                    }
                }
            ],
            styles: {
                header: {
                    fontSize: 18,
                    bold: true,
                    margin: [0, 0, 0, 10]
                },
                tableExample: {
                    margin: [0, 5, 0, 15]
                }
            }
        };

        return window.pdfMake.createPdf(docDefinition);
    }

    downloadPdf() {
        console.log('Attempting to download PDF...');
        if (this.pdfLibInitialized) {
            console.log('MY_PDF_IMAGE URL:', MY_PDF_IMAGE);

            this.fetchImageAsBase64(MY_PDF_IMAGE)
                .then(base64Image => {
                    const pdfDocGenerator = this.generatePdf(base64Image);
                    pdfDocGenerator.download('form-data.pdf');
                })
                .catch(error => console.error('Error fetching image:', error));
        } else {
            console.error('pdfMake is not initialized yet.');
        }
    }

    shareToWhatsApp() {
        console.log('Attempting to share to WhatsApp...');
        if (this.pdfLibInitialized) {
            console.log('pdfMake is initialized.');
            this.fetchImageAsBase64(MY_PDF_IMAGE)
                .then(base64Image => {
                    const pdfDocGenerator = this.generatePdf(base64Image);
                    pdfDocGenerator.getBase64(data => {
                        console.log('PDF generated successfully.');
                        this.uploadPdf(data);
                    });
                })
                .catch(error => console.error('Error fetching image:', error));
        } else {
            console.error('pdfMake is not initialized yet.');
        }
    }

    uploadPdf(base64Data) {
        const fileName = 'form-data.pdf';
        uploadFile({ base64Data, fileName })
            .then(fileUrl => {
                const message = `Here is your PDF file: ${fileUrl}`;
                const encodedMessage = encodeURIComponent(message);
                const whatsappUrl = `https://wa.me/?text=${encodedMessage}`;
                console.log('Generated WhatsApp URL:', whatsappUrl);
                window.location.href = whatsappUrl; // Use window.location.href instead of window.open
            })
            .catch(error => {
                console.error('Error uploading file:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error uploading file',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}