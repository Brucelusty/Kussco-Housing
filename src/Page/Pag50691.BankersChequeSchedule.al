//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50691 "Bankers Cheque Schedule"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Type = const('Bankers Cheque'),
                            Posted = const(true),
                            "Banking Posted" = const(false));

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    Caption = 'Staff No';
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    Caption = 'Transaction';
                    Editable = false;
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                }
                field("Other Bankers No."; Rec."Other Bankers No.")
                {
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Reference No"; Rec."Reference No")
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                }
                field("BIH No"; Rec."BIH No")
                {
                }
                field(Select; Rec.Select)
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Banker Cheque")
            {
                Caption = 'Banker Cheque';
                action("Bankers Cheque Schedule")
                {
                    Caption = 'Bankers Cheque Schedule';
                    Visible = false;
                }
                separator(Action1102760029)
                {
                }
                action("Process Banking")
                {
                    Caption = 'Process Banking';
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Bank the selected cheques?', false) = true then begin

                            Transactions.Reset;
                            Transactions.SetRange(Type, 'Bankers Cheque');
                            Transactions.SetRange(Transactions.Select, true);
                            //Transactions.SETRANGE(Transactions."Cheque Processed",Transactions."Cheque Processed"::"0");
                            if Transactions.Find('-') then begin
                                repeat

                                    Transactions."Banked By" := UserId;
                                    Transactions."Date Banked" := Today;
                                    Transactions."Time Banked" := Time;
                                    Transactions."Banking Posted" := true;
                                    Transactions."Cheque Processed" := true;
                                    Transactions.Modify;
                                until Transactions.Next = 0;

                                Message('The selected bankers cheques banked successfully.');

                            end;
                        end;
                    end;
                }
                separator(Action1102760038)
                {
                }
                action("Commitement Cheque Schedule")
                {
                    Caption = 'Commitement Cheque Schedule';
                    Visible = false;
                }
            }
        }
        area(processing)
        {
            action("Select All")
            {
                Caption = 'Select All';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Transactions.Reset;
                    Transactions.SetRange(Type, 'Bankers Cheque');
                    Transactions.SetRange(Transactions.Select, false);
                    if Transactions.Find('-') then begin
                        repeat

                            Transactions.Select := true;
                            Transactions.Modify;
                        until Transactions.Next = 0;

                        Message('Bankers cheques selected successfully.');

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/
        //Filter based on branch

    end;

    var
        Transactions: Record Transactions;
        SupervisorApprovals: Record "Supervisors Approval Levels";
        UsersID: Record User;
}




