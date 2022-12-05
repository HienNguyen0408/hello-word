/*------------------------------------------------------------
Author:        Duy Huynh
Company:       Merkle
Description:   A utility class for getting data from User Object
Test Class:    N/A
History
<Date>      <Authors Name>     <Brief Description of Change>
2022/12/02     Duy Huynh        Init
------------------------------------------------------------*/
public without sharing class UserSelector {
    public static List<User> getListUserByIds(String userId){
        List<User> listUser = new List<User>();

        listUser = [select LastName, FirstName from user where Id = :userId];
        if(!listUser.isEmpty()) {
            return listUser;
        }
        return null;
    }
}