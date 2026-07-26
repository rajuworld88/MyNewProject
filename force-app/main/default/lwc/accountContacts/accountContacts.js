import { LightningElement,api } from 'lwc';
import getContacts from '@salesforce/apex/AccountContactController.getContacts';
const columns = [
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' }
];

export default class AccountContacts extends LightningElement {
    contacts;
    @api recordId;
    columns = columns;
    showTable = false;
    noContacts = false;

    handleShowContacts(){
        getContacts({accountId:this.recordId})
        .then(result=>{
            this.contacts = result;
            this.showTable = true;
        })
        .catch(error=>{
            console.error('Error fetching contacts:', error);
        });
    }
}