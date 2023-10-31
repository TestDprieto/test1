/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SfiEnergyConsoleFSAPIWrapper {
    global Datetime arrivalWindowEndTime;
    global Datetime arrivalWindowStartTime;
    global String contactEmail;
    global String contactName;
    global String currentRange;
    global String currentRangeDT;
    global String errorMessage;
    global Boolean isError;
    global String isPrevious;
    global String operatingHoursId;
    global String schedulingPolicyId;
    global Datetime servApptDueDate;
    global Datetime servApptStartDate;
    global String serviceAddress;
    global String serviceAppointmentValue;
    global String serviceAppointmentValueForReschedule;
    global String serviceDescription;
    global String serviceTerritory;
    global List<vlocity_cmt.SfiEnergyConsoleFSAPIWrapper.SlotsWrapper> slotsValue;
    global String timeZone;
    global String workOrderId;
    global String workType;
    global SfiEnergyConsoleFSAPIWrapper() {

    }
global class CreateSlotsParam {
    global Datetime arrivalWindowEndTime;
    global Datetime arrivalWindowStartTime;
    global String contactEmail;
    global String contactName;
    global Id schedulingPolicyId;
    global Datetime servApptDueDate;
    global Datetime servApptStartDate;
    global String serviceAddress;
    global Id serviceAppointmentId;
    global String serviceAppointmentValueForReschedule;
    global String serviceDescription;
    global String serviceTerritory;
    global Integer slotForDays;
    global Id workOrderId;
    global String workType;
    global CreateSlotsParam() {

    }
}
global class SlotsWrapper {
    global String dateSlot;
    global String endTimeVal;
    global Decimal grade;
    global String intervalDate;
    global String intervalDateDT;
    global Boolean newGroupStarts;
    global String startTimeVal;
    global String timeSlot;
    global String timeVal;
    global SlotsWrapper() {

    }
}
}
