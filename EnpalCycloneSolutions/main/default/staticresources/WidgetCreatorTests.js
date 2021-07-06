/** 
 * Name : WidgetCreatorTests.js
 * Type : StaticResource
 * Purpose : This test suite contains specs for testing WidgetCreatorComponent.
 * 			 These tests are written using the [Jasmine framework](https://jasmine.github.io/2.1/introduction).
 * Author : Vinay Srinivasa
 * Date : 05/07/20201
 * Scope : Enpal - Technical Challenge
 **/

describe("WIDGET CREATOR COMPONENT TESTING", function(){
    
    afterEach(function() {
        // Each spec (test) renders its components into the same div,
        // so we need to clear that div out at the end of each spec.
        $T.clearRenderedTestComponents();
    });
    describe('c:WidgetCreatorComponent1', function(){
        it("Verifies Component Rendering", function(done) {
            $T.createComponent("c:WidgetCreatorComponent", {}, true)
            .then(function(component){
                expect(component.find("welcome").getElement().innerHTML).toContain('WELCOME TO CYCLONE SOLUTIONS');
                done();
            }).catch(function(e) {
                done.fail(e);
            });
        });
    });
    describe('c:WidgetCreatorComponent2', function(){
        it("Verifies User Loading", function(done) {
            $T.createComponent("c:WidgetCreatorComponent", {}, true)
            .then(function(component){
                expect(component.find("recLoader").get("v.recordId")).not.toBeNull();
                done();
            }).catch(function(e) {
                done.fail(e);
            });
        });
    });
    describe('c:WidgetCreatorComponent3', function(){
        it("Verifies Widget Load", function(done) {
            $T.createComponent("c:WidgetCreatorComponent", {}, true)
            .then(function(component){
                expect(component.find("recCreator").get("v.recordId")).not.toBeNull();
                done();
            }).catch(function(e) {
                done.fail(e);
            });
        });
    });
    describe('c:WidgetCreatorComponent4', function(){
        it("Verifies Button Click", function(done) {
            var widget = {
                "Value__c" : "{{}}{{}}",
            };
            $T.createComponent("c:WidgetCreatorComponent", {recordFields:widget}, true)
            .then(function(component){
                document.getElementById("widBox").childNodes[4].click();
                expect(component.find("recCreator").get("v.recordFields.Value__c")).not.toBeNull();
                done();
            }).catch(function(e) {
                done.fail(e);
            });
        });
    });
});
