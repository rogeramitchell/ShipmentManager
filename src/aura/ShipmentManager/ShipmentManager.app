<aura:application controller="ShipmentManager" extends="force:slds">
	<!-- AURA SPECIFIC ATTRIBUTES -->
    <aura:attribute name="containers" type="Container__c[]"/>
    <aura:attribute name="selectedContainer" type="Container__c" />
    <aura:attribute name="boxes" type="Box__c[]"/>
    <aura:attribute name="newBox" type="Box__c" default="{'sobjectType' : 'Box__c'}"/>
    <aura:attribute name="showModal" type="Boolean" default="false" />
    <aura:handler name="init" value="{!this}" action="{!c.doInit}" />
    <!-- CORE MARKUP -->
    <div class="slds">
        <div class="slds-page-header">
            <div class="slds-grid">
                <div class="slds-col slds-has-flexi-truncate">
                    <p class="slds-text-heading--label">Shipment Manager</p>
                    <div class="slds-grid">
                        <div class="slds-grid slds-no-space">
                            <h1 class="slds-text-heading--medium slds-truncate" title="My Expenses">Manage Shipments &amp; Boxes</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- COMPONENT CANDIDATE 1: TABLE OF EXISTING CONTAINERS -->
        <div id="containers-table-wrapper" class="container">
            <div class="slds-text-heading--medium">Containers</div>
        	<table class="slds-table slds-table--bordered slds-table--cell-buffer">
                <thead>
                    <tr class="slds-text-title--caps">
                        <th scope="col">
                            <div class="slds-truncate" title="Container Name">Container Name</div>
                        </th>
                        <th scope="col">
                            <div class="slds-truncate" title="Start Date">Start Date</div>
                        </th>
                        <th scope="col">
                            <div class="slds-truncate" title="End Date">End Date</div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <aura:iteration items="{!v.containers}" var="container" >
                        <tr id="{!container.Id}" onclick="{!c.selectContainer}" style="{!v.selectedContainer == container.Id ? 'background-color: lightblue;' : '' }">
                            <td data-label="Container Name">
                                <div class="slds-truncate" title="{!container.Name}">{!container.Name}</div>
                            </td>
                            <td data-label="Start Date">
                                <div class="slds-truncate" title="{!container.Start_Date__c}">
                                    <ui:outputDate value="{!container.Start_Date__c}" format="M/D/YYYY" />
                                </div>
                            </td>
                            <td data-label="End Date">
                                <div class="slds-truncate" title="{!container.End_Date__c}">
                                    <ui:outputDate value="{!container.End_Date__c}" format="M/D/YYYY" />
                                </div>
                            </td>
                        </tr>
                    </aura:iteration>
                </tbody>
            </table>
        </div>
        <!-- COMPONENT CANDIDATE 2: TABLE OF EXISTING BOXES FOR SELECTED CONTAINER -->
        <div id="boxes-table-wrapper" class="container">
        	<div class="slds-text-heading--medium">Boxes</div>
            <div style="{!v.selectedContainer ? 'display: none;' : ''}">Select a container from above to view the current manifest of boxes.</div>
            <div style="{!!v.selectedContainer ? 'display: none;' : ''}">
                <lightning:button label="Add Box" variant="brand" onclick="{!c.displayModal}" />
                <table class="slds-table slds-table--bordered slds-table--cell-buffer">
                    <thead>
                        <tr class="slds-text-title--caps">
                            <th scope="col">
                                <div class="slds-truncate" title="Box Name">Box Name</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Date Received">Date Received</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Amount">Amount</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Width">Width</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Height">Height</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Depth">Depth</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Volume">Volume</div>
                            </th>
                            <th scope="col">
                                <div class="slds-truncate" title="Surface Area">Surface Area</div>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <aura:iteration items="{!v.boxes}" var="box" >
                            <tr>
                                <td data-label="Box Name">
                                    <div class="slds-truncate" title="{!box.Name}">{!box.Name}</div>
                                </td>
                                <td data-label="Date Received">
                                    <div class="slds-truncate" title="{!box.Date_Received__c}">
                                        <ui:outputDate value="{!box.Date_Received__c}" format="M/D/YYYY" />
                                    </div>
                                </td>
                                <td data-label="Amount">
                                    <div class="slds-truncate" title="{!box.Amount__c}">{!box.Amount__c}</div>
                                </td>
                                <td data-label="Width">
                                    <div class="slds-truncate" title="{!box.Width__c}">{!box.Width__c}</div>
                                </td>
                                <td data-label="Height">
                                    <div class="slds-truncate" title="{!box.Height__c}">{!box.Height__c}</div>
                                </td>
                                <td data-label="Depth">
                                    <div class="slds-truncate" title="{!box.Depth__c}">{!box.Depth__c}</div>
                                </td>
                                <td data-label="Volume">
                                    <div class="slds-truncate" title="{!box.Volume__c}">{!box.Volume__c}</div>
                                </td>
                                <td data-label="Surface Area">
                                    <div class="slds-truncate" title="{!box.Surface_Area__c}">{!box.Surface_Area__c}</div>
                                </td>
                            </tr>
                        </aura:iteration>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- COMPONENT CANDIDATE 3: ADD BOX MODAL -->
        <div id="add-box-modal" style="{!!v.showModal ? 'display: none;' : ''}">
            <div role="dialog" tabindex="-1" aria-labelledby="header43" class="slds-modal slds-fade-in-open">
                <div class="slds-modal__container">
                    <div class="slds-modal__header">
                        <button class="slds-button slds-modal__close slds-button--icon-inverse" onclick="{!c.hideModal}" title="Close"><span class="slds-assistive-text">Close</span>X</button>
                        <h2 id="add-box-header" class="slds-text-heading--medium">Add a New Box</h2>
                    </div>
                    <div class="slds-modal__content slds-p-around--medium">
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Box Name</label>
                            <div class="slds-form-element__control">
                                <ui:inputText value="{!v.newBox.Name}" required="true" />
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Date Received</label>
                            <div class="slds-form-element__control">
                                <ui:inputDate value="{!v.newBox.Date_Received__c}" format="M/D/YYYY" required="true" displayDatePicker="true"/>
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Width</label>
                            <div class="slds-form-element__control">
                                <ui:inputNumber value="{!v.newBox.Width__c}" change="{!c.calculateComputedFields}" required="true"/>
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Height</label>
                            <div class="slds-form-element__control">
                                <ui:inputNumber value="{!v.newBox.Height__c}" change="{!c.calculateComputedFields}" required="true"/>
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Depth</label>
                            <div class="slds-form-element__control">
                                <ui:inputNumber value="{!v.newBox.Depth__c}" change="{!c.calculateComputedFields}" required="true"/>
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Volume</label>
                            <div class="slds-form-element__control">
                                <ui:inputNumber value="{!v.newBox.Volume__c}" disabled="true"/>
                            </div>
                        </div>
                        <div class="slds-form-element">
                            <label class="slds-form-element__label">Surface Area</label>
                            <div class="slds-form-element__control">
                                <ui:inputNumber value="{!v.newBox.Surface_Area__c}" disabled="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="slds-modal__footer">
                        <button class="slds-button slds-button--neutral" onclick="{!c.hideModal}">Cancel</button>
                        <button class="slds-button slds-button--brand" onclick="{!c.saveBox}">Save</button>
                    </div>
                </div>
            </div>
            <div class="slds-backdrop slds-backdrop--open"></div>
        </div>
    </div>
</aura:application>