declare module "@salesforce/apex/ManageCandidateRecord.getRecords" {
  export default function getRecords(): Promise<any>;
}
declare module "@salesforce/apex/ManageCandidateRecord.deleteRecords" {
  export default function deleteRecords(param: {recordsToDelete: any}): Promise<any>;
}
