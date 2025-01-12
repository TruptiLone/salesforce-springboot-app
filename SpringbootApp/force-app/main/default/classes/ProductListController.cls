public class ProductListController {
    public List<Product__c> proLst{get;set;}

    public PageReference selProd(){
        String getid = Apexpages.currentPage().getparameters().get('proLst');
        proLst = [Select id, Name,Product_Name__c,Stock__c from Product__c where Id=: getid];
        System.debug(proLst);
        return null;
    }
    
     
}