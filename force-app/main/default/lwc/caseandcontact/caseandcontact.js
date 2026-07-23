import { LightningElement,track } from 'lwc';
import createCaseAndContact from '@salesforce/apex/caseandcontact.createcaseandcontact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Caseandcontact extends LightningElement {

    @track firstName;
    @track lastName;
    @track email;
    @track subject;
    @track description;

handleFirstName(event){
this.firstName=event.target.value;
}
handleLastName(event){
this.lastName=event.target.value;
}
handleEmail(event){
this.email=event.target.value;
}
handleSubject(event){
this.subject=event.target.value;
}
handleDescription(event){
this.description=event.target.value;

}
handleSave(){
    createCaseAndContact({
        firstName:this.firstName,
        lastName:this.lastName,
        email:this.email,
        subject:this.subject,
        description:this.description
    }).then(caseId => {
           
        
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Case & Contact created successfully!',
                variant: 'success'
            }));

          
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: caseId,
                    objectApiName: 'Case',
                    actionName: 'view'
                }
            });
        })
        .catch(error => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error creating records',
                message: error.body.message,
                variant: 'error'
            }));
        });
    }
}