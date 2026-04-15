page 51028 "Defaulter SMS Notification"
{
    ApplicationArea = All;
   CardPageID = "Defauter Notification Card";
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = WHERE("Loans Category"=FILTER(Substandard|Doubtful|Loss));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                }
                field("Client Code";Rec."Client Code")
                {
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field("Issued Date";Rec."Issued Date")
                {
                }
                field("Loans Category";Rec."Loans Category")
                {
                }
                field("Debt Collectors Name";Rec."Debt Collector Name")
                {
                }
                field("Debtor Collection Status";Rec."Debtor Collection Status")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        // Rec.SETFILTER("Notification Date",'>=%1',TODAY);
        UserSetup.GET(USERID);
        IF UserSetup."Debt Collector"=FALSE THEN BEGIN
            DebtCollectorsDetails.SETRANGE(DebtCollectorsDetails.UserID,USERID);
            IF DebtCollectorsDetails.FINDFIRST THEN BEGIN
                Rec.SETFILTER(Rec."Debt Collector Name",DebtCollectorsDetails."Debt Collectors");
            END ELSE BEGIN
                ERROR('You do not have permmission to view this list.');
            END;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        //Rec.SETFILTER("Notification Date",'>=%1',TODAY);
        UserSetup.GET(USERID);
        IF UserSetup."Debt Collector"=FALSE THEN BEGIN
            DebtCollectorsDetails.SETRANGE(DebtCollectorsDetails.UserID,USERID);
            IF DebtCollectorsDetails.FINDFIRST THEN BEGIN
                Rec.SETFILTER(Rec."Debt Collector Name",DebtCollectorsDetails."Debt Collectors");
            END ELSE BEGIN
                ERROR('You do not have permmission to view this list.');
            END;
        END;
    end;

    var
        PeriodDate: Date;
        DateFilter: Text;
        DebtCollectorsDetails: Record "Debt Collectors Table";
        UserSetup: Record "User Setup";
}




