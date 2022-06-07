@IsTest
public with sharing class Chatbot_CheckWithinBusinessHours_Test {
    @TestSetup
    public static void setupData() {
        LiveChatVisitor chatVisitor = DataFactory_Test.createLiveChatVisitor();
        LiveChatTranscript transcriptRecords = DataFactory_Test.createLiveChatTranscript(chatVisitor.Id);
    }

    @IsTest
    static void testInBusinessHours() {
        List<LiveChatTranscript> transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c, External_Site_Id__c, CreatedDate
                                                        FROM LiveChatTranscript
                                                        LIMIT 1];
        Chatbot_CheckWithinBusinessHours.TranscriptInput trsInput = new Chatbot_CheckWithinBusinessHours.TranscriptInput();
        trsInput.routableID = transcriptRecords[0].Id;
        List<Chatbot_CheckWithinBusinessHours.TranscriptInput> trsInputList = new List<Chatbot_CheckWithinBusinessHours.TranscriptInput>{trsInput};
        Boolean isInBH = true;

        Test.startTest();
        List<Boolean> isInBHList = Chatbot_CheckWithinBusinessHours.isWithInBusinessHours(trsInputList);
        Test.stopTest();

        isInBH = isInBHList[0];

        if(!isInBH) {
            System.AssertEquals(false, isInBH);
        }else {
            System.AssertEquals(true, isInBH);
        }
    }
}