import { LightningElement } from 'lwc';

export default class DynamicForm extends LightningElement {

    shownamefield;
    showemailfield;
    selectedFormType;

    data=[
        {"label":"name","value":"name"},
        {"label":"email","value":"email"}
    ]

    handlechange(event){
   this.selectedFormType=event.detail.value;
   this.shownamefield=this.selectedFormType==='name';
   this.showemailfield=this.selectedFormType==='email';
    }

}