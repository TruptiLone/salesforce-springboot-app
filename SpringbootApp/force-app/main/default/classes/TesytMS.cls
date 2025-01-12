public class TesytMS {
    @AuraEnabled
    public static List<Contact> getContact(){
        return [Select Id, Name from Contact];
    }

}