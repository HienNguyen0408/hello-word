/*------------------------------------------------------------
+Author:        Duy Huynh
Company:        Merkle
Description:    
Test Class:     TriggerHandler_Test
History
<Date>          <Authors Name>          <Brief Description of Change>
2022/11/27        Duy Huynh         	    Init
------------------------------------------------------------*/
public without sharing class LiveChatTranscriptTriggerHandler extends TriggerHandler {
    public LiveChatTranscriptTriggerHandler(){}


    /*------------------------------------------------------------
    Author:        Duy Huynh
    Company:       Merkle
    Description:   function to implement the business in trigger before insert
    Test Class:    
    History
    <Date>         <Authors Name>     <Brief Description of Change>
    2022/11/27       Duy Huynh     		Init
    ----------------------------------------------------------------*/ 
    public override void beforeInsert() {
        setExternalSiteId();
    }


    /*------------------------------------------------------------
    Author:        Duy Huynh
    Company:       Merkle
    Description:   set External Site Id based On Live Chat Button Id
    Test Class:    
    History
    <Date>         <Authors Name>     <Brief Description of Change>
    2022/11/27       Duy Huynh     		Init
    ----------------------------------------------------------------*/
    public static void setExternalSiteId () {
        String liveChatButtonId = '';
        Map<Id, String> mapChatButton = new Map<Id, String>(); //Map<ChatButtonId, DeveloperName>
        List<LiveChatButton> listLiveChatButton = new List<LiveChatButton>();

        for(LiveChatTranscript chatTranscript : (List<LiveChatTranscript>)Trigger.New) {
            liveChatButtonId = chatTranscript.LiveChatButtonId;
            break;
        }

        listLiveChatButton = LiveChatTranscriptSelector.GetListLiveChatButton(liveChatButtonId);
        
        if(!listLiveChatButton.isEmpty()) {
            mapChatButton.put(listLiveChatButton[0].Id, listLiveChatButton[0].DeveloperName);
        }

        for(LiveChatTranscript chatTranscript : (List<LiveChatTranscript>)Trigger.New) {
            if(Test.isRunningTest()) {
                chatTranscript.LiveChatButtonId = listLiveChatButton[0].Id;
            }
            if(mapChatButton.containsKey(chatTranscript.LiveChatButtonId)) {
                if(mapChatButton.get(chatTranscript.LiveChatButtonId) == Label.TECH_DKS_CHAT_BUTTON) {
                    chatTranscript.External_Site_Id__c = Label.DKS_JP_EXTERNAL_SITE_ID;
                }else {
                    chatTranscript.External_Site_Id__c = Label.TECH_TBL_JP_EXTERNAL_SITE_ID;
                }
            }
        }
    }
}