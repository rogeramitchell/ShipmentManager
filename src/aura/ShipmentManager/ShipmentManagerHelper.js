({
    getContainers: function(component) {
        let action = component.get("c.getContainers");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.containers", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    getBoxes : function(component, containerId) {
        let action = component.get("c.getBoxes");
        action.setParams({ containerId : containerId });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(component.isValid() && state === "SUCCESS") {
                component.set("v.boxes", response.getReturnValue());
                component.set("v.selectedContainer", containerId);
            }
        });
        $A.enqueueAction(action);
    },
    saveBox : function(component) {
        let newBox = component.get("v.newBox");
        let boxes = component.get("v.boxes");
        let action = component.get("c.saveBoxRecord");        
        action.setParams({ box : newBox });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(component.isValid() && state === "SUCCESS") {
                boxes.push(response.getReturnValue());
                component.set("v.boxes", boxes);
                component.set("v.newBox", { 'sobjectType' : 'Box__c'});
                component.set("v.showModal", false);
            }
        });
                
        $A.enqueueAction(action);
    }
})