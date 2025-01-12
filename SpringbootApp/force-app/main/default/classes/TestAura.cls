public class TestAura {
     @AuraEnabled
    public static List<Contact> getContacts() {
        return [SELECT Id, Name from Contact];
    }

}