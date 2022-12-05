@IsTest
public class CaseSelector_Test {
    @TestSetup
    static void makeData(){
        List<Case> listCase = DataFactory_Test.createCases();
    }
    @IsTest
    static void testgetListCaseByIds() {
        List<Id> Ids = new List<Id>();
        for(Case tmpCase: [select Id from Case where Subject = 'Case 001']) {
            Ids.Add(tmpCase.Id);
        }

        CaseSelector.getListCaseByIds(Ids);
    }
}