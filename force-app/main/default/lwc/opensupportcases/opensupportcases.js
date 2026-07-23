import { LightningElement, wire } from 'lwc';

import { refreshApex } from '@salesforce/apex';
import opencases from '@salesforce/apex/getopencases.opencases';
import updatecases from '@salesforce/apex/getopencases.updatecases';

const columns = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Status', fieldName: 'Status' },
    {
        type: 'button',
        typeAttributes: { label: 'Close', name: 'close' }
    }
];

    
export default class Opensupportcases extends LightningElement {

    cases;
    error;
    columns = columns;

    @wire(opencases)
    wiredCases({ error, data }) {
        if (data) {
            this.cases = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.cases = undefined;
        }
    }

    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;

        if (action.name === 'close') {
            this.updateCase(row.Id, 'Closed');
        }
    }

    updateCase(caseId, newStatus) {
        updatecases({ caseId: caseId, newStatus: newStatus })
            .then(() => {
                return refreshApex(this.wiredCases);
            })
            .catch(error => {
                console.error('Error updating case status: ', error);
            });
    }


}