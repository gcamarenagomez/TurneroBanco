public class TurneroController {
    
    @AuraEnabled
    public static Account getAccountById(String accountId){
        return [Select Id, Name, FinServ__Status__c, FinServ__ClientCategory__c, PersonBirthdate, DNI__c, FinServ__MailingAddress__pc, FinServ__TotalBankDeposits__c, Phone, Oferta_Comercial__c, Propension__c  from Account where Id =: accountId];
    }

}