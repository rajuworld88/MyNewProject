import { LightningElement, track } from 'lwc';

export default class ChildA extends LightningElement {

    @track childdata='';
    handlename(event){
        this.childdata=event.target.value;
        const event1 = CustomEvent('datachange',{detail:this.childdata});
        this.dispatchEvent(event1);
    }
}