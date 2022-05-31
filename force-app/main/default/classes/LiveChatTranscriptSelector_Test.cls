
@IsTest
public with sharing class LiveChatTranscriptSelector_Test {
    @TestSetup
    public static void setupData() {
        LiveChatVisitor chatVisitor = DataFactory_Test.createLiveChatVisitor();
        LiveChatTranscript transcriptRecords = DataFactory_Test.createLiveChatTranscript(chatVisitor.Id);
    }

    @IsTest
    static void testGetLiveChatTranscriptById() {
        List<LiveChatTranscript> transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c, External_Site_Id__c, CreatedDate
                                                        FROM LiveChatTranscript
                                                        LIMIT 1];

        String routeId = transcriptRecords[0].Id;

        Test.startTest();
        LiveChatTranscript chatTranscript = LiveChatTranscriptSelector.GetLiveChatTranscriptById(routeId);
        Test.stopTest();

        System.assert(!transcriptRecords.isEmpty());
    }
}