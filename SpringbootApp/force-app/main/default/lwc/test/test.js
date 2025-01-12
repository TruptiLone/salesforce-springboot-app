import { LightningElement } from 'lwc';

export default class Test extends LightningElement {
    greeting = 'Hello World';
    text = '';
    handleChange(event) {
        this.text = event.target.value;
    }
}