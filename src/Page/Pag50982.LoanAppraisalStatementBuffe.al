//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50982 "Loan Appraisal Statement Buffe"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Appraisal Statement Buffe";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                }
                field("Amount Out"; Rec."Amount Out")
                {
                }
                field("Amount In"; Rec."Amount In")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //Get Statement Avarage Credits
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan  No.", Rec."Loan No");
        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
        if ObjStatementB.FindSet then begin
            repeat
                VerStatementAvCredits := VerStatementAvCredits + Rec."Amount In";
                ObjStatementB."Bank Statement Avarage Credits" := VerStatementAvCredits / 6;
                ObjStatementB.Modify;
            until ObjStatementB.Next = 0;
        end;

        //Get Statement Avarage Debits
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan  No.", Rec."Loan No");
        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
        if ObjStatementB.FindSet then begin
            repeat
                VerStatementsAvDebits := VerStatementsAvDebits + Rec."Amount Out";
                ObjStatementB."Bank Statement Avarage Debits" := VerStatementsAvDebits / 6;
                ObjStatementB.Modify;
            until ObjStatementB.Next = 0;
        end;

        ObjStatementB."Bank Statement Net Income" := ObjStatementB."Bank Statement Avarage Credits" - ObjStatementB."Bank Statement Avarage Debits";
        ObjStatementB.Modify;
    end;

    var
        ObjStatementB: Record "Loans Register";
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
}






