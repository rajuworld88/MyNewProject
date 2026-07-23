import { LightningElement, wire,track } from 'lwc';
import casedata from '@salesforce/apex/caselistopen.casedata';


const columns = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'status', fieldName: 'Status' },
    { label: 'Origin', fieldName: 'Origin' },
    { label: 'Account Name', fieldName: 'AccountName' },
    { label: 'Task Description', fieldName: 'TaskDescription' } 
];
export default class Opencasesandaccounttask extends LightningElement {
    @track cases = [];
    col = columns;

    @wire(casedata)  
    wiredCases({ error, data }) {
        if (data) {
            this.cases = data.map(caseRec => ({
                Id: caseRec.Id,
                CaseNumber: caseRec.CaseNumber,
                Status: caseRec.Status,
                Origin: caseRec.Origin,
                AccountName: caseRec.Account?.Name ?? 'No Account',
                TaskDescription: caseRec.Tasks?.[0]?.Description ?? 'No Task'
            }));
        } else if (error) {
            console.error('Error fetching cases:', error);
            this.cases = []; 
        }
}}