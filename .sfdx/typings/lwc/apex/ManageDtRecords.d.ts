declare module "@salesforce/apex/ManageDtRecords.getRecords" {
  export default function getRecords(param: {dataModel: any, dataModelTarget: any, searchType: any, searchFilter: any}): Promise<any>;
}
declare module "@salesforce/apex/ManageDtRecords.deleteRecords" {
  export default function deleteRecords(param: {recordsToDelete: any}): Promise<any>;
}
declare module "@salesforce/apex/ManageDtRecords.createRecord" {
  export default function createRecord(param: {record: any}): Promise<any>;
}
