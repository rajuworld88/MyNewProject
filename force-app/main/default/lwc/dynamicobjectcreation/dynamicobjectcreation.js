import { LightningElement,track } from 'lwc';

export default class Dynamicobjectcreation extends LightningElement {
   @track selectedObject='';
   @track formData={};
   get objectOptions() {
    return [
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Opportunity', value: 'Opportunity' },
    ];
}
get isContact() {
    return this.selectedObject === 'Contact';
}

get isOpportunity() {
    return this.selectedObject === 'Opportunity';
}
handleObjectChange(event) {
    this.selectedObject = event.target.value;
    this.formData = {}; // Clear form data when the selection changes
}

// Handle field input changes
handleFieldChange(event) {
    const field = event.target.name;
    const value = event.target.value;
    this.formData[field] = value;
}

// Create the record
handleCreateRecord() {
    if (!this.selectedObject || Object.keys(this.formData).length === 0) {
        this.showToast('Error', 'Please fill in all required fields.', 'error');
        return;
    }

    createRecord({ objectApiName: this.selectedObject, fieldData: this.formData })
        .then(() => {
            this.showToast('Success', `${this.selectedObject} record created successfully!`, 'success');
            this.formData = {}; // Clear the form
        })
        .catch(error => {
            console.error(error);
            this.showToast('Error', 'An error occurred while creating the record.', 'error');
        });
}

// Show toast messages
showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
}
}