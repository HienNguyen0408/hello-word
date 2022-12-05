@IsTest
public class CaseTriggerHandler_Test {
    @TestSetup
    static void makeData(){
        List<Case> listCase = DataFactory_Test.createCases();
    }
    @IsTest
    static void testUpdateCase() {
        List<Case> listCaseUpdating = [select Subject from Case where Subject = 'Case 001'];
        for(Case tmpCase : listCaseUpdating) {
            tmpCase.Subject = 'Case Test 001';
        }
        update listCaseUpdating;
    }
}