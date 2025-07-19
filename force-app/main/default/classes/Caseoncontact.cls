/*
 *When Case Created & create check box is true createtask on Primary contact
*/

public class Caseoncontact {

    public static void createcase(List<case>newcase, Map<id,case> oldcase){
        set<id> caseid = new Set<id> ();
        set<id> Accid = new Set<id> ();
        list<task> lsttask = new List<task>();
        for(case cs: newcase){
            if(cs.Create_Task__c != oldcase.get(cs.id).Create_Task__c && cs.Create_Task__c == true){
                caseid.add(cs.id);
                Accid.add(cs.accountid);
            }
        List<account> lstacc = [Select id,name,(select id,Primary_Contact__c from contacts where Primary_Contact__c = true) from Account Where id IN : accid];
            for(account acc : lstacc){
                for(contact con : acc.contacts){
                    Task newtask = new task();
                    newtask.WhatId = con.id;
                    newtask.Status = 'Completed';
                    lsttask.add(newtask);
                }
            }
            if(!lsttask.isempty()){
                insert lsttask;
                System.debug(lsttask);
            }
        }    
    }
}