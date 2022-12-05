@IsTest
public class EmailMessageTriggerHandler_Test {
    @TestSetup
    public static void setupData() {
        List<Case> listCase = DataFactory_Test.createCases();
    }
    
	@IsTest
    static void testEmailMessageTrigger() {
        List<EmailMessage> listEmailMessage = new List<EmailMessage>();
        List<Case> listCase = [select Id
                                from Case
                                where Subject = 'Case 001' or Subject = 'Case 002'];


        EmailMessage em = new EmailMessage(
            Incoming = true,
            FromAddress = 'a@yopmail.com',
            ToAddress = 'b@yopmail.com',
            ParentId = listCase[0].Id
        );
        EmailMessage em2 = new EmailMessage(
            Incoming = false,
            FromAddress = 'a@yopmail.com',
            ToAddress = 'b@yopmail.com',
            ParentId = listCase[1].Id
        );
        listEmailMessage.Add(em);
        listEmailMessage.Add(em2);
        insert listEmailMessage;
    }
}