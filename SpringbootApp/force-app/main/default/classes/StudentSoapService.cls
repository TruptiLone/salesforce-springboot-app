global class StudentSoapService{
    
    webService static student__c getStudent(String studentId){
    
      Student__c student=[select id,Student_Name__c,Phone_Number__c,School__c,Email__c from Student__c where id=: studentId];
      return student;
      
    }

}