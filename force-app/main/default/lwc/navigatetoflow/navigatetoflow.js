import { LightningElement,api } from 'lwc';
import {
    FlowAttributeBackEvent,
    FlowNavigationNextEvent,
} from 'lightning/flowSupport';export default class Navigatetoflow extends LightningElement {
     @api avalableaction = [] ;
    handleNext(){
        if(this.avalableaction.find((action) => action ==="BACK")){
            const backnavi = new FlowAttributeBackEvent();
            this.dispatchEvent(backnavi);
        }
 

    }
    handleBack(){
        if(this.avalableaction.find((action)=>action==="NEXT")){
            const nextnavi = new FlowNavigationNextEvent();
            this.dispatchEvent(nextnavi);
        }
      


    }

}