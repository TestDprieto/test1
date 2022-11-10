<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>vlocity_cmt__ReferenceIdForOrderPromotionUpdate</fullName>
        <field>Name</field>
        <formula>Id</formula>
        <name>ReferenceIdForOrderPromotionUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>vlocity_cmt__ReferenceIdForOrderPromotionUpdate</fullName>
        <actions>
            <name>vlocity_cmt__ReferenceIdForOrderPromotionUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISPICKVAL(vlocity_cmt__Action__c, &apos;Add&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
