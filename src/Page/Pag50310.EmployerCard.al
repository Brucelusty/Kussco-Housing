//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50310 "Employer Card"
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Employers Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employer Code";Rec."Employer Code")
                {
                    Editable = addEmployers;
                    // Editable = false;
                }
                field("Employer Name";Rec."Employer Name")
                {
                    Editable = addEmployers;
                }
                field(Employees;Rec.Employees)
                {
                    Style = StrongAccent;
                }
                field("Customer Account";Rec."Customer Account")
                {
                    Style = StrongAccent;
                    Importance = Additional;
                }
                field("Employer Address";Rec."Employer Address")
                {
                    Editable = addEmployers;
                }
                field("Employer Physical Location";Rec."Employer Physical Location")
                {
                    Editable = addEmployers;
                }
                field("Employer Email";Rec."Employer Email")
                {
                    Editable = addEmployers;
                }
                field("Employer Phone No";Rec."Employer Phone No")
                {
                    Editable = addEmployers;
                }
                field("Contact Person";Rec."Contact Person")
                {
                    Editable = addEmployers;
                }
                field("Contact Person Mobile No";Rec."Contact Person Mobile No")
                {
                    Editable = addEmployers;
                }
                field("Created On";Rec."Created On")
                {
                    Editable = false;
                }
                field("Created By";Rec."Created By")
                {
                    Editable = false;
                }
                field("Modified By";Rec."Modified By")
                {
                    Editable = false;
                }
                field("Self-Employed";Rec."Self-Employed")
                {
                    Editable = addEmployers;
                }
            }
        }
        area(FactBoxes)
        {
            part("Doc Attachments"; "Document Attachment Factbox")
            {
                Caption = 'Employer Attachments';
                SubPageLink = "Table ID" = const(Database::"Employers Register"), "No." = field("Employer Code");
            }
        }
    }

    actions
    {
    }
    var
    addEmployers: Boolean;
    user: Record "User Setup";

    trigger
    OnOpenPage()
    begin
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Add Employers" = true
            then begin
                addEmployers := true;
            end;
        end;
    end;
}






