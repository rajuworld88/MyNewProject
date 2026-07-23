import { LightningElement ,track} from 'lwc';

export default class DynamicForm extends LightningElement {

    @track shownamefield=false;
    @track showemailfield=false;
    @track selectedFormType ='';

    data=[
        { label: 'Select Form Type', value: '' },
        {label:'name',value:'name'},
        {label:'email',value:'email'}
    ];

    handlechange(event){
   this.selectedFormType=event.detail.value;
   this.shownamefield=this.selectedFormType==='name';
   this.showemailfield=this.selectedFormType==='email';
    }

}