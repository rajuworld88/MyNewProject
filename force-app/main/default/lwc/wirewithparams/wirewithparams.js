import { LightningElement,wire } from 'lwc';
import getaccountswithparams from '@salesforce/apex/wirewithparams.acclistdata';
export default class Wirewithparams extends LightningElement {

    selectedrating = [];
    dataa;
    @wire(getaccountswithparams, {accratingapex: '$dataa'})
    wiredata ({data,error}){
     
      if(data){
        this.selectedrating=data;
      }
      else if (error){
        console.log(error);
      }
       


    }
    get selecteddata (){
        return [
            {label:'hot' , value:'Hot'},
            {label:'warm' , value:'Warm'},
            {label:'Cold' , value:'Cold'},
        ]
    }
    handlecombo(event){
        this.dataa=event.target.value;
        
    }

}