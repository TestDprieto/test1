/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class VlocityBatchFramework implements Database.AllowsCallouts, Database.Batchable<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Callable, System.Iterable<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Iterator<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Schedulable, omnistudio.VlocityOpenInterface2 {
    global VlocityBatchFramework() {

    }
    global VlocityBatchFramework(List<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations> input) {

    }
    global VlocityBatchFramework(String frequency) {

    }
    global VlocityBatchFramework(List<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations> input, Map<String,Object> options) {

    }
    global VlocityBatchFramework(Map<String,Object> inputData, Map<String,Object> options) {

    }
    global VlocityBatchFramework(List<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations> input, Map<String,Object> inputMap, Map<String,Object> options) {

    }
    global static void abortBatchJobs() {

    }
    global static void abortScheduledBatchJob() {

    }
    global Object call(String action, Map<String,Object> args) {
        return null;
    }
    global void execute(System.SchedulableContext ctx) {

    }
    global void execute(Database.BatchableContext context, List<omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations> scope) {

    }
    global void finish(Database.BatchableContext context) {

    }
    global static List<AsyncApexJob> getCurrentBatchJobs() {
        return null;
    }
    global static Datetime getNextFireTime(String frequency) {
        return null;
    }
    global static List<CronTrigger> getScheduledBatchJob() {
        return null;
    }
    global static String getTimeInCronFormat(Datetime dTime) {
        return null;
    }
    global Boolean hasNext() {
        return null;
    }
    global Object invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        return null;
    }
    global System.Iterator iterator() {
        return null;
    }
    global omnistudio.VlocityBatchFramework.VlocityScheduledJobIterations next() {
        return null;
    }
    global static Boolean shouldExecuteJob(Datetime nextRunDateTime) {
        return null;
    }
    global System.Iterable start(Database.BatchableContext context) {
        return null;
    }
    global String startBatchScheduler(String frequency) {
        return null;
    }
    global String startBatchScheduler(Map<String,Object> inputData, Map<String,Object> options) {
        return null;
    }
    global static void startBatchWithData(Map<String,Object> inputMap, Map<String,Object> options) {

    }
    global static Id startBatch(String Id, Map<String,Object> inputMap, Map<String,Object> options) {
        return null;
    }
    global static Object startBatches(List<Map<String,Object>> processMapsList, Map<String,Object> options) {
        return null;
    }
    global static void startIntegrationProcedureBatch(String processName, List<Object> input, Map<String,Object> options) {

    }
    global static void startOpenInterfaceBatch(String processName, List<Object> input, Map<String,Object> options) {

    }
    global static void startScheduledJob(Id vlocityScheduledJobId) {

    }
    global static void startScheduledJobs() {

    }
    global static void startScheduledJobs(List<Id> vlocityScheduledJobIds) {

    }
    global static void startScheduledJobs(Map<String,Object> inputData, Map<String,Object> options) {

    }
global class VlocityScheduledJobIterations {
    global VlocityScheduledJobIterations() {

    }
}
}
