//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50917 "OverDraft Details SubPage"
{
    ApplicationArea = All;
    CardPageID = "Posted OverDraft Applic Card";
    Editable = false;
    PageType = ListPart;
    SourceTable = "OverDraft Application";
    SourceTableView = where("OD Application Effected" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Over Draft Account";Rec."Over Draft Account")
                {
                }
                field("Over Draft Account Name";Rec."Over Draft Account Name")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("OverDraft Application Type";Rec."OverDraft Application Type")
                {
                }
                field("OverDraft Application Status";Rec."OverDraft Application Status")
                {
                    Caption = 'OverDraft  Status';
                }
                field("Security Type";Rec."Security Type")
                {
                }
                field("Qualifying Overdraft Amount";Rec."Qualifying Overdraft Amount")
                {
                }
                field("Overdraft Duration";Rec."Overdraft Duration")
                {
                }
                field("OverDraft Expiry Date";Rec."OverDraft Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}






