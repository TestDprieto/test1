<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Discount_Percent_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_Approved</fullName>
        <field>Discount_Percent_Status__c</field>
        <literalValue>Not Approved</literalValue>
        <name>Not Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>FieldUpdate Approved</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Discount_Percent__c</field>
            <operation>greaterThan</operation>
            <value>0.4</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
