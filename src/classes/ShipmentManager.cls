public class ShipmentManager
{
	@AuraEnabled
    public static List<Container__c> getContainers()
    {
        return [SELECT Id, Name, Start_Date__c, End_Date__c FROM Container__c ORDER BY Start_Date__c ASC];
    }
    
    @AuraEnabled
    public static List<Box__c> getBoxes(Id containerId)
    {
        System.debug(containerId);
        return [SELECT Id, Name, Container__c, Amount__c, Date_Received__c, Width__c, Height__c, Depth__c, Volume__c, Surface_Area__c FROM Box__c WHERE Container__c = :containerId ORDER BY Date_Received__c ASC];
    }
    
    @AuraEnabled
    public static Box__c saveBoxRecord(Box__c box)
    {
        upsert box;
        return box;
    }
}