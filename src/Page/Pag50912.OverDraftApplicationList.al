//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50912 "OverDraft Application List"
{
    ApplicationArea = All;
    CardPageID = "OverDraft Application Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "OverDraft Application";
    SourceTableView = where("OD Application Effected" = filter(false));

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
                field("Created By";Rec."Created By")
                {
                }
                field("Security Type";Rec."Security Type")
                {
                }
                field(Status; Rec.Status)
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






