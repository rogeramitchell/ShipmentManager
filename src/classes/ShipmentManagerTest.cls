@isTest
public class ShipmentManagerTest 
{
    static testMethod void getContainers()
    {
        List<Container__c> containersTest = new List<Container__c>();
        for(Integer i = 0; i < 10; i++)
        {
            Container__c c = new Container__c();
            c.Name = 'Test ' + i;
            containersTest.add(c);
        }
        
        insert containersTest;
        
        List<Container__c> containersVerify = ShipmentManager.getContainers();
        System.assertEquals(10, containersVerify.size());
    }
    
    static testMethod void getBoxes()
    {
        Container__c c = new Container__c();
        c.Name = 'Test';
        
        insert c;
        
        List<Box__c> boxesTest = new List<Box__c>();
        for(Integer i = 0; i < 10; i++)
        {
            Box__c b = new Box__c();
            b.Container__c = c.Id;
            b.Name = 'Test ' + i;
            boxesTest.add(b);
        }
        
        insert boxesTest;
        
        List<Box__c> boxesVerify = ShipmentManager.getBoxes(c.Id);
        System.assertEquals(10, boxesVerify.size());
    }
    
    static testMethod void saveBox()
    {
        Container__c c = new Container__c();
        c.Name = 'Test';
        
        insert c;
        
        Box__c b = new Box__c();
        b.Container__c = c.Id;
        b.Name = 'Test';
        
		b = ShipmentManager.saveBoxRecord(b);
        System.assertNotEquals(null, b.Id);
        System.assertNotEquals(100, b.Amount__c);
        
        b.Amount__c = 100;
        b = ShipmentManager.saveBoxRecord(b);
        System.assertNotEquals(null, b.Id);
        System.assertEquals(100, b.Amount__c);
    }
}