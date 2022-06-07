
@IsTest
public with sharing class Chatbot_Helper_Test {
    @TestSetup
    public static void setupData() {
        LiveChatVisitor chatVisitor = DataFactory_Test.createLiveChatVisitor();
        LiveChatTranscript transcriptRecords = DataFactory_Test.createLiveChatTranscript(chatVisitor.Id);
    }

    @IsTest
    static void testGetMapBusinessHour() {
        Test.startTest();
        Map<String, List<BusinessHours>> mapBH = Chatbot_Helper.getMapBusinessHour();
        Test.stopTest();

        System.AssertEquals(true, !mapBH.isEmpty());
    }

    @IsTest
    static void testGetTranscriptRecord() {
        List<LiveChatTranscript> transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c, External_Site_Id__c, CreatedDate
                                                        FROM LiveChatTranscript
                                                        LIMIT 1];
        Test.startTest();
        LiveChatTranscript transcriptRecord = Chatbot_Helper.getTranscriptRecord(transcriptRecords[0].Id);
        Test.stopTest();

        System.AssertEquals(true, transcriptRecord != null);
    }
}