import { LightningElement, track } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import EVENT_OBJECT from '@salesforce/schema/Event__c';
import EVENT_NAME_FIELD from '@salesforce/schema/Event__c.Event_Name__c';
import EVENT_DATE_FIELD from '@salesforce/schema/Event__c.Event_Date__c';
import LOCATION_FIELD from '@salesforce/schema/Event__c.Location__c';
import MAX_CAPACITY_FIELD from '@salesforce/schema/Event__c.Maximum_Capacity__c';
export default class EventRegistrationForm extends LightningElement {
  @track name = '';
 @track date='';
 @track location='';
 @track capacity='';

 handlename(event){
this.name=event.target.value;
 }
 handledate(event){
    this.date=event.target.value;
     }
     handlelocation(event){
        this.location=event.target.value;
     }
     handlecapacity(event){
        this.capacity=event.target.value;
     }

     handledata() {
        const fields = {};
        fields[EVENT_NAME_FIELD.fieldApiName] = this.name;
        fields[EVENT_DATE_FIELD.fieldApiName] = this.date;
        fields[LOCATION_FIELD.fieldApiName] = this.location;
        fields[MAX_CAPACITY_FIELD.fieldApiName] = this.capacity;

        const recordInput = { apiName: EVENT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Event created successfully',
                        variant: 'success',
                    }),
                );
                this.clearFields();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    clearFields() {
        this.name = '';
        this.date = '';
        this.location = '';
        this.capacity = '';
    }
}