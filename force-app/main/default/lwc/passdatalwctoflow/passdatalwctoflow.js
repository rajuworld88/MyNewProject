import { LightningElement, api } from 'lwc';
import { FlowNavigationNextEvent} from 'lightning/flowSupport';

export default class Passdatalwctoflow extends LightningElement {

    @api
    subject;

    @api
    description;
    
    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleDescChange() {
        this.description = event.detail.value;
    }

    handleCreate() {
        const navigateNextEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(navigateNextEvent);
    }
}