import { LightningElement,wire,api } from 'lwc';

export default class Navigateurlcase extends LightningElement {
    @api recordId;
    SIRA_URL = '{SIRA_URL}';

    handleClick() {
        const siraUrl = this.SIRA_URL + '?caseId=' + this.recordId;
        window.open(siraUrl, '_blank');
    }
}