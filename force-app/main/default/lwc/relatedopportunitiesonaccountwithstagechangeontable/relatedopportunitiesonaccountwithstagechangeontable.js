import { LightningElement,wire,track,api } from 'lwc';
import opportunitesonaccount from '@salesforce/apex/opportunitesonaccount.getOpportunities';
import updatestagename from '@salesforce/apex/opportunitesonaccount.updateOpportunityStage';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Opportunity Name', fieldName: 'Name' },
    { label: 'Stage', fieldName: 'StageName', editable: true },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' }
];
export default class Relatedopportunitiesonaccountwithstagechangeontable extends LightningElement {

    @track columns = columnss;
    @track opportunities = [];
    @track draftValues = [];
    @api recordId; // Dynamic record ID from the page
    isLoading = false;

    // Fetch opportunities related to the current Account
    @wire(opportunitesonaccount, { AccountId: '$recordId' })
    wiredOpportunities({ data, error }) {
        if (data) {
            this.opportunities = data;
        } else if (error) {
            console.error('Error fetching opportunities:', error);
        }
    }

    // Handle save action from the data table
    handleSave(event) {
        const updatedFields = event.detail.draftValues; // Get draft values
        this.isLoading = true;

        updatestagename({ opportunities: updatedFields }) // Call Apex method
            .then(() => {
                // Refresh the opportunities list
                return opportunitesonaccount({ AccountId: this.recordId });
            })
            .then((result) => {
                this.opportunities = result; // Update the table data
                this.draftValues = []; // Clear draft values
                this.isLoading = false;
                this.showToast('Success', 'Opportunities updated successfully!', 'success');
            })
            .catch((error) => {
                this.isLoading = false;
                this.showToast('Error', error.body.message, 'error');
            });
    }

    // Show Toast Message
    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(toastEvent);
    }
}