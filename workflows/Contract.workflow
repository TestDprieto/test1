<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_to_Awaiting_Approval</fullName>
        <field>Status</field>
        <literalValue>Awaiting Approval</literalValue>
        <name>Change to Awaiting Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateApprovalStatus</fullName>
        <field>Status</field>
        <literalValue>Negotiating</literalValue>
        <name>UpdateApprovalStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateRejectStatus</fullName>
        <field>Status</field>
        <literalValue>Rejected internally</literalValue>
        <name>UpdateRejectStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
