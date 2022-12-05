trigger CaseTrigger on Case (before update) {
    new CaseTriggerHandler().run();
}