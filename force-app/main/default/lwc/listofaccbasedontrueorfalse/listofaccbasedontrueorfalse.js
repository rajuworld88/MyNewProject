import { LightningElement, wire,track } from 'lwc';
import accdataa from '@salesforce/apex/listofaccbasedontorf.accdataa';
const col = [
    {label:'Name',fieldName:'Name'},
    {label:'phone',fieldName:'Phone'},
   
    { label: 'Active', fieldName: 'isActive__c', type: 'boolean' }

];
export default class Listofaccbasedontrueorfalse extends LightningElement {
    @track isChecked = true;
    @track accounts;
    columns = col;

    @wire(accdataa, { isActive: '$isChecked' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            this.accounts = undefined;
            console.error(error);
        }
    }

    handleCheckboxChange(event) {
        this.isChecked = event.target.checked;
    }
}