#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50099 "Guarantor Sub Subform"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Guarantorship Substitution L";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    visible=false;
                }
                field("Member No"; Rec."Member No")
                {
                    visible=false;
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                }
                field("Current Commitment"; Rec."Current Commitment")
                {
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    visible=false;
                }
                field("Substitute Member"; Rec."Substitute Member")
                {
                }
                field("Substitute Member Name"; Rec."Substitute Member Name")
                {
                    Editable = false;
                }
                field("Sub Amount Guaranteed"; Rec."Sub Amount Guaranteed")
                {
                }
                field("Substitute Deposits"; Rec."Substitute Deposits")
                {
                }
                

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }
                field("Document No"; Rec."Document No")
                {
                   visible=false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    trigger OnAfterGetRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    var
        SubPageEditable: Boolean;
        GSubHeader: Record "Cheque Processing Charges";
}



