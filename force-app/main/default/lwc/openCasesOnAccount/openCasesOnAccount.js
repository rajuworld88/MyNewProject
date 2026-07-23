import { LightningElement,api,track} from 'lwc';
import getOpenCases from '@salesforce/apex/OpenCasesController.getOpenCases';
const columns = [
    {
        label: 'Case Number',
        fieldName: 'CaseNumber'
    },
    {
        label: 'Subject',
        fieldName: 'Subject'
    },
    {
        label: 'Status',
        fieldName: 'Status'
    },
    {
        label: 'Priority',
        fieldName: 'Priority'
    },
    {
        label: 'Origin',
        fieldName: 'Origin'
    },
    {
        label: 'Owner',
        fieldName: 'OwnerName'
    },
    {
        label: 'Created Date',
        fieldName: 'CreatedDate',
        type: 'date'
    }
];

export default class OpenCasesOnAccount extends LightningElement {

    @api recordId;

    @track cases = [];

    error;

    columns = columns;

    loadCases() {

        getOpenCases({
            accountId: this.recordId
        })
        .then(result => {

            this.cases = result.map(item => {

                return {
                    ...item,
                    OwnerName: item.Owner ? item.Owner.Name : ''
                };

            });

            this.error = undefined;

        })
        .catch(error => {

            this.error = error.body.message;

        });

    }

}