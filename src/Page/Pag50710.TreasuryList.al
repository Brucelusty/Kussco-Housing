//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50710 "Treasury List"
{
    ApplicationArea = All;
    CardPageID = "Treasury Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter(Treasury));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            group("Report")
            {
                action("End of Day Report")
                {
                    Caption = 'Treasury End of Day Report';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory =Report; 
                    ToolTip = 'This will run a specified treasury''s end of day report for the current date';
                    trigger
                    OnAction()
                    begin
                        transdate := Today;
                        treasury := rec."No.";
                        bank.Reset();
                        bank.SetRange("Posting Date", transdate);
                        bank.SetRange("Bank Account No.", treasury);
                        Report.Run(173050, true, true, bank);
                    end;
                }
                action("General Treasury Report")
                {
                    
                    Caption = 'Treasury Transactions Report';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory =Report; 
                    ToolTip = 'This will run a specified treasury''s transactions report for the current date';
                    trigger
                    OnAction()
                    begin
                        transdate := Today;
                        treasury := rec."No.";
                        bank.Reset();
                        bank.SetRange("Posting Date", transdate);
                        bank.SetRange("Bank Account No.", treasury);
                        Report.Run(173020, true, true, bank);
                    end;
                }
            }
        }
    }

    var
    
    bank: Record "Bank Account Ledger Entry";
    transdate: Date;
    treasury: Code[20];
}






