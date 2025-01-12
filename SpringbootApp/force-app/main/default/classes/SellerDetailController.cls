public with sharing class SellerDetailController {

    private final Account account;
    public SellerDetailController(){
        account = [select id, name, site from Account where Id=: ApexPages.currentPage().getParameters().get('id')];
    }
    public Account getAccount(){
        return account;
    }
    
}