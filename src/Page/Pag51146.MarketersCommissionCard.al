page 51146 "Marketers Commission Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Marketers Commission Header";
    Caption = 'Marketers Commission Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }

                field("Start Date"; Rec."Start Date")
                {
                }

                field("End Date"; Rec."End Date")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No"; Rec."Account No.")
                {
                }
                field("Total Commission"; Rec."Total Commission")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Document Date';
                    Editable = false;
                }

                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
            }

            part(Lines; "Commission Lines Subform")
            {
                SubPageLink = "Document No." = field("Document No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loadcommissions)
            {
                Caption = 'Load Commissions';
                Image = AnalysisView;
                action("Mark As Posted")
                {
                    Caption = 'Load Commissions';

                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if Confirm('This will load the commission lines for the customers registered within the start and end date. Do you want to continue?') then begin
                            CustomerRec.Reset();
                            CustomerRec.SetFilter(CustomerRec."Registration Date", '%1..%2', Rec."Start Date", Rec."End Date");
                            CustomerRec.SetFilter(CustomerRec."Reffered By Member No", '<>%1', '');
                            CustomerRec.SetRange(CustomerRec."Commission Paid", false);
                            if CustomerRec.FindSet() then begin
                                repeat
                                    EntryNo += 1;
                                    CommLines.Init();
                                    CommLines."Entry No." := EntryNo;
                                    CommLines."Document No." := Rec."Document No.";
                                    CommLines."Member No." := CustomerRec."No.";
                                    CommLines."Commission Amount" := 1000;
                                    CommLines."Commission To" := CustomerRec."Reffered By Member No";
                                    CommLines.Validate("Commission To");
                                    CommLines.Insert(true);

                                    Cust10.Reset();
                                    Cust10.SetRange(Cust10."No.", CustomerRec."Reffered By Member No");
                                    Cust10.SetFilter(Cust10."Reffered By Member No", '<>%1', '');
                                    if Cust10.FindFirst() then begin
                                        EntryNo += 1;
                                        CommLines.Init();
                                        CommLines."Entry No." := EntryNo;
                                        CommLines."Document No." := Rec."Document No.";
                                        CommLines."Member No." := CustomerRec."Reffered By Member No";
                                        CommLines."Commission Amount" := 500;
                                        CommLines."Commission To" := Cust10."Reffered By Member No";
                                        CommLines.Validate("Commission To");
                                        CommLines.Insert(true);

                                        Cust20.Reset();
                                        Cust20.SetRange(Cust20."No.", Cust10."Reffered By Member No");
                                        Cust20.SetFilter(Cust20."Reffered By Member No", '<>%1', '');
                                        if Cust20.FindFirst() then begin
                                            EntryNo += 1;
                                            CommLines.Init();
                                            CommLines."Entry No." := EntryNo;
                                            CommLines."Document No." := Rec."Document No.";
                                            CommLines."Member No." := CustomerRec."Reffered By Member No";
                                            CommLines."Commission Amount" := 250;
                                            CommLines."Commission To" := Cust20."Reffered By Member No";
                                            CommLines.Validate("Commission To");
                                            CommLines.Insert(true);
                                        end;
                                    end;


                                until CustomerRec.Next() = 0;
                            end;

                            Message('Commission lines have been loaded successfully');
                            //CurrPage.Close();
                        end;
                    end;
                }

                action(PostMemberCommissions)
                {
                    Caption = 'Post Member Commissions';
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if Rec.Posted then Error('Commissions for this document have already been posted.');
                        genTemplate := 'GENERAL';
                        genBatch := 'COMM';
                        generalJournal.Reset();
                        generalJournal.SetRange(generalJournal."Journal Template Name", genTemplate);
                        generalJournal.SetRange(generalJournal."Journal Batch Name", genBatch);
                        if generalJournal.FindSet() then begin
                            generalJournal.DeleteAll();
                        end;
                        if Confirm('This will post the commission amounts to the respective customers. Do you want to continue?') then begin
                            CommLines.Reset();
                            CommLines.SetRange(CommLines."Document No.", Rec."Document No.");
                            if CommLines.FindSet() then begin
                                repeat

                                    CustomerRec.Get(CommLines."Commission To");
                                    docNo := Rec."Document No.";
                                    // CustomerRec."Commission Balance" += CommLines."Commission Amount";

                                    lineNo := lineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::"Deposit Contribution",
                                    generalJournal."Account Type"::Customer, CustomerRec."No.", Today, (CommLines."Commission Amount" * -1), 'BOSA', CustomerRec."No.", 'Commission Payment' + CommLines."Member No.",
                                    loanNo, generalJournal."Application Source"::" ");


                                    lineNo := lineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                                    Rec."Account Type", Rec."Account No.", Today, (CommLines."Commission Amount"), 'BOSA', Rec."Account No.", 'Commission Payment' + CommLines."Member No.",
                                    loanNo, generalJournal."Application Source"::" ");


                                    Cust20.Reset();
                                    Cust20.SetRange(Cust20."No.", CommLines."Member No.");
                                    IF Cust20.FindFirst() then BEGIN 
                                    Cust20."Commission Posted" := true;
                                    Cust20."Commission Paid" := true;
                                    Cust20.Modify();
                                    END;
                                until CommLines.Next() = 0;
                            end;
                            generalJournal.Reset;
                            generalJournal.SetRange("Journal Template Name", genTemplate);
                            generalJournal.SetRange("Journal Batch Name", genBatch);
                            if generalJournal.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", generalJournal);
                            end;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec.Modify();
                            Message('Commissions have been posted successfully');
                            CurrPage.Close();
                        end;
                    end;
                }
            }
        }
    }

    var
        CustomerRec: Record Customer;
        Cust10: Record Customer;

        Cust20: Record Customer;
        EntryNo: Integer;
        CommLines: Record "Commission Lines";
        lineNo: Integer;
        loanNo: Code[20];
        genBatch: Code[20];
        genTemplate: Code[20];
        docNo: Code[20];
        refDate: date;
        defaultAmount: Decimal;
        accountBal: Decimal;
        recoveredAmount: Decimal;
        AUFactory: Codeunit "Au Factory";
        cust: Record Customer;
        vend: Record Vendor;
        loansReg: Record "Loans Register";
        detailedVend: Record "Detailed Vendor Ledg. Entry";
        generalBatch: Record "Gen. Journal Batch";
        generalJournal: Record "Gen. Journal Line";
}


