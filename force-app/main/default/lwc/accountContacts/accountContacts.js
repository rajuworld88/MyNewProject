import { LightningElement,api } from 'lwc';
import getContacts from '@salesforce/apex/AccountContactController.getContacts';
import getAccounts from '@salesforce/apex/AccountContactController.getAccounts';
const columns = [
    {
        label: 'Account Name',
        fieldName: 'Name'
    },
    {
        label: 'Phone',
        fieldName: 'Phone'
    },
    {
        label: 'Industry',
        fieldName: 'Industry'
    },
    {
        type: 'button',
        typeAttributes: {
            label: 'Show Contacts',
            name: 'show_contacts',
            variant: 'brand'
        }
    }
];

const contactColumns = [
    {
        label: 'First Name',
        fieldName: 'FirstName'
    },
    {
        label: 'Last Name',
        fieldName: 'LastName'
    },
    {
        label: 'Email',
        fieldName: 'Email',
        type: 'email'
    },
    {
        label: 'Phone',
        fieldName: 'Phone'
    }
];

export default class AccountContacts extends LightningElement {
   accounts = [];
    contacts = [];

    columns = columns;
    contactColumns = contactColumns;

    showContacts = false;
    noContacts = false;

    connectedCallback() {
        this.loadAccounts();
    }

    loadAccounts() {

        getAccounts()
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error('Error loading Accounts:', error);
            });
    }

    handleRowAction(event) {

        const actionName = event.detail.action.name;

        const row = event.detail.row;

        if (actionName === 'show_contacts') {

            this.getRelatedContacts(row.Id);
        }
    }

    getRelatedContacts(accountId) {

        getContacts({
            accountId: accountId
        })
        .then(result => {

            this.contacts = result;

            if (result.length > 0) {
                this.showContacts = true;
                this.noContacts = false;
            } else {
                this.showContacts = false;
                this.noContacts = true;
            }

        })
        .catch(error => {

            console.error('Error loading Contacts:', error);

            this.showContacts = false;
            this.noContacts = false;
        });
    }
}