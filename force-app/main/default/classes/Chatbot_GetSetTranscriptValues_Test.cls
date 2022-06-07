@IsTest
public with sharing class Chatbot_GetSetTranscriptValues_Test {
    @TestSetup
    public static void setupData() {
        LiveChatVisitor chatVisitor = DataFactory_Test.createLiveChatVisitor();
        LiveChatTranscript transcriptRecords = DataFactory_Test.createLiveChatTranscript(chatVisitor.Id);
    }

    @IsTest
    static void testGetUserInformation() {
        Case tmpCase = new Case();
        List<LiveChatTranscript> transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c, External_Site_Id__c, CreatedDate
                                                        FROM LiveChatTranscript
                                                        LIMIT 1];
        Chatbot_GetSetTranscriptValues.TranscriptInput trsInput = new Chatbot_GetSetTranscriptValues.TranscriptInput();
        trsInput.routableID = transcriptRecords[0].Id;
        trsInput.userMessage = 'Test';
        trsInput.emailAddress = 'duy.huynh@yopmail.com';
        List<Chatbot_GetSetTranscriptValues.TranscriptInput> trsInputList = new List<Chatbot_GetSetTranscriptValues.TranscriptInput>{trsInput};

        Test.startTest();
        Chatbot_GetSetTranscriptValues.getUserInformation(trsInputList);
        Test.stopTest();

        tmpCase = [SELECT SuppliedEmail FROM Case Limit 1];

        if(tmpCase != null) {
            System.AssertEquals('duy.huynh@yopmail.com', tmpCase.SuppliedEmail);
        }
    }
}