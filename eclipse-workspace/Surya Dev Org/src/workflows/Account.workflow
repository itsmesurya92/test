<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TestTest</fullName>
        <description>TestTest</description>
        <protected>false</protected>
        <recipients>
            <recipient>itsmesurya92@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <rules>
        <fullName>When a New Record Created</fullName>
        <actions>
            <name>TestTest</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Congrats_You_created_a_new_Account</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Congrats_You_created_a_new_Account</fullName>
        <assignedTo>itsmesurya92@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Account.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>“Congrats! You created a new Account.”</subject>
    </tasks>
    <tasks>
        <fullName>HIII</fullName>
        <assignedTo>itsmesurya92@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>hi</description>
        <dueDateOffset>4</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Account.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>HIII</subject>
    </tasks>
</Workflow>
