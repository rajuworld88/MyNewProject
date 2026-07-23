import { LightningElement ,api } from 'lwc';
//import { getRecord } from 'lightning/uiRecordApi';
export default class NavigateToSiraCase extends LightningElement {


    @api recordId;
    SIRA_URL = '{SIRA_URL}';

    handleClick() {
        const siraUrl = this.SIRA_URL + '?caseId=' + this.recordId;
        window.open(siraUrl, '_blank');
    }
}