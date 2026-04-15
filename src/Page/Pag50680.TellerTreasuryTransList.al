//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50680 "Teller & Treasury Trans List"
{
    ApplicationArea = All;
    CardPageID = "Teller & Treasury Trans Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Treasury Transactions";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("From Account"; Rec."From Account")
                {
                }
                field("From Account User"; Rec."From Account User")
                {
                    Caption = 'From';
                }
                field("To Account"; Rec."To Account")
                {
                }
                field("To Account User"; Rec."To Account User")
                {
                    Caption = 'To';
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("Treasury Register")
            {
                Caption = 'Treasury Register';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.RUN(175123);
                end;
            }
        }
    }
}







