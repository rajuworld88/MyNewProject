import { LightningElement ,wire} from 'lwc';
import getDashboardController from '@salesforce/apex/DashboardController.getDashboardController';
export default class AllDatadashbord extends LightningElement {
Dashboard = {};
@wire(getDashboardController) wiredDashboard({error,data}){
    if(data){
        this.Dashboard=data;
    }else if(error){
        console.error(error);
    }
}
}