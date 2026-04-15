//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50129 "Change Request List"
{
    ApplicationArea = All;
    CardPageID = "Change Request Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Change Request";
    SourceTableView = where(Changed = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; rec.No)
                {
                }
                field(Type; rec.Type)
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Mobile No";Rec."Mobile No")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field(Address; rec.Address)
                {
                }
                field(Branch; rec.Branch)
                {
                }
                field(Picture; rec.Picture)
                {
                }
                field(signinature; rec.signinature)
                {
                }
                field(City; rec.City)
                {
                }
                field("E-mail";Rec."E-mail")
                {
                }
                field("Personal No";Rec."Personal No")
                {
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Marital Status";Rec."Marital Status")
                {
                }
                field("Passport No.";Rec."Passport No.")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Category";Rec."Account Category")
                {
                }
                field(Email; rec.Email)
                {
                }
                field(Section; rec.Section)
                {
                }
                field("Card No";Rec."Card No")
                {
                }
                field("Home Address";Rec."Home Address")
                {
                }
                field(Loaction; rec.Loaction)
                {
                }
                field("Sub-Location";Rec."Sub-Location")
                {
                }
                field(District; rec.District)
                {
                }
                field("Reason for change";Rec."Reason for change")
                {
                }
                field("Signing Instructions";Rec."Signing Instructions")
                {
                }
                field("S-Mobile No";Rec."S-Mobile No")
                {
                }
                field("ATM Approve";Rec."ATM Approve")
                {
                }
                field("Card Expiry Date";Rec."Card Expiry Date")
                {
                }
                field("Card Valid From";Rec."Card Valid From")
                {
                }
                field("Card Valid To";Rec."Card Valid To")
                {
                }
                field("Date ATM Linked";Rec."Date ATM Linked")
                {
                }
                field("ATM No.";Rec."ATM No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*usersetup.GET(USERID);
        IF usersetup."change request"=FALSE THEN
          ERROR('Access Denied')
        ELSE
          EXIT;
          */

    end;

    var
        usersetup: Record "User Setup";
}






