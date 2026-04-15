codeunit 50092 "Pagemanagent"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
    recRef: RecordRef;
    fileMovement: Record "File Movement Header";
    begin
        CASE RecordRef.NUMBER OF
            DATABASE::"Loans Register":
                PageID := (Page::"Loan Application Card(Pending)");
                // PageID := (Page::"Loan Appraisal Card");
            Database::"HR Leave Application":
                PageID := (Page::"HR Leave Application Card");
            Database::"Membership Applications":
                PageID := (Page::"Membership Application Card");
            Database::"Change Request":
                PageID := (Page::"Change Request Card");
            Database::"ATM Card Applications":
                PageID := (Page::"ATM Applications Card");//
            Database::"Loan Recovery Header":
                PageID := (Page::"Loan Recovery Header");//
            Database::"Sacco Transfers":
                PageID := (Page::"Sacco Transfer Card View");
            Database::"Payments Header":
                PageID := (Page::"Payment Voucher Card View");
            Database::"FOSA Account Applicat. Details":
                PageID := (Page::"FOSA Product Application View");
            Database::"Leave Supervisor Approval":
                PageID := (Page::"Supervisor Approval Card");
            Database::"Membership Exist":
                PageID := (Page::"Membership Exit Card");
            Database::"Member Exit Batch":
                PageID := (Page::"Member Exit Batch Card");
            Database::"Standing Orders":
                PageID := (Page::"Standing Orders - List Approve");
            Database::"Credit Rating":
                PageID := (Page::"Credit Ratings Card");
            Database::"Sacco Meetings":
                PageID := (Page::"Uploaded Sacco Meetings Card");
            Database::"EFT/RTGS Header":
                PageID := (Page::"EFT/RTGS Card");
            Database::"ESS Refund Batch":
                PageID := (Page::"ESS Refund Batch Card");
            Database::"ESS Refund":
                PageID := (Page::"ESS Refund Card");
            Database::"File Movement Header":
                begin
                    RecordRef.SetTable(fileMovement);
                    if fileMovement."File Return" = true then begin
                        PageID := (Page::"File Return Header");
                    end else begin
                        PageID := (Page::"File Movement Header");
                    end;
                end;
            Database::"Payment Header.":
                PageID := (Page::"Cash Payment Header");
            Database::"MOBILE Applications":
                PageID := (Page::"MOBILE Application Card");
            Database::"Funeral Rider Processing":
                PageID := (Page::"Approved Funeral Rider Card");
            Database::"HR Appraisal Header":
                PageID := (Page::"Appraisal Card");
        end;
    end;

    procedure GetPurchaseHeaderPageID(RecRef: RecordRef): Integer
    var
        PurchaseHeader: Record "Loans Register";
        LeaveApplication: Record "HR Leave Application";
    begin
        RecRef.SetTable(PurchaseHeader);
        EXIT(PAGE::"Loan Application BOSA(New)");




    end;



}
