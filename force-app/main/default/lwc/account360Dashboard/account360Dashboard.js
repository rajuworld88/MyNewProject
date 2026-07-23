import { LightningElement,track,api } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountDashboardController.getAccountDetails';
import getContacts from '@salesforce/apex/AccountDashboardController.getContacts';
import getCases from '@salesforce/apex/AccountDashboardController.getCases';

export default class Account360Dashboard extends LightningElement {

    @api recordId;

    @track account;
    @track contacts = [];
    @track cases = [];
    @track caseCount = 0;

    timer;
    seconds = 0;

    // 1️⃣ constructor
    constructor() {
        super();
        console.log('Component Created');
    }

    // 2️⃣ connectedCallback
    connectedCallback() {
        this.loadData();
        this.startTimer();
    }

    // Load Account + Contacts + Cases
    loadData() {
        getAccountDetails({ accountId: this.recordId })
            .then(result => {
                this.account = result;
            });

        getContacts({ accountId: this.recordId })
            .then(result => {
                this.contacts = result;
            });

        getCases({ accountId: this.recordId })
            .then(result => {
                this.cases = result;
                this.caseCount = result.length;
            });
    }

    // SLA Timer
    startTimer() {
        this.timer = setInterval(() => {
            this.seconds++;
        }, 1000);
    }

    // 4️⃣ disconnectedCallback
    disconnectedCallback() {
        clearInterval(this.timer);
        console.log('Timer Cleared');
    }

    // 5️⃣ errorCallback
    errorCallback(error, stack) {
        console.error('Error:', error);
    }
}