//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50750 "Customer Care List"
{
    ApplicationArea = All;
    CardPageID = "Customer Care Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Members Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Phone No.";Rec."Phone No.")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                }
                field("Payroll No";Rec."Payroll No")
                {
                    Caption = 'Payroll No.';
                }
                field("FOSA Account No.";Rec."FOSA Account No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
          IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Special Accounts"=FALSE THEN
           ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
        END;
        
          END;*/

    end;

    var
        UserSetup: Record "User Setup";
}






