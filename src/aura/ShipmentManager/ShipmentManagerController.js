({
    doInit : function(component, event, helper) {
       	helper.getContainers(component);
    },
    selectContainer : function(component, event, helper) {
		let containerId = event.currentTarget.id;
        helper.getBoxes(component, containerId);
    },
    displayModal : function(component, event, helper) {
        component.set("v.showModal", true);
        component.set("v.newBox.Container__c", component.get("v.selectedContainer"));
        console.log(component.get("v.newBox.Container__c"));
    },
    hideModal : function(component, event, helper) {
        component.set("v.showModal", false);
        component.set("v.newBox", {'sobjectType' : 'Box__c'});
    },
    calculateComputedFields : function(component, event, helper) {        
        let width = component.get("v.newBox.Width__c");
        let height = component.get("v.newBox.Height__c");
		let depth = component.get("v.newBox.Depth__c");
        let volume = 0;
        let surfaceArea = 0;
              
        if(width > 0 && height > 0 && depth > 0) {
            console.log('yep');
			volume = width * height * depth;
            surfaceArea = 2 * (width * height + height * depth + width * depth);
        }
        
        component.set("v.newBox.Volume__c", volume);
        component.set("v.newBox.Surface_Area__c", surfaceArea);
    },
    saveBox : function(component, event, helper) {
        helper.saveBox(component);
    }
})