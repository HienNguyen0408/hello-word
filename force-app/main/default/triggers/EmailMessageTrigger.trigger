trigger EmailMessageTrigger on EmailMessage (before insert, after insert) {
    new EmailMessageTriggerHandler().run();
}