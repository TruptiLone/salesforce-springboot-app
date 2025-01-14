import { LightningElement } from 'lwc';
import backgroundUrl from '@salesforce/resourceUrl/background';


export default class TestExample extends LightningElement {
    get backgroundStyle() {
        return `height:50rem;background-image:url(${backgroundUrl})`;
    }
}