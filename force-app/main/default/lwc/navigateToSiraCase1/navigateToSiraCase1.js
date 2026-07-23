import { LightningElement, api ,wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import SIRA_BUTTON_LABEL from '@salesforce/label/c.SIRA_BUTTON_LABEL';
import IS_IMAGE from '@salesforce/resourceUrl/isimage';

// Import the custom field
import SIRA_CASE_URL_FIELD from '@salesforce/schema/Case.SIRA_Case_URL__c';
export default class NavigateToSiraCase1 extends NavigationMixin(LightningElement) {
    @api recordId;
    buttonLabel = SIRA_BUTTON_LABEL;
    isImageUrl = IS_IMAGE;

    @wire(getRecord, { recordId: '$recordId', fields: [SIRA_CASE_URL_FIELD] })
    caseRecord;

    get siraCaseUrl() {
        return getFieldValue(this.caseRecord.data, SIRA_CASE_URL_FIELD);
    }

    handleClick() {
        try {
            const url = this.siraCaseUrl;
            if (url) {
                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: url
                    }
                });
            } else {
                console.error('SIRA Case URL is not available.');
            }
        } catch (error) {
            console.error('Error navigating to SIRA case:', error);
        }
    }
}