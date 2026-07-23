import { LightningElement, wire } from 'lwc';
import getaccounts from '@salesforce/apex/practiceapexflow.getaccounts';

export default class Week1flow extends LightningElement {
 accounts ;
handlechange(){
  getaccounts().then(result=>{
    this.accounts=result;
  }).catch(error=>{
    console.error(error);
  })
}
}