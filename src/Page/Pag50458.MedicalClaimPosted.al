//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50458 "Medical Claim Posted"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Claim Type";Rec."Claim Type")
                {
                }
                field("Claim Date";Rec."Claim Date")
                {
                }
                field("Patient Name";Rec."Patient Name")
                {
                }
                field("Document Ref";Rec."Document Ref")
                {
                }
                field("Date of Service";Rec."Date of Service")
                {
                }
                field("Attended By";Rec."Attended By")
                {
                }
                field("Amount Charged";Rec."Amount Charged")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Claim No";Rec."Claim No")
                {
                }
                field(Dependants; Rec.Dependants)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Amount Claimed";Rec."Amount Claimed")
                {
                }
                field("Hospital/Medical Centre";Rec."Hospital/Medical Centre")
                {
                }
                field("Claim Limit";Rec."Claim Limit")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
            }
            group(Other)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(PrintNew)
                {
                    Caption = 'Reprint Claim Voucher';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                           ERROR('You cannot Print until the document is Approved'); */

                        PHeader2.Reset;
                        PHeader2.SetRange(PHeader2."Member No", Rec."Member No");
                        if PHeader2.FindFirst then
                            Report.run(172199, true, true, PHeader2);

                        /*RESET;
                        SETRANGE("No.","No.");
                        IF "No." = '' THEN
                          REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                        ELSE
                          REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                        RESET;
                        */

                    end;
                }
            }
        }
    }

    var
        PHeader2: Record "HR Medical Claims";
}




