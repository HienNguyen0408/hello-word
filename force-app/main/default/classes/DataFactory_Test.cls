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

    public static List<Case> createCases() {
        List<Case> listCase = new List<Case>();
        Case tmpCase = new Case(
            Subject = 'Case 001'
        );

        Case tmpCase2 = new Case(
            Subject = 'Case 002'
        );

        listCase.Add(tmpCase);
        listCase.Add(tmpCase2);
        insert listCase;
        return listCase;
    }

    // public static List<EmailMessage> createEmailMessages(Id caseId) {
    //     List<EmailMessage> listEmailMessage = new List<EmailMessage>();
    //     EmailMessage em = new EmailMessage(
    //         Subject = 'Case 001',
    //         Incoming = true,
    //         ParentId = caseId
    //     );
    //     listEmailMessage.Add(em);
    //     insert listEmailMessage;
    //     return listEmailMessage;
    // }
}