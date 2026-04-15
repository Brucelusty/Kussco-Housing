//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50608 "Bank Acc. Recon. List H"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. Reconciliation List';
    CardPageID = "Payroll General Setup LIST.";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = where("Statement Type" = const("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(BankAccountNo; Rec."Bank Account No.")
                {
                }
                field(StatementNo; Rec."Statement No.")
                {
                }
                field(StatementDate; Rec."Statement Date")
                {
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc. Recon. Post (Yes/No)";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Post Bank Rec" = false then Error('You dont have permissions to post, Contact your system administrator! ')
                        end;
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc. Recon. Post+Print";
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Post Bank Rec" = false then Error('You dont have permissions to post, Contact your system administrator! ')
                        end;
                    end;
                }
            }
        }
    }

    var
        UserSetup: Record "User Setup";
}






