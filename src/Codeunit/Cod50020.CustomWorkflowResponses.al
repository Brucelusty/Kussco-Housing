//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50020 "Custom Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";


    procedure AddResponsesToLib()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    procedure AddResponsePredecessors()
    begin

        //Payment Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);

        //Membership Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);

        //Supervisor Approval
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveSuperForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveSuperForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveSuperForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveSuperApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveSuperApprovalRequestCode);
        
        //Staff Performance Self-Appraisal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffPerformanceAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffPerformanceAppraisalApprovalRequestCode);

        //Mobile Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMobileApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMobileApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMobileApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMobileApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMobileApplicationApprovalRequestCode);

        // //Erroneous Loan Application
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);

        // //Loan Application
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanApplicationsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanApplicationsApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanApplicationsApprovalRequestCode);

        //Loan Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanAppliedForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanAppliedForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanAppliedForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanAppliedApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanAppliedApprovalRequestCode);

        //Guarantor Substitution
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);

        //Loan Disbursement
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);



        //Standing Order
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);

        //Membership Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);

        //ATM Card Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Guarantor Recovery
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);

        //Change Request
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);

        //Treasury Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);


        //FOSA Account Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);



        //Stores Requisition

        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);

        //Sacco Transfer
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        //Cheque Discounting
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);

        //Imprest Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);

        //Imprest Surrender
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);

        //Leave Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        //Bulk Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);

        //Package Lodge
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);

        //Package Retrieval
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);

        //House Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);

        //CRM Training
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);

        //Petty Cash
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);

        //Staff Claims
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);

        //Member Agent/NOK Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);

        //House Registration
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);

        //Loan Payoff
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);

        //Fixed Deposit
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);

        //EFT/RTGS
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);

        //LOAN DEMAND NOTICE
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);

        //OVER DRAFT
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);

        //Loan Restructure
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);

        //Sweeping Instructions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);

        //Cheque Book Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);

        //Loan Trunch
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);

        //Inward Cheque Clearing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);

        //Invalid Paybill Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);


        //Internal PV
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);

        //Salary Processing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);

        //MemberExit Batch
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Funeral Rider
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFRFeePayForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFRFeePayForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFRFeePayForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFRFeePayApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFRFeePayApprovalRequestCode);

        //Member Exit Batch
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberExitBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberExitBatchApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberExitBatchApprovalRequestCode);

        //BOD Honoraria
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBODHonorariumForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBODHonorariumForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBODHonorariumForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBODHonorariumApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBODHonorariumApprovalRequestCode);

        //ESS Refund
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendESSRefundBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendESSRefundBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendESSRefundBatchForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelESSRefundBatchApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelESSRefundBatchApprovalRequestCode);

        //Savings Variation
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSavingsVarDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSavingsVarDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSavingsVarDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSavingsVarApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSavingsVarApprovalRequestCode);

        //Loan Limit Variation
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanLimitDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanLimitDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanLimitDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanLimitApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanLimitApprovalRequestCode);

        //Member Allowance
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAllowanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAllowanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAllowanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAllowanceApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAllowanceApprovalRequestCode);

        //File Movement
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFileMovementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFileMovementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFileMovementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFileMovementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFileMovementApprovalRequestCode);

        //BOSA Receipt
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBOSAReceiptForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBOSAReceiptForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBOSAReceiptForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBOSAReceiptApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBOSAReceiptApprovalRequestCode);

        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        PaymentHeader: Record "Payments Header";
        MembershipApplication: Record "Membership Applications";
        MobileApplication: Record "MOBILE Applications";
        // LoanApplication: Record "Loans Register";
        // Loans: Record "Loans Register";
        LoanApplied: Record "Loans Register";
        LoanDisbursement: Record "Loan Disburesment-Batching";
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
        supApproval: Record "Leave Supervisor Approval";
        SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        // PaymentHeader: Record "Payments Header";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        FRFeePay: Record "Funeral Rider Processing";
        MemExitBatch: Record "Member Exit Batch";
        Honorarium: Record "BOD Honoraria";
        ESSRefundBatch: Record "ESS Refund Batch";
        savingsVar: Record "Savings Variation";
        creditRating: Record "Credit Rating";
        membAllowance: Record "Sacco Meetings";
        fileMove: Record "File Movement Header";
        bosaReceipt: Record "Receipts & Payments";
        pAppraisal: Record "HR Appraisal Header";
    begin
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    Variant := PaymentHeader;
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(pAppraisal);
                    pAppraisal.Validate(Status, pAppraisal.Status::"Pending Approval");
                    pAppraisal.Modify(true);
                    Variant := pAppraisal;
                end;
            Database::"Sacco Meetings":
                begin
                    RecRef.SetTable(membAllowance);
                    membAllowance.Validate("Approval Status", membAllowance."Approval Status"::"Pending Approval");
                    membAllowance.Modify(true);
                    Variant := membAllowance;
                end;
            Database::"Credit Rating":
                begin
                    RecRef.SetTable(creditRating);
                    creditRating.Validate("Requested By", UserId);
                    creditRating.Modify(true);
                    Variant := creditRating;
                end;

            Database::"Funeral Rider Processing":
                begin
                    RecRef.SetTable(FRFeePay);
                    FRFeePay.Validate("Approval Status", FRFeePay."Approval Status"::"Pending Approval");
                    FRFeePay.Validate("Processing Status", FRFeePay."Processing Status"::"Pending Approval");
                    FRFeePay.Modify(true);
                    Variant := FRFeePay;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    //  Message('we here');
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate("Membership Approval Status", MembershipApplication."Membership Approval Status"::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;

            Database::"Leave Supervisor Approval":
                begin
                    RecRef.SetTable(supApproval);
                    supApproval.Validate("Approval Status", supApproval."Approval Status"::"Pending");
                    supApproval.Modify(true);
                    Variant := supApproval;
                end;

            //Mobile Application
            Database::"MOBILE Applications":
                begin
                    //  Message('we here');
                    RecRef.SetTable(MobileApplication);
                    // MobileApplication.Get();
                    MobileApplication.Validate(Status, MobileApplication.Status::"Pending Approval");
                    MobileApplication.Modify(true);
                    Variant := MobileApplication;
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
                    LoanApplied.Modify(true);
                    Variant := LoanApplied;
                end;
            //Guarantor substitutionn
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorshipSubstitution);
                    GuarantorshipSubstitution.Validate(Status, GuarantorshipSubstitution.Status::Pending);
                    GuarantorshipSubstitution.Modify;
                    Variant := GuarantorshipSubstitution;
                end;
            //Standing Order
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Validate(Status, StandingOrder.Status::Pending);
                    StandingOrder.Modify(true);
                    Variant := StandingOrder;
                end;

            //Loan Disbursement
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    LoanDisbursement.Validate(Status, LoanDisbursement.Status::"Pending Approval");
                    LoanDisbursement.Modify(true);
                    Variant := LoanDisbursement;
                end;

            //Membership Withdrawal
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    Variant := MWithdrawal;
                end;

            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    Variant := ATMCard;
                end;

            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    Variant := GuarantorR;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    Variant := TTransactions;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    Variant := FAccount;
                end;

            //Stores Requisition
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(SReq);
                    SReq.Validate(Status, SReq.Status::"Pending Approval");
                    SReq.Modify(true);
                    Variant := SReq;
                end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    Variant := SaccoTransfers;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    Variant := ChequeDiscounting;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    Variant := ImprestRequisition;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    Variant := ImprestSurrender;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    Variant := LeaveApplication;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    Variant := BulkWithdrawal;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    Variant := PackageLodge;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    Variant := PackageRetrieval;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    Variant := HouseChange;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    Variant := CRMTraining;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    Variant := PettyCash;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    Variant := StaffClaims;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    Variant := MemberAgentNOKChange;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    Variant := HouseRegistration;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    Variant := LoanPayOff;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    Variant := FixedDeposit;
                end;

            //EFTRTGS
            Database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    Variant := EFTRTGS;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    Variant := LDemand;
                end;

            //Over Draft
            Database::"OverDraft Application":
                begin
                    RecRef.SetTable(OverDraft);
                    OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
                    OverDraft.Modify(true);
                    Variant := OverDraft;
                end;

            //Loan Restructure
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    Variant := LoanRestructure;
                end;

            //Sweeping Instructions
            Database::"Member Sweeping Instructions":
                begin
                    RecRef.SetTable(SweepingInstructions);
                    SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
                    SweepingInstructions.Modify(true);
                    Variant := SweepingInstructions;
                end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    Variant := ChequeBook;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::"Pending Approval");
                    LoanTrunch.Modify(true);
                    Variant := LoanTrunch;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    Variant := InwardChequeClearing;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    Variant := InvalidPaybillTransactions;
                end;

            //Internal PV
            Database::"Internal PV Header":
                begin
                    RecRef.SetTable(InternalPV);
                    InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
                    InternalPV.Modify(true);
                    Variant := InternalPV;
                end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    Variant := JournalBatch;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate(Status, SProcessing.Status::"Pending Approval");
                    SProcessing.Modify(true);
                    Variant := SProcessing;
                end;

            //Member Exit Batch
            Database::"Member Exit Batch":
                begin
                    RecRef.SetTable(MemExitBatch);
                    MemExitBatch.Validate(Status, MemExitBatch.Status::"Pending Approval");
                    MemExitBatch.Modify(true);
                    Variant := MemExitBatch;
                end;

            //BOD Honoraria
            Database::"BOD Honoraria":
                begin
                    RecRef.SetTable(Honorarium);
                    Honorarium.Validate("Approval Status", Honorarium."Approval Status"::Pending);
                    Honorarium.Modify(true);
                    Variant := Honorarium;
                end;

            //ESS Refund
            Database::"ESS Refund Batch":
                begin
                    RecRef.SetTable(ESSRefundBatch);
                    ESSRefundBatch.Validate("Approval Status", ESSRefundBatch."Approval Status"::Pending);
                    ESSRefundBatch.Modify(true);
                    Variant := ESSRefundBatch;
                end;
            //BOSA Receipt
            Database::"Receipts & Payments":
                begin
                    RecRef.SetTable(bosaReceipt);
                    bosaReceipt.Validate("Approval Status", bosaReceipt."Approval Status"::"Pending Approval");
                    bosaReceipt.Modify(true);
                    Variant := bosaReceipt;
                end;
            Database::"Savings Variation":
                begin
                    RecRef.SetTable(savingsVar);
                    savingsVar.Validate("Approval Status", savingsVar."Approval Status"::"Pending Approval");
                    savingsVar.Modify(true);
                    Variant := savingsVar;
                end;
            Database::"File Movement Header":
                begin
                    RecRef.SetTable(fileMove);
                    fileMove.Validate(Status, fileMove.Status::"Pending Approval");
                    fileMove.Validate(Status);
                    fileMove.Modify(true);
                    Variant := fileMove;
                end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payments Header";
        SaccoTransfers: Record "Sacco Transfers";
        scrTrans: Record "Sacco Transfers";
        ObjMembership: Record "Membership Applications";
        // ObjLoans: Record "Loans Register";
        // Loans: Record "Loans Register";
        ObjLoanPayoff: Record "Loan PayOff";
        ObjLoanRestructure: Record "Loan Restructure";
        ObjSalaryProcessing: Record "Salary Processing Headerr";
        BulkWithdrawal: Record "Bulk Withdrawal Application";
        PackageLodge: Record "Safe Custody Package Register";
        PackageRetrieval: Record "Package Retrieval Register";
        HouseChange: Record "House Group Change Request";
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
        supApproval: Record "Leave Supervisor Approval";
        SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        InternalPV: Record "Internal PV Header";
        ObjStanding: Record "Standing Orders";
        ObjMembershipExit: Record "Membership Exist";
        ObjInternalTransfer: Record "Sacco Transfers";
        ObjChangeRequest: Record "Change Request";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        MembershipApp: Record "Membership Applications";
        MobileApp: Record "MOBILE Applications";
        // LoanApplication: Record "Loans Register";
        LoanApplied: Record "Loans Register";
        LoansReg: Record "Loans Register";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        PRequest: Record "Purchase Header";
        GuarantorRecovery: Record "Loan Recovery Header";
        RecoveryHeader: Record "Loan Recovery Header";
        LeaveApplication: Record "HR Leave Application";
        FRFeePay: Record "Funeral Rider Processing";
        MemExitBatch: Record "Member Exit Batch";
        Honorarium: Record "BOD Honoraria";
        ESSRefundBatch: Record "ESS Refund Batch";
        savingsVar: Record "Savings Variation";
        creditRating: Record "Credit Rating";
        membAllowance: Record "Sacco Meetings";
        fileMove: Record "File Movement Header";
        LoanDisbursement: Record "Loan Disburesment-Batching";
        bosaReceipt: Record "Receipts & Payments";
        pAppraisal: Record "HR Appraisal Header";
    begin
        case RecRef.Number of
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApp);
                    ObjMembership.Get(MembershipApp."No.");
                    ObjMembership."Membership Approval Status" := ObjMembership."Membership Approval Status"::Open;
                    ObjMembership.Modify(true);
                    Handled := true;
                end;
            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(pAppraisal);
                    pAppraisal.Status := pAppraisal.Status::Open;
                    pAppraisal.Validate(Status);
                    pAppraisal.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Funeral Rider Processing":
                begin
                    RecRef.SetTable(FRFeePay);
                    FRFeePay."Approval Status" := FRFeePay."Approval Status"::Open;
                    FRFeePay."Processing Status" := FRFeePay."Processing Status"::Captured;
                    FRFeePay.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Credit Rating":
                begin
                    RecRef.SetTable(creditRating);
                    creditRating."Requested By" := '';
                    creditRating.Modify(true);
                    Handled := true;
                end;

            DATABASE::"Leave Supervisor Approval":
                begin
                    RecRef.SetTable(supApproval);
                    supApproval."Approval Status" := supApproval."Approval Status"::New;
                    supApproval.Validate("Approval Status");
                    supApproval.Modify(true);
                    Handled := true;
                end;

            DATABASE::"MOBILE Applications":
                begin
                    RecRef.SetTable(MobileApp);
                    MobileApp.Status := MobileApp.Status::Application;
                    MobileApp.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorshipSubstitution);
                    GuarantorshipSubstitution.Status := GuarantorshipSubstitution.Status::Open;
                    GuarantorshipSubstitution.Modify(true);
                    Handled := true;
                end;

            Database::"Sacco Transfers":
                begin
                    // SaccoTransfers.Reset();
                    RecRef.SetTable(SaccoTransfers);
                    scrTrans.Get(SaccoTransfers.No);
                    scrTrans.Status := scrTrans.Status::Open;
                    scrTrans.Modify();
                    Handled := true;
                end;
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::"HR Approval";
                    LeaveApplication.Modify(true);
                    Handled := true;
                end;

            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Open;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Open;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;

            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplied);
                    LoansReg.Get(LoanApplied."Loan  No.");
                    LoansReg."Re-Appraised By" := UserId;
                    LoansReg."Re-Appraised On" := Today;
                    LoansReg."Re-Appraised On Time" := Time;
                    LoansReg."Loan Status" := LoansReg."Loan Status"::Appraisal;
                    LoansReg."Approval Status" := LoansReg."Approval Status"::Open;
                    LoansReg.Modify(true);
                    Handled := true;
                end;
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::New;
                    PettyCash.Modify(true);
                    Handled := true;
                end;
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Status := PaymentHeader.Status::Pending;
                    PaymentHeader.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Open;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Status := MWithdrawal.Status::Open;
                    MWithdrawal.Modify(true);
                    Handled := true;
                end;
            Database::"Change Request":
                begin
                    RecRef.SetTable(ObjChangeRequest);
                    ObjChangeRequest.Status := ObjChangeRequest.Status::Open;
                    ObjChangeRequest.Modify(true);
                    Handled := true;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Pending;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Open;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestSurrender.Status::Open;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Open;
                    PRequest.Modify(true);
                    Handled := true;
                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Open;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    // GuarantorRecovery.Status := GuarantorRecovery.Status::Open;
                    // GuarantorRecovery.Modify(true);
                    RecoveryHeader.Get(GuarantorRecovery."Document No");
                    If RecoveryHeader.FindFirst() then begin
                        RecoveryHeader.Status := RecoveryHeader.Status::Open;
                        RecoveryHeader.Modify(true);
                        Commit();
                    end;
                    Handled := true;
                end;
            Database::"Member Exit Batch":
                begin
                    RecRef.SetTable(MemExitBatch);
                    MemExitBatch.Status := MemExitBatch.Status::Open;
                    MemExitBatch.Modify(true);
                    Handled := true;
                end;
            Database::"Receipts & Payments":
                begin
                    RecRef.SetTable(bosaReceipt);
                    bosaReceipt."Approval Status" := bosaReceipt."Approval Status"::Open;
                    bosaReceipt.Modify(true);
                    Handled := true;
                end;
            Database::"BOD Honoraria":
                begin
                    RecRef.SetTable(Honorarium);
                    Honorarium."Approval Status" := Honorarium."Approval Status"::Open;
                    Honorarium.Modify(true);
                    Handled := true;
                end;
            Database::"ESS Refund Batch":
                begin
                    RecRef.SetTable(ESSRefundBatch);
                    ESSRefundBatch."Approval Status" := ESSRefundBatch."Approval Status"::Open;
                    ESSRefundBatch.Modify(true);
                    Handled := true;
                end;
            Database::"Savings Variation":
                begin
                    RecRef.SetTable(savingsVar);
                    savingsVar."Approval Status" := savingsVar."Approval Status"::New;
                    savingsVar.Modify(true);
                    Handled := true;
                end;
            Database::"Sacco Meetings":
                begin
                    RecRef.SetTable(membAllowance);
                    membAllowance."Approval Status" := membAllowance."Approval Status"::New;
                    membAllowance.Modify(true);
                    Handled := true;
                end;
            Database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Status := EFTRTGS.Status::Open;
                    EFTRTGS.Modify(true);
                    Handled := true;
                end;
            Database::"File Movement Header":
                begin
                    RecRef.SetTable(fileMove);
                    fileMove.Status := fileMove.Status::Open;
                    fileMove.Validate(Status);
                    fileMove.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    LoanDisbursement.Status := LoanDisbursement.Status::Open;
                    LoanDisbursement.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MemberShipApp: Record "Membership Applications";
        membApp: Record "Membership Applications";
        MobileApp: Record "MOBILE Applications";
        SaccoTransfers: Record "Sacco Transfers";
        scTransfer: Record "Sacco Transfers";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        // LaonApplication: Record "Loans Register";
        // Loans: Record "Loans Register";
        LoanApplied: Record "Loans Register";
        LoanAppliedII: Record "Loans Register";
        PettyCash: Record "Payment Header.";
        PettyCashII: Record "Payment Header.";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        MWithdrawalII: Record "Membership Exist";
        StaffClaims: Record "Staff Claims Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        supApproval: Record "Leave Supervisor Approval";
        PRequest: Record "Purchase Header";
        PaymentHeader: Record "Payments Header";
        LoanPayOff: Record "Loan PayOff";
        ATMCard: Record "ATM Card Applications";
        GuarantorRecovery: Record "Loan Recovery Header";
        LoanDisbursememnt: Record "Loan Disburesment-Batching";
        SalaryProcessingHeader: Record "Salary Processing Headerr";
        //FosaAccountOpenning: Record "FOSA Account Applicat. Details";
        FAccount: Record "FOSA Account Applicat. Details";
        EFTRTGS: record "EFT/RTGS Header";
        LeaveApp: Record "HR Leave Application";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ProductApp: Record "FOSA Account Applicat. Details";
        FRFeePay: Record "Funeral Rider Processing";
        MemExitBatch: Record "Member Exit Batch";
        Honorarium: Record "BOD Honoraria";
        ESSRefundBatch: Record "ESS Refund Batch";
        savingsVar: Record "Savings Variation";
        creditRating: Record "Credit Rating";
        membAllowance: Record "Sacco Meetings";
        fileMove: Record "File Movement Header";
        bosaReceipt: Record "Receipts & Payments";
        pAppraisal: Record "HR Appraisal Header";
    begin
        case RecRef.Number of
            database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApp);
                    LeaveApp.Status := LeaveApp.Status::Approved;
                    LeaveApp.Validate(Status);
                    LeaveApp.Modify(true);
                    Handled := true;
                end;
            database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(pAppraisal);
                    pAppraisal.Status := pAppraisal.Status::Approved;
                    pAppraisal.Validate(Status);
                    pAppraisal.Modify(true);
                    Handled := true;
                end;
            database::"Sacco Meetings":
                begin
                    RecRef.SetTable(membAllowance);
                    membAllowance."Approval Status" := membAllowance."Approval Status"::Approved;
                    membAllowance.Modify(true);
                    Handled := true;
                end;
            database::"Receipts & Payments":
                begin
                    RecRef.SetTable(bosaReceipt);
                    bosaReceipt."Approval Status" := bosaReceipt."Approval Status"::Approved;
                    bosaReceipt.Modify(true);
                    Handled := true;
                end;
            database::"Savings Variation":
                begin
                    RecRef.SetTable(savingsVar);
                    savingsVar."Approval Status" := savingsVar."Approval Status"::Approved;
                    savingsVar.Modify(true);
                    Handled := true;
                end;
            database::"Credit Rating":
                begin
                    RecRef.SetTable(creditRating);
                    creditRating."Approved By" := UserId;
                    creditRating.Validate("Approved By");
                    creditRating.Modify(true);
                    Handled := true;
                end;
            database::"Funeral Rider Processing":
                begin
                    RecRef.SetTable(FRFeePay);
                    FRFeePay."Approval Status" := FRFeePay."Approval Status"::Approved;
                    FRFeePay."Processing Status" := FRFeePay."Processing Status"::Approved;
                    FRFeePay."Approved By" := UserId;
                    FRFeePay."Approved On" := Today;
                    FRFeePay.Modify(true);
                    Handled := true;
                end;
            database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Status := EFTRTGS.Status::Approved;
                    EFTRTGS.Modify(true);
                    Handled := true;
                end;
            database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(ProductApp);
                    ProductApp.Status := ProductApp.Status::Approved;
                    ProductApp.Modify(true);
                    Handled := true;
                end;
            database::"Leave Supervisor Approval":
                begin
                    RecRef.SetTable(supApproval);
                    supApproval."Approval Status" := supApproval."Approval Status"::Approved;
                    supApproval.Validate("Approval Status");
                    supApproval.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    membApp.Get(MemberShipApp."No.");
                    membApp."Membership Approval Status" := membApp."Membership Approval Status"::Approved;
                    membApp.Modify(true);
                    Handled := true;
                end;

            DATABASE::"MOBILE Applications":
                begin
                    RecRef.SetTable(MobileApp);
                    if MobileApp.Get(MobileApp."No.") then
                        MobileApp.Status := MobileApp.Status::Approved;
                    MobileApp.Validate(Status);
                    MobileApp.Modify(true);
                    Handled := true;
                end;


            DATABASE::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Status := ATMCard.Status::Approved;
                    if ATMCard."Request Type" = ATMCard."Request Type"::"Card Reissue" then begin
                        ATMCard."ATM Card Fee Charged" := true;
                        ATMCard."ATM Card Fee Charged By" := UserId;
                        ATMCard."ATM Card Fee Charged On" := Today;
                        ATMCard."ATM Card Linked" := true;
                        ATMCard."ATM Card Linked On" := Today;
                        ATMCard."ATM Card Linked By" := UserId;
                    end;
                    ATMCard.Modify(true);
                    Handled := true;
                end;
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Status := FAccount.status::Approved;
                    FAccount.Modify();
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    SaccoTransfers.Reset();
                    RecRef.SetTable(SaccoTransfers);
                    scTransfer.Get(SaccoTransfers.No);
                    scTransfer.Status := scTransfer.Status::Approved;
                    Message('Sacco Transfer has been approved, Notify Daniel');
                    scTransfer.Modify();
                    Handled := true;
                end;
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SalaryProcessingHeader);
                    SalaryProcessingHeader.Status := SalaryProcessingHeader.Status::Approved;
                    SalaryProcessingHeader.Modify(true);
                    Handled := true;
                end;
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Approved;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursememnt);
                    LoanDisbursememnt.Status := LoanDisbursememnt.Status::Approved;
                    LoanDisbursememnt.Modify(true);
                    Handled := true;
                end;
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Approved;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplied);
                    LoanAppliedII.Get(LoanApplied."Loan  No.");
                    LoanAppliedII.Validate("Loan Status", LoanAppliedII."Loan Status"::"TCC Approved");
                    LoanAppliedII.Validate("Approval Status", LoanAppliedII."Approval Status"::Approved);
                    LoanAppliedII."Approved By" := UserId;
                    LoanAppliedII."Approved Date" := Today;
                    LoanAppliedII."Approved Time" := Time;
                    LoanAppliedII."Approved By Date" := Today;
                    LoanAppliedII.Modify(true);
                    Handled := true;
                end;

            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCashII.Get(PettyCash."No.");
                    PettyCashII.Status := PettyCashII.Status::Approved;
                    PettyCashII.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Approved;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawalII.Get(MWithdrawal."No.");
                    MWithdrawalII.Status := MWithdrawalII.Status::Approved;
                    MWithdrawalII.Modify(true);
                    Handled := true;
                end;

            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Approved;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;

            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Approved;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestRequisition.Status::Approved;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Released;
                    PRequest.Modify(true);
                    Handled := true;

                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Approved;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Status := PaymentHeader.Status::Approved;
                    PaymentHeader.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    GuarantorRecovery.Status := GuarantorRecovery.Status::Approved;
                    GuarantorRecovery.Modify(true);
                    Handled := true;
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Approved);
                    ChangeRequest.Validate("Approved by", UserId);
                    ChangeRequest.Validate("Approval Date", Today);
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Approved);
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;

            Database::"Member Exit Batch":
                begin
                    RecRef.SetTable(MemExitBatch);
                    MemExitBatch.Status := MemExitBatch.Status::Approved;
                    MemExitBatch."Authorised By" := UserId;
                    MemExitBatch.Modify(true);
                    Handled := true;
                end;

            Database::"File Movement Header":
                begin
                    RecRef.SetTable(fileMove);
                    fileMove.Status := fileMove.Status::Approved;
                    fileMove.Validate(Status);
                    fileMove.Modify(true);
                    Handled := true;
                end;

            Database::"BOD Honoraria":
                begin
                    RecRef.SetTable(Honorarium);
                    Honorarium.Validate("Approval Status", Honorarium."Approval Status"::Approved);
                    Honorarium.Modify(true);
                    Handled := true;
                end;
            Database::"ESS Refund Batch":
                begin
                    RecRef.SetTable(ESSRefundBatch);
                    ESSRefundBatch.Validate("Approval Status", ESSRefundBatch."Approval Status"::Approved);
                    ESSRefundBatch."Approved By" := UserId;
                    ESSRefundBatch."Approved On" := Today;
                    ESSRefundBatch.Modify(true);
                    Handled := true;
                end;
        end
    end;
}




