/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateEcommCartBatch implements Database.Batchable<Object>, Database.Stateful {
    global CreateEcommCartBatch(Map<String,Object> inputMap) {

    }
    global void execute(Database.BatchableContext BC, List<Object> inputList) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global static void sendStatusEmail(Database.BatchableContext bc, String mailBody, Integer batchNumber, Boolean hasErrors) {

    }
    global System.Iterable start(Database.BatchableContext BC) {
        return null;
    }
}
