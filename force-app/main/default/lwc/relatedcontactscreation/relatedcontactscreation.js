import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class RelatedContactsCreation extends NavigationMixin(LightningElement) {
    @track accountName = '';
    @track contactFirstName = '';
    @track contactLastName = '';
    @track contactEmail = '';
    @track accountWebsite = '';
    @track contactPhoneNumber = '';
    @track file;

    handleAccountNameChange(event) {
        this.accountName = event.target.value;
    }

    handleContactFirstNameChange(event) {
        this.contactFirstName = event.target.value;
    }

    handleContactLastNameChange(event) {
        this.contactLastName = event.target.value;
    }

    handleContactEmailChange(event) {
        this.contactEmail = event.target.value;
    }

    handleAccountWebsiteChange(event) {
        this.accountWebsite = event.target.value;
    }

    handleContactPhoneNumberChange(event) {
        this.contactPhoneNumber = event.target.value;
    }

    handleFileChange(event) {
        this.file = event.target.files[0];
    }

    async handleSaveClick() {
        try {
            // Create Account record
            const accountRecord = {
                apiName: 'Account',
                fields: {
                    Name: this.accountName,
                    Website: this.accountWebsite
                }
            };
            const accountResponse = await createRecord(accountRecord);

            // Create Contact record
            const contactRecord = {
                apiName: 'Contact',
                fields: {
                    AccountId: accountResponse.id,
                    FirstName: this.contactFirstName,
                    LastName: this.contactLastName,
                    Email: this.contactEmail,
                    Phone: this.contactPhoneNumber
                }
            };
            const contactResponse = await createRecord(contactRecord);

            // Show success toast
            this.showToast('Success', 'Record created successfully.', 'success');

            // Navigate to the newly created Contact record page
            this.navigateToRecord(contactResponse.id);
        } catch (error) {
            // Show error toast
            this.showToast('Error', 'An error occurred while creating the record.', 'error');
        }
    }

    async handleSaveAndNewClick() {
        try {
            // Create Account record
            const accountRecord = {
                apiName: 'Account',
                fields: {
                    Name: this.accountName,
                    Website: this.accountWebsite
                }
            };
            const accountResponse = await createRecord(accountRecord);

            // Create Contact record
            const contactRecord = {
                apiName: 'Contact',
                fields: {
                    AccountId: accountResponse.id,
                    FirstName: this.contactFirstName,
                    LastName: this.contactLastName,
                    Email: this.contactEmail,
                    Phone: this.contactPhoneNumber
                }
            };
            await createRecord(contactRecord);

            // Show success toast
            this.showToast('Success', 'Record created successfully.', 'success');

            // Clear the form fields
            this.clearForm();
        } catch (error) {
            // Show error toast
            this.showToast('Error', 'An error occurred while creating the record.', 'error');
        }
    }

    handleCancelClick() {
        // Clear the form fields
        this.clearForm();
    }

    clearForm() {
        this.accountName = '';
        this.contactFirstName = '';
        this.contactLastName = '';
        this.contactEmail = '';
        this.accountWebsite = '';
        this.contactPhoneNumber = '';
        this.file = undefined;
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(toastEvent);
    }

    navigateToRecord(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }
}