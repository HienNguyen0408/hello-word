@isTest
global without sharing class DataFactory_Test{
    public static LiveChatVisitor createLiveChatVisitor() {
        LiveChatVisitor chatVisitor = new LiveChatVisitor();

        insert chatVisitor;
        return chatVisitor;
    }

    public static LiveChatTranscript createLiveChatTranscript(Id chatVisitorId) {
        LiveChatTranscript transcript = new LiveChatTranscript(
            First_Name__c = 'Duy',
            Last_Name__c = 'Huynh',
            Email_Address__c = 'duy.huynh@yopmail.com',
            Subject__c = 'Test Subject',
            External_Site_Id__c = 'tbl-jp',
            LiveChatVisitorId = chatVisitorId
        );

        insert transcript;
        return transcript;
    } 
}