@isTest
public class LiveChatTranscriptTriggerHandler_Test {
    @TestSetup
    public static void setupData() {
        LiveChatVisitor chatVisitor = DataFactory_Test.createLiveChatVisitor();
    }

    @IsTest
    static void testChatTranscripBeforeTrigger() {
        List<LiveChatVisitor> listChatVisitor = [select Id from LiveChatVisitor limit 1];
        LiveChatTranscript chatTranscript = new LiveChatTranscript(
            External_Site_Id__c = Label.DKS_JP_EXTERNAL_SITE_ID,
            LiveChatVisitorId= listChatVisitor[0].Id
        );
        insert chatTranscript;
    }
}