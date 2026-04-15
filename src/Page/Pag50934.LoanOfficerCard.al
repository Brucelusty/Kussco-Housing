//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50934 "Loan Officer Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Officers Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Group Target";Rec."Group Target")
                {
                }
                field("Savings Target";Rec."Savings Target")
                {
                }
                field("Member Target";Rec."Member Target")
                {
                }
                field("Disbursement Target";Rec."Disbursement Target")
                {
                }
                field("Payment Target";Rec."Payment Target")
                {
                }
                field("No. of Loans";Rec."No. of Loans")
                {
                }
                field("Exit Target";Rec."Exit Target")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {
                }
                field(Created; Rec.Created)
                {
                }
                field("Staff Status";Rec."Staff Status")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            separator(Action1000000022)
            {
            }
            action(Approval)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ///rereer
                end;
            }
            separator(Action1000000020)
            {
            }
        }
    }


    procedure UpdateControls()
    begin
        /* IF Status=Status::Approved THEN BEGIN
         ReasonEditable:=FALSE;
         "Transfer TypeEditable":=FALSE;
         TranscodeEditable:=FALSE;
         DocumentNoEditable:=FALSE;
         FTransferLineEditable:=FALSE;
         END;

         IF Status=Status::Pending THEN BEGIN
          ReasonEditable :=TRUE;
         "Transfer TypeEditable":=TRUE;
         TranscodeEditable:=TRUE;
         DocumentNoEditable:=TRUE;
         FTransferLineEditable:=TRUE;
         END;

         IF Status=Status::Cancelled THEN BEGIN
         ReasonEditable:=FALSE;
         "Transfer TypeEditable":=FALSE;
         TranscodeEditable:=FALSE;
         DocumentNoEditable:=FALSE;
         FTransferLineEditable:=FALSE;
         END;
         */

    end;
}






