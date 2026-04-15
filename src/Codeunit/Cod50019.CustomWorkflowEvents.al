//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50019 "Custom Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]

    procedure AddEventsToLib()
    begin

        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Payment Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPaymentDocForApprovalCode,
                                    Database::"Payments Header", 'Approval of a Payment Document is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPaymentApprovalRequestCode,
                                    Database::"Payments Header", 'An Approval request for a Payment Document is Canceled.', 0, false);

        //Membership Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode,
                                    Database::"Membership Applications", 'Approval of Membership Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode,
                                    Database::"Membership Applications", 'An Approval request for  Membership Application is canceled.', 0, false);

        //Mobile Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMobileApplicationForApprovalCode,
                                    Database::"MOBILE Applications", 'Approval of Mobile Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMobileApplicationApprovalRequestCode,
                                    Database::"MOBILE Applications", 'An Approval request for  Mobile Application is canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectMobileApplicationApprovalRequestCode,
                                    Database::"MOBILE Applications", 'An Approval request for  Mobile Application is Rejected.', 0, false);
        //Erroneous Loan Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanApplicationForApprovalCode,
                                    Database::"Loans Register", 'Approval of a Loan Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanApplicationApprovalRequestCode,
                                    Database::"Loans Register", 'An Approval request for a Loan Application is Canceled.', 0, false);
        // //Loan Application
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanApplicationsForApprovalCode,
        //                             Database::"Loans Register", 'Approval of an Applied Loan is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanApplicationsApprovalRequestCode,
        //                             Database::"Loans Register", 'An Approval request for an Applied Loan is Canceled.', 0, false);
        //Loan Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanAppliedForApprovalCode,
                                    Database::"Loans Register", 'Approval of an Appraised Loan is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanAppliedApprovalRequestCode,
                                    Database::"Loans Register", 'An Approval request for an Appraised Loan is Canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectLoanAppliedApprovalRequestCode,
                                    Database::"Loans Register", 'An Approval request for an Appraised Loan is Rejected.', 0, false);

        //Closure Notice
        WFHandler.AddEventToLibrary(RunWorkflowOnSendClosureNoticeApplicationForApprovalCode,
                                    Database::"Withdrawal Notice", 'Approval of a Closure Notice Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelClosureNoticeApplicationApprovalRequestCode,
                                    Database::"Withdrawal Notice", 'An Approval request for Closure Notice is canceled.', 0, false);
        //Guarantor Substitution
        WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorSubstitutionForApprovalCode,
                                    Database::"Guarantorship Substitution H", 'Approval of a Guarantor Substitution is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode,
                                    Database::"Guarantorship Substitution H", 'An Approval request for a Guarantor Substitution is Canceled.', 0, false);

        //Loan Disbursement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanDisbursementForApprovalCode,
                                    Database::"Loan Disburesment-Batching", 'Approval of a Loan Disbursement is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode,
                                    Database::"Loan Disburesment-Batching", 'An Approval request for a Loan Disbursement is canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectLoanDisbursementApprovalRequestCode,
                                    Database::"Loan Disburesment-Batching", 'An Approval request for a Loan Disbursement is Rejected.', 0, false);

        //Member Exit BAtch
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberExitBatchForApprovalCode,
                                    Database::"Member Exit Batch", 'Approval of a Member Exit Batch is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberExitBatchApprovalRequestCode,
                                    Database::"Member Exit Batch", 'An Approval request for a Member Exit Batch is canceled.', 0, false);

        //Standing Orders
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStandingOrderForApprovalCode,
                                    Database::"Standing Orders", 'Approval of a Standing Order is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStandingOrderApprovalRequestCode,
                                    Database::"Standing Orders", 'An Approval request for a Standing Order is canceled.', 0, false);

        //Standing Orders
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSTOForApprovalCode,
                                    Database::"Standing Orders", 'Approval of an STO is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSTOApprovalRequestCode,
                                    Database::"Standing Orders", 'An Approval request for an STO is canceled.', 0, false);


        //Membership Withdrawal
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMWithdrawalForApprovalCode,
                                    Database::"Membership Exist", 'Approval of a Membership Withdrawal is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMWithdrawalApprovalRequestCode,
                                    Database::"Membership Exist", 'An Approval request for a Membership Withdrawal is canceled.', 0, false);
        //ATM Card Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendATMCardForApprovalCode,
                                    Database::"ATM Card Applications", 'Approval of  ATM Card is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelATMCardApprovalRequestCode,
                                    Database::"ATM Card Applications", 'An Approval request for  ATM Card is canceled.', 0, false);
        //Guarantor Recovery
        WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorRecoveryForApprovalCode,
                                    Database::"Loan Recovery Header", 'Approval of Guarantor Recovery is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode,
                                    Database::"Loan Recovery Header", 'An Approval request for Guarantor Recovery is canceled.', 0, false);

        //Change Request
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChangeRequestForApprovalCode,
                                    Database::"Change Request", 'Approval of Change Request is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChangeRequestApprovalRequestCode,
                                    Database::"Change Request", 'An Approval request for Change Request is canceled.', 0, false);

        //Treasury Transactions
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTTransactionsForApprovalCode,
                                    Database::"Treasury Transactions", 'Approval of Treasury Transaction is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTTransactionsApprovalRequestCode,
                                    Database::"Treasury Transactions", 'An Approval request for Treasury Transaction is canceled.', 0, false);

        //FOSA Account Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFAccountApplicationForApprovalCode,
                                    Database::"FOSA Account Applicat. Details", 'Approval of FOSA Account Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode,
                                    Database::"FOSA Account Applicat. Details", 'An Approval request for FOSA Account Application is canceled.', 0, false);
        //Stores Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSReqApplicationForApprovalCode,
                                    Database::"Store Requistion Header", 'Approval of Stores Requisition Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSReqApplicationApprovalRequestCode,
                                    Database::"Store Requistion Header", 'An Approval request for Stores Requisition Application is canceled.', 0, false);

        //Sacco Transfer
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSaccoTransferForApprovalCode,
                                    Database::"Sacco Transfers", 'Approval of Sacco Transfer is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSaccoTransferApprovalRequestCode,
                                    Database::"Sacco Transfers", 'An Approval request for Sacco Transfer is canceled.', 0, false);

        //Cheque Discounting
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChequeDiscountingForApprovalCode,
                                    Database::"Cheque Discounting", 'Approval of Cheque Discounting is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode,
                                    Database::"Cheque Discounting", 'An Approval request for Cheque Discounting is canceled.', 0, false);
        //Imprest Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestRequisitionForApprovalCode,
                                    Database::"Imprest Header", 'Approval of Imprest Requisition is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode,
                                    Database::"Imprest Header", 'An Approval request for Imprest Requisition is canceled.', 0, false);
        //Imprest Surrender
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestSurrenderForApprovalCode,
                                    Database::"Imprest Surrender Header", 'Approval of Imprest Surrender is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode,
                                    Database::"Imprest Surrender Header", 'An Approval request for Imprest Surrender is canceled.', 0, false);
        //Leave Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveApplicationForApprovalCode,
                                    Database::"HR Leave Application", 'Approval of Leave Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode,
                                    Database::"HR Leave Application", 'An Approval request for Leave Application is canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectLeaveApplicationApprovalRequestCode,
                                    Database::"HR Leave Application", 'An Approval request for Leave Application is Rejected.', 0, false);

        //Bulk Withdrawal
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBulkWithdrawalForApprovalCode,
                                    Database::"Bulk Withdrawal Application", 'Approval of  Bulk Withdrawal is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode,
                                    Database::"Bulk Withdrawal Application", 'An Approval request for  Bulk Withdrawal is canceled.', 0, false);

        //Package Lodging
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageLodgeForApprovalCode,
                                    Database::"Safe Custody Package Register", 'Approval of  Package Lodging is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageLodgeApprovalRequestCode,
                                    Database::"Safe Custody Package Register", 'An Approval request for  Package Lodging is canceled.', 0, false);

        //Package Retrieval
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageRetrievalForApprovalCode,
                                    Database::"Package Retrieval Register", 'Approval of  Package Retrieval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode,
                                    Database::"Package Retrieval Register", 'An Approval request for  Package Retrieval is canceled.', 0, false);

        //House Change
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseChangeForApprovalCode,
                                    Database::"House Group Change Request", 'Approval of  House Change is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseChangeApprovalRequestCode,
                                    Database::"House Group Change Request", 'An Approval request for  House Change is canceled.', 0, false);

        //CRM Training
        WFHandler.AddEventToLibrary(RunWorkflowOnSendCRMTrainingForApprovalCode,
                                    Database::"CRM Trainings", 'Approval of  CRM Training is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelCRMTrainingApprovalRequestCode,
                                    Database::"CRM Trainings", 'An Approval request for  CRM Training is canceled.', 0, false);

        //Petty Cash
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPettyCashForApprovalCode,
                                    Database::"Payment Header.", 'Approval of  Petty Cash is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPettyCashApprovalRequestCode,
                                    Database::"Payment Header.", 'An Approval request for  Petty Cash is canceled.', 0, false);

        //Staff Claims
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStaffClaimsForApprovalCode,
                                    Database::"Staff Claims Header", 'Approval of  Staff Claims is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,
                                    Database::"Staff Claims Header", 'An Approval request for  Staff Claims is canceled.', 0, false);

        //Member Agent/NOK Change
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode,
                                    Database::"Member Agent/Next Of Kin Chang", 'Approval of  Member Agent/NOK Change is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode,
                                    Database::"Member Agent/Next Of Kin Chang", 'An Approval request for  Member Agent/NOK Change is canceled.', 0, false);

        //House Registration
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseRegistrationForApprovalCode,
                                    Database::"House Groups Registration", 'Approval of  House Registration is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode,
                                    Database::"House Groups Registration", 'An Approval request for House Registration is canceled.', 0, false);

        //Loan PayOff
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanPayOffForApprovalCode,
                                    Database::"Loan PayOff", 'Approval of  Loan PayOff is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanPayOffApprovalRequestCode,
                                    Database::"Loan PayOff", 'An Approval request for Loan PayOff  is canceled.', 0, false);

        //Fixed Deposit Placement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFixedDepositForApprovalCode,
                                    Database::"Fixed Deposit Placement", 'Approval of  Fixed Deposit is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFixedDepositApprovalRequestCode,
                                    Database::"Fixed Deposit Placement", 'An Approval request for Fixed Deposit  is canceled.', 0, false);

        //EFT/RTGS Approval
        WFHandler.AddEventToLibrary(RunWorkflowOnSendEFTRTGSForApprovalCode,
                                    Database::"EFT/RTGS Header", 'Approval of  EFT/RTGS is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelEFTRTGSApprovalRequestCode,
                                    Database::"EFT/RTGS Header", 'An Approval request for EFT/RTGS   is canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectEFTRTGSApprovalRequestCode,
                                    Database::"EFT/RTGS Header", 'An Approval request for EFT/RTGS is Rejected.', 0, false);
        //Loan Demand Notice
        WFHandler.AddEventToLibrary(RunWorkflowOnSendDemandNoticeForApprovalCode,
                                    Database::"Default Notices Register", 'Approval of  Loan Demand Notice is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCanceDemandNoticeApprovalRequestCode,
                                    Database::"Default Notices Register", 'An Approval request for Loan Demand Notice is canceled.', 0, false);

        //Over Draft
        WFHandler.AddEventToLibrary(RunWorkflowOnSendOverDraftForApprovalCode,
                                    Database::"OverDraft Application", 'Approval of  Over Draft is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelOverDraftApprovalRequestCode,
                                    Database::"OverDraft Application", 'An Approval request for Over Draft is canceled.', 0, false);

        //Loan Restructure
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanRestructureForApprovalCode,
                                    Database::"Loan Restructure", 'Approval of  Loan Restructure is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanRestructureApprovalRequestCode,
                                    Database::"Loan Restructure", 'An Approval request for Loan Restructure is canceled.', 0, false);

        //Sweeping Instructions
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSweepingInstructionsForApprovalCode,
                                    Database::"Member Sweeping Instructions", 'Approval of  Sweeping Instructions is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode,
                                    Database::"Member Sweeping Instructions", 'An Approval request for Sweeping Instructions is canceled.', 0, false);

        //Cheque Book
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChequeBookForApprovalCode,
                                    Database::"Cheque Book Application", 'Approval of  Cheque Book is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChequeBookApprovalRequestCode,
                                    Database::"Cheque Book Application", 'An Approval request for Cheque Book is canceled.', 0, false);

        //Loan Trunch Disbursement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode,
                                    Database::"Loan trunch Disburesment", 'Approval of  Loan Trunch is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode,
                                    Database::"Loan trunch Disburesment", 'An Approval request for Loan Trunch is canceled.', 0, false);

        //Inward Cheque Clearing
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInwardChequeClearingForApprovalCode,
                                    Database::"Cheque Receipts-Family", 'Approval of  Inward Cheque Clearing is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode,
                                    Database::"Cheque Receipts-Family", 'An Approval request for Inward Cheque Clearing is canceled.', 0, false);

        //Invalid Paybill Transactions
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode,
                                    Database::"Paybill Processing Header", 'Approval of  Invalid Paybill Deposit is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode,
                                    Database::"Paybill Processing Header", 'An Approval request for Invalid Paybill Deposit is canceled.', 0, false);

        //Internal PV
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInternalPVForApprovalCode,
                                    Database::"Internal PV Header", 'Approval of  Internal PV  is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInternalPVApprovalRequestCode,
                                    Database::"Internal PV Header", 'An Approval request for Internal PV is canceled.', 0, false);

        //Salary Processing
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSalaryProcessingForApprovalCode,
                                    Database::"Salary Processing Headerr", 'Approval of  Salary Processing  is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSalaryProcessingApprovalRequestCode,
                                    Database::"Salary Processing Headerr", 'An Approval request for Salary Processing is canceled.', 0, false);

        //Funeral Rider
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFRFeePayForApprovalCode,
                                    Database::"Funeral Rider Processing", 'Approval of Funeral Rider Fee is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFRFeePayApprovalRequestCode,
                                    Database::"Funeral Rider Processing", 'An Approval Request for Funeral Rider Fee is Canceled.', 0, false);

        //BOD Honoraria
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBODHonorariumForApprovalCode,
                                    Database::"BOD Honoraria", 'Approval of BOD Honoraria is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBODHonorariumApprovalRequestCode,
                                    Database::"BOD Honoraria", 'An Approval Request for BOD Honoraria is Cancelled.', 0, false);

        //ESS Refund
        WFHandler.AddEventToLibrary(RunWorkflowOnSendESSRefundBatchForApprovalCode,
                                    Database::"ESS Refund Batch", 'Approval of ESS Refund is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelESSRefundBatchApprovalRequestCode,
                                    Database::"ESS Refund Batch", 'An Approval Request for ESS Refund is Cancelled.', 0, false);

        //Supervisor Approval
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveSuperForApprovalCode,
                                    Database::"Leave Supervisor Approval", 'Supervisor Leave App Approval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveSuperApprovalRequestCode,
                                    Database::"Leave Supervisor Approval", 'A Supervisor Leave App Approval Request is Canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectLeaveSuperApprovalRequestCode,
                                    Database::"Leave Supervisor Approval", 'A Supervisor Leave App Approval Request is Rejected.', 0, false);

        //Staff Self Performance Appraisal
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode,
                                    Database::"HR Appraisal Header", 'Staff Performance Appraisal Approval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequestCode,
                                    Database::"HR Appraisal Header", 'A Staff Performance Appraisal Approval Request is Canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequestCode,
                                    Database::"HR Appraisal Header", 'A Staff Performance Appraisal Request is Rejected.', 0, false);

        //Savings Variation
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSavingsVarDocForApprovalCode,
                                    Database::"Savings Variation", 'Member Savings Variation Approval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSavingsVarApprovalRequestCode,
                                    Database::"Savings Variation", 'Member Savings Variation Approval Request is Canceled.', 0, false);

        //Loan Limit Variation
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanLimitDocForApprovalCode,
                                    Database::"Credit Rating", 'Credit Rating Loan Limit Variation Approval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanLimitApprovalRequestCode,
                                    Database::"Credit Rating", 'Credit Rating Loan Limit Variation Approval Request is Canceled.', 0, false);

        //Member Allowances
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberAllowanceForApprovalCode,
                                    Database::"Sacco Meetings", 'Member Allowance Approval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberAllowanceApprovalRequestCode,
                                    Database::"Sacco Meetings", 'Member Allowance Approval Request is Canceled.', 0, false);


        //File Movement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFileMovementForApprovalCode,
                                    Database::"File Movement Header", 'Approval of A File Movement Requisition is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFileMovementApprovalRequestCode,
                                    Database::"File Movement Header", 'An Approval Request for A File Movement Requisition is Cancelled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectFileMovementApprovalRequestCode,
                                    Database::"File Movement Header", 'An Approval Request for A File Movement Requisition is Rejected.', 0, false);

        //File Movement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBOSAReceiptForApprovalCode,
                                    Database::"Receipts & Payments", 'Approval of A BOSA Receipt is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBOSAReceiptApprovalRequestCode,
                                    Database::"Receipts & Payments", 'An Approval Request for A BOSA Receipt is Cancelled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnRejectBOSAReceiptApprovalRequestCode,
                                    Database::"Receipts & Payments", 'An Approval Request for A BOSA Receipt is Rejected.', 0, false);

        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]

    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Payment Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);

        //Membership Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

        //Mobile Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMobileApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectMobileApplicationApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMobileApplicationForApprovalCode);

        // //Erroneous Loan Application
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);
        // //Loan Application
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanApplicationsForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanApplicationsForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanApplicationsForApprovalCode);
        //Loan Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanAppliedForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectLoanAppliedApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanAppliedForApprovalCode);
        //Closure Notice
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClosureNoticeApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendClosureNoticeApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendClosureNoticeApplicationForApprovalCode);

        //Guarantor Substitution
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);

        //Loan Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectLoanDisbursementApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanDisbursementForApprovalCode);

        //MemberExitBatch
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberExitBatchForApprovalCode);

        //Standing Order
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);

        //Standing Order
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSTOForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSTOForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSTOForApprovalCode);

        //Membership Withdrawal
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);

        //ATM Card Applications
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);

        //Guarantor Recovery
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);

        //Change Request
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);

        //Treasury Transaction
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);

        //FOSA Account Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);

        //Stores Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);

        //Sacco Transfer
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);

        //Cheque Discounting
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);

        //Imprest Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);

        //Imprest Surrender
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);

        //Leave Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectLeaveApplicationApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);

        //Bulk Withdrawal
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);

        //Package Lodging
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);

        //Package Retrieval
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);

        //House Change
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);

        //CRM Training
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);

        //Petty Cash
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);

        //Staff Claims
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);

        //Member Agent/NOK Change
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);

        //House Registration
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);

        //Loan Payoff
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);

        //Fixed Deposit
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);

        //EFT/RTGS
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectEFTRTGSApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendEFTRTGSForApprovalCode);

        //Loan Demand Notice
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);

        //Over Draft
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);

        //Loan Restructure
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);

        //Sweeping Instructions
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);

        //Cheque Book Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);

        //Loan Trunch Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);

        //Inward Cheque Clearing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);

        //Invalid Paybill Deposits
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);

        //Internal PV
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);

        //Salary Processing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);

        //Funeral Processing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFRFeePayForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFRFeePayForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFRFeePayForApprovalCode);


        //BOD Honorarium Processing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBODHonorariumForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBODHonorariumForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBODHonorariumForApprovalCode);


        //ESS Refund Processing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendESSRefundBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendESSRefundBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendESSRefundBatchForApprovalCode);

        //Supervisor Approval
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveSuperForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectLeaveSuperApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveSuperForApprovalCode);

        //Staff Self-Performance Appraisal
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode);

        //Savings Variation
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSavingsVarDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSavingsVarDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSavingsVarDocForApprovalCode);

        //Loan Limit Variation
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanLimitDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanLimitDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanLimitDocForApprovalCode);

        //Member Delegate Allowance
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberAllowanceForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberAllowanceForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberAllowanceForApprovalCode);

        //File Movement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFileMovementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectFileMovementApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFileMovementForApprovalCode);

        //BOSA Receipt
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBOSAReceiptForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectBOSAReceiptApprovalRequestCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBOSAReceiptForApprovalCode);

        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;


    procedure RunWorkflowOnSendPaymentDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentDocForApproval'));
    end;

    procedure RunWorkflowOnCancelPaymentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPaymentDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendPaymentDocForApproval(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentDocForApprovalCode, PaymentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPaymentApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPaymentApprovalRequest(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentApprovalRequestCode, PaymentHeader);
    end;




    procedure RunWorkflowOnSendMemberAllowanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMemberAllowanceForApproval'));
    end;

    procedure RunWorkflowOnCancelMemberAllowanceApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberAllowanceApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMemberAllowanceForApproval', '', false, false)]

    procedure RunWorkflowOnSendMemberAllowanceForApproval(var membAllowance: Record "Sacco Meetings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberAllowanceForApprovalCode, membAllowance);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMemberAllowanceRequest', '', false, false)]

    procedure RunWorkflowOnCancelMemberAllowanceApprovalRequest(var membAllowance: Record "Sacco Meetings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberAllowanceApprovalRequestCode, membAllowance);
    end;



    procedure RunWorkflowOnSendSavingsVarDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSavingsVarDocForApproval'));
    end;

    procedure RunWorkflowOnCancelSavingsVarApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSavingsVarApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSavingsVarDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendSavingsVarDocForApproval(var savingsVar: Record "Savings Variation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSavingsVarDocForApprovalCode, savingsVar);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSavingsVarApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSavingsVarApprovalRequest(var savingsVar: Record "Savings Variation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSavingsVarApprovalRequestCode, savingsVar);
    end;



    procedure RunWorkflowOnSendLoanLimitDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanLimitDocForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanLimitApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanLimitApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanLimitDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanLimitDocForApproval(var creditRating: Record "Credit Rating")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanLimitDocForApprovalCode, creditRating);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanLimitApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanLimitApprovalRequest(var creditRating: Record "Credit Rating")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanLimitApprovalRequestCode, creditRating);
    end;


    procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMembershipApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMembershipApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;



    procedure RunWorkflowOnSendFRFeePayForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFRFeePayForApproval'));
    end;

    procedure RunWorkflowOnCancelFRFeePayApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFRFeePayApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFRFeePayForApproval', '', false, false)]

    procedure RunWorkflowOnSendFRFeePayForApproval(var FRFeePay: Record "Funeral Rider Processing")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFRFeePayForApprovalCode, FRFeePay);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFRFeePayApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFRFeePayApprovalRequest(var FRFeePay: Record "Funeral Rider Processing")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFRFeePayApprovalRequestCode, FRFeePay);
    end;


    procedure RunWorkflowOnSendLeaveSuperForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveSuperForApproval'));
    end;

    procedure RunWorkflowOnCancelLeaveSuperApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveSuperApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectLeaveSuperApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLeaveSuperApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLeaveSuperForApproval', '', false, false)]

    procedure RunWorkflowOnSendLeaveSupForApproval(var LeaveSup: Record "Leave Supervisor Approval")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveSuperForApprovalCode, LeaveSup);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLeaveSuperApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLeaveSupApprovalRequest(var LeaveSup: Record "Leave Supervisor Approval")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveSuperApprovalRequestCode, LeaveSup);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectLeaveSuperApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectLeaveSupApprovalRequest(var LeaveSup: Record "Leave Supervisor Approval")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectLeaveSuperApprovalRequestCode, LeaveSup);
    end;



    procedure RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffPerformanceAppraisalForApproval'));
    end;

    procedure RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendForStaffPerformanceAppraisalApproval', '', false, false)]

    procedure RunWorkflowOnSendStaffPerformanceForApproval(var pAppraisal: Record "HR Appraisal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode, pAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelStaffPerformanceAppraisalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequest(var pAppraisal: Record "HR Appraisal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequestCode, pAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectStaffPerformanceAppraisalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequest(var pAppraisal: Record "HR Appraisal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectStaffPerformanceAppraisalApprovalRequestCode, pAppraisal);
    end;




    procedure RunWorkflowOnSendFileMovementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFileMovementForApproval'));
    end;

    procedure RunWorkflowOnCancelFileMovementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFileMovementApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectFileMovementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectFileMovementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFileMovementForApproval', '', false, false)]
    procedure RunWorkflowOnSendFileMovementForApproval(var FileMovement: Record "File Movement Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFileMovementForApprovalCode, FileMovement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFileMovementApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelFileMovementApprovalRequest(var FileMovement: Record "File Movement Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFileMovementApprovalRequestCode, FileMovement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectFileMovementApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectFileMovementApprovalRequest(var FileMovement: Record "File Movement Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectFileMovementApprovalRequestCode, FileMovement);
    end;



    procedure RunWorkflowOnSendMobileApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMobileApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelMobileApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMobileApplicationApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectMobileApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectMobileApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMobileApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendMobileApplicationForApproval(var MobileApplication: Record "MOBILE Applications")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendMobileApplicationForApprovalCode, MobileApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMobileApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelMobileApplicationApprovalRequest(var MobileApplication: Record "MOBILE Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMobileApplicationApprovalRequestCode, MobileApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectMobileApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectMobileApplicationApprovalRequest(var MobileApplication: Record "MOBILE Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectMobileApplicationApprovalRequestCode, MobileApplication);
    end;


    procedure RunWorkflowOnSendLoanApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanApplicationForApproval(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationForApprovalCode, LoanApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanApplicationApprovalRequest(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationApprovalRequestCode, LoanApplication);
    end;



    procedure RunWorkflowOnSendLoanApplicationsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanApplicationsForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanApplicationsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanApplicationsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanApplicationsForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanApplicationsForApproval(var LoanApplications: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationsForApprovalCode, LoanApplications);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanApplicationsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanApplicationsApprovalRequest(var LoanApplications: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationsApprovalRequestCode, LoanApplications);
    end;

    //

    procedure RunWorkflowOnSendLoanAppliedForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanAppliedForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanAppliedApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanAppliedApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectLoanAppliedApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLoanAppliedApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanAppliedForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanAppliedForApproval(var LoanApplied: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanAppliedForApprovalCode, LoanApplied);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanAppliedApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanAppliedApprovalRequest(var LoanApplied: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanAppliedApprovalRequestCode, LoanApplied);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectLoanAppliedApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectLoanAppliedApprovalRequest(var LoanApplied: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectLoanAppliedApprovalRequestCode, LoanApplied);
    end;
    //

    procedure RunWorkflowOnSendClosureNoticeApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClosureNoticeApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelClosureNoticeApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClosureNoticeApplicationApprovalRequest'));
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendClosureNoticeApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendClosureNoticeApplicationForApproval(var NoticeApplication: Record "Withdrawal Notice")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendClosureNoticeApplicationForApprovalCode, NoticeApplication);
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelClosureNoticeApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelClosureNoticeApplicationApprovalRequest(var NoticeApplication: Record "Withdrawal Notice")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelClosureNoticeApplicationApprovalRequestCode, NoticeApplication);
    end;



    procedure RunWorkflowOnSendGuarantorSubstitutionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorSubstitutionForApproval'));
    end;

    procedure RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorSubstitutionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendGuarantorSubstitutionForApproval', '', false, false)]
    procedure RunWorkflowOnSendGuarantorSubstitutionForApproval(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorSubstitutionForApprovalCode, GuarantorshipSubstitution);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelGuarantorSubstitutionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelGuarantorSubstitutionApprovalRequest(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode, GuarantorshipSubstitution);
    end;


    procedure RunWorkflowOnSendLoanDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanDisbursementForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanDisbursementApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectLoanDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLoanDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanDisbursementForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanDisbursementForApproval(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanDisbursementForApprovalCode, LoanDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequest(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode, LoanDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectLoanDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectLoanDisbursementApprovalRequest(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectLoanDisbursementApprovalRequestCode, LoanDisbursement);
    end;


    procedure RunWorkflowOnSendStandingOrderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStandingOrderForApproval'));
    end;

    procedure RunWorkflowOnCancelStandingOrderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStandingOrderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendStandingOrderForApproval', '', false, false)]
    procedure RunWorkflowOnSendStandingOrderForApproval(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStandingOrderForApprovalCode, StandingOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelStandingOrderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelStandingOrderApprovalRequest(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStandingOrderApprovalRequestCode, StandingOrder);
    end;



    procedure RunWorkflowOnSendSTOForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSTOForApproval'));
    end;

    procedure RunWorkflowOnCancelSTOApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSTOApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSTOForApproval', '', false, false)]
    procedure RunWorkflowOnSendSTOForApproval(var STO: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSTOForApprovalCode, STO);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSTOApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelSTOApprovalRequest(var STO: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSTOApprovalRequestCode, STO);
    end;

    procedure RunWorkflowOnSendMWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelMWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendMWithdrawalForApproval(var MWithdrawal: Record "Membership Exist")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMWithdrawalForApprovalCode, MWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMWithdrawalApprovalRequest(var MWithdrawal: Record "Membership Exist")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMWithdrawalApprovalRequestCode, MWithdrawal);
    end;


    procedure RunWorkflowOnSendATMCardForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendATMCardForApproval'));
    end;


    procedure RunWorkflowOnCancelATMCardApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelATMCardApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendATMCardForApproval', '', false, false)]

    procedure RunWorkflowOnSendATMCardForApproval(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendATMCardForApprovalCode, ATMCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelATMCardApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelATMCardApprovalRequest(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelATMCardApprovalRequestCode, ATMCard);
    end;


    procedure RunWorkflowOnSendGuarantorRecoveryForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorRecoveryForApproval'));
    end;


    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorRecoveryApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendGuarantorRecoveryForApproval', '', false, false)]

    procedure RunWorkflowOnSendGuarantorRecoveryForApproval(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorRecoveryForApprovalCode, GuarantorRecovery);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelGuarantorRecoveryApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequest(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode, GuarantorRecovery);
    end;


    procedure RunWorkflowOnSendChangeRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChangeRequestForApproval'));
    end;


    procedure RunWorkflowOnCancelChangeRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChangeRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChangeRequestForApproval', '', false, false)]

    procedure RunWorkflowOnSendChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChangeRequestForApprovalCode, ChangeRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChangeRequestApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChangeRequestApprovalRequestCode, ChangeRequest);
    end;


    procedure RunWorkflowOnSendTTransactionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTTransactionsForApproval'));
    end;


    procedure RunWorkflowOnCancelTTransactionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTTransactionsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendTTransactionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendTTransactionsForApproval(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTTransactionsForApprovalCode, TTransactions);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelTTransactionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelTTransactionsApprovalRequest(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTTransactionsApprovalRequestCode, TTransactions);
    end;


    procedure RunWorkflowOnSendFAccountApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFAccountApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFAccountApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFAccountApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendFAccountApplicationForApproval(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFAccountApplicationForApprovalCode, FAccount);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFAccountApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequest(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode, FAccount);
    end;


    procedure RunWorkflowOnSendSReqApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSReqApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelSReqApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSReqApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSReqApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendSReqApplicationForApproval(var SReq: Record "Store Requistion Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSReqApplicationForApprovalCode, SReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSReqApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSReqApplicationApprovalRequest(var SReq: Record "Store Requistion Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSReqApplicationApprovalRequestCode, SReq);
    end;


    procedure RunWorkflowOnSendSaccoTransferForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSaccoTransferForApproval'));
    end;


    procedure RunWorkflowOnCancelSaccoTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSaccoTransferApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSaccoTransferForApproval', '', false, false)]

    procedure RunWorkflowOnSendSaccoTransferForApproval(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSaccoTransferForApprovalCode, SaccoTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSaccoTransferApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSaccoTransferApprovalRequest(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSaccoTransferApprovalRequestCode, SaccoTransfer);
    end;


    procedure RunWorkflowOnSendChequeDiscountingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChequeDiscountingForApproval'));
    end;


    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChequeDiscountingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChequeDiscountingForApproval', '', false, false)]

    procedure RunWorkflowOnSendChequeDiscountingForApproval(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChequeDiscountingForApprovalCode, ChequeDiscounting);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChequeDiscountingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequest(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode, ChequeDiscounting);
    end;


    procedure RunWorkflowOnSendImprestRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendImprestRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestRequisitionForApproval(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestRequisitionForApprovalCode, ImprestRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelImprestRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequest(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode, ImprestRequisition);
    end;


    procedure RunWorkflowOnSendImprestSurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestSurrenderForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestSurrenderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendImprestSurrenderForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestSurrenderForApproval(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode, ImprestSurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelImprestSurrenderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode, ImprestSurrender);
    end;


    procedure RunWorkflowOnSendLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApplicationApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLeaveApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLeaveApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveApplicationForApprovalCode, LeaveApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLeaveApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode, LeaveApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectLeaveApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectLeaveApplicationApprovalRequestCode, LeaveApplication);
    end;


    procedure RunWorkflowOnSendPVForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPVForApproval'));
    end;


    procedure RunWorkflowOnCancelPVApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPVApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPVForApproval', '', false, false)]

    procedure RunWorkflowOnSendPVForApproval(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPVForApprovalCode, PaymentsHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPVApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPVApprovalRequest(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPVApprovalRequestCode, PaymentsHeader);
    end;


    procedure RunWorkflowOnSendBulkWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBulkWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBulkWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendBulkWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendBulkWithdrawalForApproval(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBulkWithdrawalForApprovalCode, BulkWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelBulkWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequest(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode, BulkWithdrawal);
    end;


    procedure RunWorkflowOnSendPackageLodgeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageLodgeForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageLodgeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageLodgeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPackageLodgeForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageLodgeForApproval(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageLodgeForApprovalCode, PackageLodge);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPackageLodgeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageLodgeApprovalRequest(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageLodgeApprovalRequestCode, PackageLodge);
    end;


    procedure RunWorkflowOnSendPackageRetrievalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageRetrievalForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageRetrievalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPackageRetrievalForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageRetrievalForApproval(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageRetrievalForApprovalCode, PackageRetrieval);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPackageRetrievalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequest(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode, PackageRetrieval);
    end;


    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPurchaseRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode, PRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode, PRequest);
    end;


    procedure RunWorkflowOnSendHouseChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendHouseChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseChangeForApproval(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseChangeForApprovalCode, HouseChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelHouseChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseChangeApprovalRequest(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseChangeApprovalRequestCode, HouseChange);
    end;


    procedure RunWorkflowOnSendCRMTrainingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCRMTrainingForApproval'));
    end;


    procedure RunWorkflowOnCancelCRMTrainingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCRMTrainingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendCRMTrainingForApproval', '', false, false)]


    procedure RunWorkflowOnSendCRMTrainingForApproval(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCRMTrainingForApprovalCode, CRMTraining);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelCRMTrainingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelCRMTrainingApprovalRequest(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCRMTrainingApprovalRequestCode, CRMTraining);
    end;


    procedure RunWorkflowOnSendPettyCashForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPettyCashForApproval'));
    end;


    procedure RunWorkflowOnCancelPettyCashApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPettyCashApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPettyCashForApproval', '', false, false)]

    procedure RunWorkflowOnSendPettyCashForApproval(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPettyCashForApprovalCode, PettyCash);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPettyCashApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPettyCashApprovalRequest(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPettyCashApprovalRequestCode, PettyCash);
    end;


    procedure RunWorkflowOnSendStaffClaimsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffClaimsForApproval'));
    end;


    procedure RunWorkflowOnCancelStaffClaimsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStaffClaimsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendStaffClaimsForApproval', '', false, false)]

    procedure RunWorkflowOnSendStaffClaimsForApproval(var StaffClaims: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimsForApprovalCode, StaffClaims);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPettyCashApprovalRequest', '', false, false)]

    // // procedure RunWorkflowOnCancelStaffClaimsApprovalRequest(var StaffClaims: Record "Staff Claims Header")
    // // begin
    // //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,StaffClaims);
    // // end;


    procedure RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMemberAgentNOKChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMemberAgentNOKChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendMemberAgentNOKChangeForApproval(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode, MemberAgentNOKChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMemberAgentNOKChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode, MemberAgentNOKChange);
    end;


    procedure RunWorkflowOnSendHouseRegistrationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseRegistrationForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseRegistrationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendHouseRegistrationForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseRegistrationForApproval(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseRegistrationForApprovalCode, HouseRegistration);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelHouseRegistrationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequest(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode, HouseRegistration);
    end;


    procedure RunWorkflowOnSendLoanPayOffForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanPayOffForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanPayOffApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanPayOffApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanPayOffForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanPayOffForApproval(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanPayOffForApprovalCode, LoanPayOff);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanPayOffApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanPayOffApprovalRequest(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanPayOffApprovalRequestCode, LoanPayOff);
    end;


    procedure RunWorkflowOnSendFixedDepositForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFixedDepositForApproval'));
    end;


    procedure RunWorkflowOnCancelFixedDepositApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFixedDepositApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFixedDepositForApproval', '', false, false)]

    procedure RunWorkflowOnSendFixedDepositForApproval(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFixedDepositForApprovalCode, FixedDeposit);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFixedDepositApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFixedDepositApprovalRequest(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFixedDepositApprovalRequestCode, FixedDeposit);
    end;


    procedure RunWorkflowOnSendEFTRTGSForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendEFTRTGSForApproval'));
    end;

    procedure RunWorkflowOnCancelEFTRTGSApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelEFTRTGSApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectEFTRTGSApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectEFTRTGSApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendEFTRTGSForApproval', '', false, false)]

    procedure RunWorkflowOnSendEFTRTGSForApproval(var EFTRTGS: Record "EFT/RTGS Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEFTRTGSForApprovalCode, EFTRTGS);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelEFTRTGSApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelEFTRTGSApprovalRequest(var EFTRTGS: Record "EFT/RTGS Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEFTRTGSApprovalRequestCode, EFTRTGS);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectEFTRTGSApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectEFTRTGSApprovalRequest(var EFTRTGS: Record "EFT/RTGS Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectEFTRTGSApprovalRequestCode, EFTRTGS);
    end;


    procedure RunWorkflowOnSendDemandNoticeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendDemandNoticeForApproval'));
    end;


    procedure RunWorkflowOnCanceDemandNoticeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelDemandNoticeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendDemandNoticeForApproval', '', false, false)]

    procedure RunWorkflowOnSendDemandNoticeForApproval(var LDemand: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendDemandNoticeForApprovalCode, LDemand);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelDemandNoticeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelDemandNoticeApprovalRequest(var LDemand: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceDemandNoticeApprovalRequestCode, LDemand);
    end;


    procedure RunWorkflowOnSendOverDraftForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendOverDraftForApproval'));
    end;

    procedure RunWorkflowOnCancelOverDraftApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelOverDraftApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendOverDraftForApproval', '', false, false)]

    procedure RunWorkflowOnSendOverDraftForApproval(var OverDraft: Record "OverDraft Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendOverDraftForApprovalCode, OverDraft);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelOverDraftApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelOverDraftApprovalRequest(var OverDraft: Record "OverDraft Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelOverDraftApprovalRequestCode, OverDraft);
    end;



    procedure RunWorkflowOnSendBOSAReceiptForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBOSAReceiptForApproval'));
    end;

    procedure RunWorkflowOnCancelBOSAReceiptApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBOSAReceiptApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectBOSAReceiptApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectBOSAReceiptApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendBOSAReceiptForApproval', '', false, false)]
    procedure RunWorkflowOnSendBOSAReceiptForApproval(var BOSAReceipt: Record "Receipts & Payments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBOSAReceiptForApprovalCode, BOSAReceipt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelBOSAReceiptApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelBOSAReceiptApprovalRequest(var BOSAReceipt: Record "Receipts & Payments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBOSAReceiptApprovalRequestCode, BOSAReceipt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnRejectBOSAReceiptApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectBOSAReceiptApprovalRequest(var BOSAReceipt: Record "Receipts & Payments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectBOSAReceiptApprovalRequestCode, BOSAReceipt);
    end;


    procedure RunWorkflowOnSendLoanRestructureForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanRestructureForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanRestructureApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanRestructureApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanRestructureForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanRestructureForApproval(var LoanRestructure: Record "Loan Rescheduling")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanRestructureForApprovalCode, LoanRestructure);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanRestructureApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanRestructureApprovalRequest(var LoanRestructure: Record "Loan Rescheduling")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanRestructureApprovalRequestCode, LoanRestructure);
    end;


    procedure RunWorkflowOnSendSweepingInstructionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSweepingInstructionsForApproval'));
    end;


    procedure RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSweepingInstructionsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSweepingInstructionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendSweepingInstructionsForApproval(var SweepingInstructions: Record "Member Sweeping Instructions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSweepingInstructionsForApprovalCode, SweepingInstructions);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSweepingInstructionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSweepingInstructionsApprovalRequest(var SweepingInstructions: Record "Member Sweeping Instructions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode, SweepingInstructions);
    end;


    procedure RunWorkflowOnSendChequeBookForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnChequeBookForApproval'));
    end;


    procedure RunWorkflowOnCancelChequeBookApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChequeBookApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChequeBookForApproval', '', false, false)]

    procedure RunWorkflowOnSendChequeBookForApproval(var ChequeBook: Record "Cheque Book Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChequeBookForApprovalCode, ChequeBook);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChequeBookApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChequeBookApprovalRequest(var ChequeBook: Record "Cheque Book Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChequeBookApprovalRequestCode, ChequeBook);
    end;


    procedure RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnLoanTrunchDisbursementForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanTrunchDisbursementForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanTrunchDisbursementForApproval(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode, LoanTrunchDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanTrunchDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequest(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode, LoanTrunchDisbursement);
    end;


    procedure RunWorkflowOnSendInwardChequeClearingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInwardChequeClearingForApproval'));
    end;


    procedure RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInwardChequeClearingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInwardChequeClearingForApproval', '', false, false)]

    procedure RunWorkflowOnSendInwardChequeClearingForApproval(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInwardChequeClearingForApprovalCode, InwardChequeClearing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInwardChequeClearingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelInwardChequeClearingApprovalRequest(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode, InwardChequeClearing);
    end;


    procedure RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInvalidPaybillTransactionsForApproval'));
    end;


    procedure RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInvalidPaybillTransactionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendInvalidPaybillTransactionsForApproval(var InvalidPaybillTransactions: Record "Paybill Processing Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode, InvalidPaybillTransactions);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInvalidPaybillTransactionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequest(var InvalidPaybillTransactions: Record "Paybill Processing Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode, InvalidPaybillTransactions);
    end;


    procedure RunWorkflowOnSendInternalPVForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInternalPVForApproval'));
    end;


    procedure RunWorkflowOnCancelInternalPVApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInternalPVApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInternalPVForApproval', '', false, false)]

    procedure RunWorkflowOnSendInternalPVForApproval(var InternalPV: Record "Internal PV Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInternalPVForApprovalCode, InternalPV);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInternalPVApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelInternalPVApprovalRequest(var InternalPV: Record "Internal PV Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInternalPVApprovalRequestCode, InternalPV);
    end;


    procedure RunWorkflowOnSendSalaryProcessingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSalaryProcessingForApproval'));
    end;


    procedure RunWorkflowOnCancelSalaryProcessingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSalaryProcessingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSalaryProcessingForApproval', '', false, false)]

    procedure RunWorkflowOnSendSalaryProcessingForApproval(var SProcessing: Record "Salary Processing Headerr")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryProcessingForApprovalCode, SProcessing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSalaryProcessingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSalaryProcessingApprovalRequest(var SProcessing: Record "Salary Processing Headerr")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryProcessingApprovalRequestCode, SProcessing);
    end;

    procedure RunWorkflowOnSendMemberExitBatchForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnMemberExitBatchForApproval'));
    end;

    procedure RunWorkflowOnCancelMemberExitBatchApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberExitBatchApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMemberExitBatchForApproval', '', false, false)]

    procedure RunWorkflowOnSendMemberExitBatchForApproval(var MemberExitBatch: Record "Member Exit Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberExitBatchForApprovalCode, MemberExitBatch);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMemberExitBatchApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMemberExitBatchApprovalRequest(var MemberExitBatch: Record "Member Exit Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberExitBatchApprovalRequestCode, MemberExitBatch);
    end;


    procedure RunWorkflowOnSendESSRefundBatchForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnESSRefundBatchForApproval'));
    end;

    procedure RunWorkflowOnCancelESSRefundBatchApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelESSRefundBatchApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendESSRefundBatchForApproval', '', false, false)]

    procedure RunWorkflowOnSendESSRefundBatchForApproval(var ESSRefundBatch: Record "ESS Refund Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendESSRefundBatchForApprovalCode, ESSRefundBatch);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelESSRefundBatchApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelESSRefundBatchApprovalRequest(var ESSRefundBatch: Record "ESS Refund Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelESSRefundBatchApprovalRequestCode, ESSRefundBatch);
    end;


    procedure RunWorkflowOnSendBODHonorariumForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnBODHonorariumForApproval'));
    end;

    procedure RunWorkflowOnCancelBODHonorariumApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBODHonorariumApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendBODHonorariumForApproval', '', false, false)]

    procedure RunWorkflowOnSendBODHonorariumForApproval(var honorarium: Record "BOD Honoraria")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBODHonorariumForApprovalCode, honorarium);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelBODHonorariumApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelBODHonorariumApprovalRequest(var honorarium: Record "BOD Honoraria")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBODHonorariumApprovalRequestCode, honorarium);
    end;



    // procedure RunWorkflowOnSendPaymentReceiptForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    // end;


    // procedure RunWorkflowOnCancelPaymentReceiptApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMembershipApplicationForApproval', '', false, false)]

    // procedure RunWorkflowOnPaymentReceiptForApproval(var MembershipApplication: Record "Membership Applications")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]
    procedure addresponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    begin
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                         SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMembershipApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPaymentReceiptApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;



    procedure SetStatusLoanAppStatusToPendingApprovalCode(): Code[128]
    begin
        exit(UpperCase('SetLoanAppStatusTopendingApproval'))
    end;

    procedure SetLoanAppStatusTopendingApproval(var variant: Variant)
    var
        RecRef: RecordRef;
        LoanApp: Record "Loans Register";
    begin
        RecRef.GetTable(variant);
        case
            RecRef.Number of
            DATABASE::"Loans Register":
                begin

                    RecRef.SetTable(LoanApp);
                    LoanApp.Validate("Approval Status", LoanApp."Approval Status"::Pending);
                    //  MembershipApp.Modify();
                    variant := LoanApp;

                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddResponsesToLib()
    var
        Workfloweventhandling: Codeunit "Workflow Response Handling";
    begin
        Workfloweventhandling.AddResponseToLibrary(SetStatusLoanAppStatusToPendingApprovalCode(), 0, 'Set status to pending', 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExecuteResponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponses: Record "Workflow Response";
    begin
        if WorkflowResponses.Get(ResponseWorkflowStepInstance."Function Name") then
            case
                WorkflowResponses."Function Name" of
                SetStatusLoanAppStatusToPendingApprovalCode():
                    begin
                        SetLoanAppStatusTopendingApproval(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PaymentHeader: Record "Payments Header";
        MembershipApplication: Record "Membership Applications";
        MobileApplication: Record "MOBILE Applications";
        // LoanApplication: Record "Loans Register";
        // Loans: Record "Loans Register";
        LoanApplied: Record "Loans Register";
        LoanDisbursement: Record "Loan Disburesment-Batching";
        MemberExitBatch: Record "Member Exit Batch";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        ATMCard: Record "ATM Card Applications";
        GuarantorR: Record "Loan Recovery Header";
        ChangeRequest: Record "Change Request";
        TTransactions: Record "Treasury Transactions";
        FAccount: Record "FOSA Account Applicat. Details";
        SReq: Record "Store Requistion Header";
        SaccoTransfers: Record "Sacco Transfers";
        ChequeDiscounting: Record "Cheque Discounting";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        LeaveApplication: Record "HR Leave Application";
        BulkWithdrawal: Record "Bulk Withdrawal Application";
        PackageLodge: Record "Safe Custody Package Register";
        PackageRetrieval: Record "Package Retrieval Register";
        HouseChange: Record "House Group Change Request";
        MobileApp: Record "MOBILE Applications";
        CRMTraining: Record "CRM Trainings";
        PettyCash: Record "Payment Header.";
        StaffClaims: Record "Staff Claims Header";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LoanPayOff: Record "Loan PayOff";
        FixedDeposit: Record "Fixed Deposit Placement";
        EFTRTGS: Record "EFT/RTGS Header";
        LDemand: Record "Default Notices Register";
        OverDraft: Record "OverDraft Application";
        LoanRestructure: Record "Loan Restructure";
        SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        supApproval: Record "Leave Supervisor Approval";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        FRFeePay: Record "Funeral Rider Processing";
        Honorarium: Record "BOD Honoraria";
        ESSRefundBatch: Record "ESS Refund Batch";
        savingsVar: Record "Savings Variation";
        creditRating: Record "Credit Rating";
        membAllowance: Record "Sacco Meetings";
        fileMove: Record "File Movement Header";
        bosaReceipt: Record "Receipts & Payments";
        pAppraisal: Record "HR Appraisal Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    IsHandled := true;

                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(pAppraisal);
                    pAppraisal.Validate(Status, pAppraisal.Status::"Pending Approval");
                    pAppraisal.Modify(true);
                    IsHandled := true;
                end;
            Database::"Sacco Meetings":
                begin
                    RecRef.SetTable(membAllowance);
                    membAllowance.Validate("Approval Status", membAllowance."Approval Status"::"Pending Approval");
                    membAllowance.Modify(true);
                    IsHandled := true;
                end;
            Database::"Receipts & Payments":
                begin
                    RecRef.SetTable(bosaReceipt);
                    bosaReceipt.Validate("Approval Status", bosaReceipt."Approval Status"::"Pending Approval");
                    bosaReceipt.Modify(true);
                    IsHandled := true;
                end;
            Database::"Savings Variation":
                begin
                    RecRef.SetTable(savingsVar);
                    savingsVar.Validate("Approval Status", savingsVar."Approval Status"::"Pending Approval");
                    savingsVar.Modify(true);
                    IsHandled := true;
                end;
            Database::"Credit Rating":
                begin
                    RecRef.SetTable(creditRating);
                    creditRating."Requested By" := UserId;
                    creditRating.Modify(true);
                    IsHandled := true;
                end;

            //Funeral Rider
            Database::"Funeral Rider Processing":
                begin
                    RecRef.SetTable(FRFeePay);
                    FRFeePay.Validate("Approval Status", FRFeePay."Approval Status"::"Pending Approval");
                    FRFeePay.Validate("Processing Status", FRFeePay."Processing Status"::"Pending Approval");
                    FRFeePay.Modify(true);
                    IsHandled := true;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate("Membership Approval Status", MembershipApplication."Membership Approval Status"::"Pending Approval");
                    MembershipApplication.Modify(true);

                    IsHandled := true;
                end;

            //Supervisor Approval
            Database::"Leave Supervisor Approval":
                begin
                    RecRef.SetTable(supApproval);
                    supApproval.Validate("Approval Status", supApproval."Approval Status"::"Pending");
                    supApproval.Modify(true);
                    IsHandled := true;
                end;

            //File Movement
            Database::"File Movement Header":
                begin
                    RecRef.SetTable(fileMove);
                    fileMove.Validate(Status, fileMove.Status::"Pending Approval");
                    fileMove.Modify(true);
                    IsHandled := true;
                end;

            //Mobile Application
            Database::"MOBILE Applications":
                begin
                    RecRef.SetTable(MobileApplication);
                    MobileApplication.Validate(Status, MobileApplication.Status::"Pending Approval");
                    MobileApplication.Modify(true);

                    IsHandled := true;
                end;


            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplied);
                    LoanApplied.Validate("Loan Status", LoanApplied."loan status"::Approval);
                    LoanApplied.Validate("Approval Status", LoanApplied."approval status"::Pending);
                    LoanApplied."Appraissed By" := UserId;
                    LoanApplied."Appraissed By Date" := Today;
                    LoanApplied."Appraissed By Time" := Time;
                    IsHandled := true;
                    LoanApplied.Modify(true);
                end;

            //Guarantor substitutionn
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorshipSubstitution);
                    GuarantorshipSubstitution.Validate(Status, GuarantorshipSubstitution.Status::Pending);
                    GuarantorshipSubstitution.Modify;
                    IsHandled := true;
                    //Variant := GuarantorshipSubstitution;
                end;
            //Standing Order
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Validate(Status, StandingOrder.Status::Pending);
                    StandingOrder.Modify(true);
                    IsHandled := true;
                    // Variant := StandingOrder;
                end;

            //Loan Disbursement
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    LoanDisbursement.Validate(Status, LoanDisbursement.Status::"Pending Approval");
                    LoanDisbursement.Modify(true);
                    IsHandled := true;
                end;

            //Membership Withdrawal
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    IsHandled := true;
                end;


            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    IsHandled := true;
                end;

            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    IsHandled := true;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    IsHandled := true;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    IsHandled := true;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    IsHandled := true;
                end;

            //Stores Requisition
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(SReq);
                    SReq.Validate(Status, SReq.Status::"Pending Approval");
                    SReq.Modify(true);
                    IsHandled := true;
                end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    IsHandled := true;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    IsHandled := true;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    IsHandled := true;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    IsHandled := true;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    IsHandled := true;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    IsHandled := true;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    IsHandled := true;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    IsHandled := true;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    IsHandled := true;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    IsHandled := true;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    IsHandled := true;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    IsHandled := true;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    IsHandled := true;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    IsHandled := true;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    IsHandled := true;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    IsHandled := true;
                end;

            //EFTRTGS
            Database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    IsHandled := true;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    IsHandled := true;
                end;

            //Over Draft
            Database::"OverDraft Application":
                begin
                    RecRef.SetTable(OverDraft);
                    OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
                    OverDraft.Modify(true);
                    IsHandled := true;
                end;

            //Loan Restructure
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    IsHandled := true;
                end;

            //Sweeping Instructions
            Database::"Member Sweeping Instructions":
                begin
                    RecRef.SetTable(SweepingInstructions);
                    SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
                    SweepingInstructions.Modify(true);
                    IsHandled := true;
                end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    IsHandled := true;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::"Pending Approval");
                    LoanTrunch.Modify(true);
                    IsHandled := true;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    IsHandled := true;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    IsHandled := true;
                end;

            //Internal PV
            Database::"Internal PV Header":
                begin
                    RecRef.SetTable(InternalPV);
                    InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
                    InternalPV.Modify(true);
                    IsHandled := true;
                end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    IsHandled := true;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate(Status, SProcessing.Status::"Pending Approval");
                    SProcessing.Modify(true);
                    IsHandled := true;
                end;

            //Member Exit Batch
            Database::"Member Exit Batch":
                begin
                    RecRef.SetTable(MemberExitBatch);
                    MemberExitBatch.Validate(Status, MemberExitBatch.Status::"Pending Approval");
                    MemberExitBatch.Modify(true);
                    IsHandled := true;
                end;

            Database::"BOD Honoraria":
                begin
                    RecRef.SetTable(Honorarium);
                    Honorarium.Validate("Approval Status", Honorarium."Approval Status"::Pending);
                    Honorarium.Modify(true);
                    IsHandled := true;
                end;
            Database::"ESS Refund Batch":
                begin
                    RecRef.SetTable(ESSRefundBatch);
                    ESSRefundBatch.Validate("Approval Status", ESSRefundBatch."Approval Status"::Pending);
                    ESSRefundBatch.Modify(true);
                    IsHandled := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure fnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        number: Integer;
        converted: Boolean;
        HRLeaveApplication: Record "HR Leave Application";
        leaveSup: Record "Leave Supervisor Approval";
        loansReg: Record "Loans Register";
        loanBatches: Record "Loan Disburesment-Batching";
        EftRtgs: Record "EFT/RTGS Header";
        fileMove: Record "File Movement Header";
        bosaReceipt: Record "Receipts & Payments";
        mobileOnboarding: Record "MOBILE Applications";
        pAppraisal: Record "HR Appraisal Header";
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application Code", ApprovalEntry."Document No.");
        if HRLeaveApplication.Find('-') then begin
            HRLeaveApplication.Status := HRLeaveApplication.Status::Rejected;
            HRLeaveApplication.Modify;
        end;

        converted := Evaluate(number, ApprovalEntry."Document No.");
        leaveSup.Reset();
        leaveSup.SetRange("No.", number);
        if leaveSup.Find('-') then begin
            leaveSup."Approval Status" := leaveSup."Approval Status"::Rejected;
            leaveSup.Validate("Approval Status");
            leaveSup.Modify;
        end;

        bosaReceipt.Reset();
        bosaReceipt.SetRange("Transaction No.", ApprovalEntry."Document No.");
        if bosaReceipt.Find('-') then begin
            bosaReceipt."Approval Status" := bosaReceipt."Approval Status"::Rejected;
            bosaReceipt.Modify;
        end;

        loansReg.Reset();
        loansReg.SetRange("Loan  No.", ApprovalEntry."Document No.");
        if loansReg.Find('-') then begin
            loansReg."Approval Status" := loansReg."Approval Status"::Rejected;
            loansReg."Loan Status" := loansReg."Loan Status"::Rejected;
            loansReg."Archive Loan" := true;
            loansReg."Rejected By" := UserId;
            loansReg."Date of Rejection" := Today;
            loansReg.Modify;
        end;

        loanBatches.Reset();
        loanBatches.SetRange("Batch No.", ApprovalEntry."Document No.");
        if loanBatches.Find('-') then begin
            loanBatches.Status := loanBatches.Status::Rejected;
            loanBatches.Modify;
        end;

        EftRtgs.Reset();
        EftRtgs.SetRange(No, ApprovalEntry."Document No.");
        if EftRtgs.Find('-') then begin
            EftRtgs.Status := EftRtgs.Status::Rejected;
            EftRtgs.Modify;
        end;

        fileMove.Reset();
        fileMove.SetRange("No.", ApprovalEntry."Document No.");
        if fileMove.Find('-') then begin
            fileMove.Status := fileMove.Status::"Transfer Rejected";
            fileMove.Modify;
        end;

        mobileOnboarding.Reset();
        mobileOnboarding.SetRange("No.", ApprovalEntry."Document No.");
        if mobileOnboarding.Find('-') then begin
            mobileOnboarding.Status := mobileOnboarding.Status::Rejected;
            mobileOnboarding.Modify;
        end;

        pAppraisal.Reset();
        pAppraisal.SetRange("No.", ApprovalEntry."Document No.");
        if pAppraisal.Find('-') then begin
            pAppraisal.Status := pAppraisal.Status::Open;
            pAppraisal.Modify;
        end;
    end;
}



