import { LightningElement,track} from 'lwc';
//import {ShowToastEvent }  from 'lightning/platformShowToastEvent';

export default class Displayaccountrecords extends LightningElement {
   @track shareddatafromctop;
    handlechild1(event){
     this.shareddatafromctop=event.detail;
    }

}