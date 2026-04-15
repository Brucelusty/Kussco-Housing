//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50150 "Loan Offset Detail List"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ToolTip = 'Specify the Member FOSA Account to Debit when reducing the Loan Balance,Only Specify When the Customer has not meet the Minimum Offset amount';
                    Visible = false;
                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    Caption = 'Loan to Offset';
                }
                field("Client Code"; Rec."Client Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("BOSA No"; Rec."BOSA No")
                {
                    Visible = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    Editable = false;
                }
                field("Loan Product";Rec."Loan Product")
                {
                    Editable = false;
                }
                field("Expected Repayment"; Rec."Expected Repayment")
                {

                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    Caption='Outstanding Balance';
                    Editable=false;
                    
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    Caption = 'Outstanding Interest';
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    Editable = false;
                }

                field("Interest On TopUp"; Rec."Interest On TopUp")
                {
                    // Caption = 'Booster Interest';
                    Editable = false;
                }
                field(Commision; Rec.Commision)
                {
                    // Caption = 'Booster Interest';
                    Editable = false;
                }
                field("Tax On Comission"; Rec."Tax On Comission")
                {
                    Editable = false;
                }
                field("Loan Insurance: Current Year"; Rec."Loan Insurance: Current Year")
                {
                    Visible = false;
                }
                field("Interest Due at Clearance"; Rec."Interest Due at Clearance")
                {
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        // area(creation)
        // {
        //     action("Loan Payoff")
        //     {
        //         Image = Document;
        //         Promoted = true;
        //         RunObject = Page "Loan PayOff List";
        //     }
        //     action(ReduceLoanBalance)
        //     {
        //         Image = Post;
        //         Promoted = true;

        //         trigger OnAction()
        //         begin

        //             ObjLoanOffset.Reset;
        //             ObjLoanOffset.SetRange(ObjLoanOffset."Loan Top Up", Rec."Loan Top Up");
        //             ObjLoanOffset.SetRange(ObjLoanOffset."FOSA Account", Rec."FOSA Account");
        //             if ObjLoanOffset.Find('-') then begin
        //                 if ObjLoanOffset."FOSA Account" = '' then begin
        //                     Error('Specify the FOSA Account to be Debited When reducing the Loan');
        //                 end;
        //                 Report.run(172934, true, false, ObjLoanOffset);
        //             end;
        //         end;
        //     }
        // }
    }

    var
        ObjLoanOffset: Record "Loan Offset Details";
}






