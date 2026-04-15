page 51025 "WrittenOff Loans List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    CardPageID = "WrittenOff Loans  Card";
    SourceTableView = WHERE(WriteOff = FILTER(true));
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                }
                field("Staff No"; Rec."Staff No")
                {
                }
                field("Client Code"; Rec."Client Code")
                {
                }
                field("Client Name"; Rec."Client Name")
                {
                }
                field("Write Off Amount"; Rec."Write Off Amount")
                {
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }
                field("Oustanding Interest"; Rec."Outstanding Interest")
                {
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Issued Date"; Rec."Issued Date")
                {
                }
                field("Loans Category"; Rec."Loans Category")
                {
                }
                field("Debt Collectors Name"; Rec."Debt Collector Name")
                {
                }
                field("Debtor Collection Status"; Rec."Debtor Collection Status")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Write-off Report")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = report "Write Off";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // UserSetup.GET(USERID);
        // IF UserSetup."Loan Porfolio Manager"=FALSE THEN BEGIN
        // DebtCollectorsDetails.SETRANGE(DebtCollectorsDetails.UserID,USERID);
        // IF DebtCollectorsDetails.FINDFIRST THEN BEGIN
        // Rec.SETFILTER(Rec."Debt Collector Name",DebtCollectorsDetails."Debt Collectors");
        // END ELSE BEGIN
        // ERROR('You do not have permmission to vie this list.');
        // END;
        // END;

        // users.Reset();
        // users.SetRange("User ID", UserId);
        // if users.Find('-') then begin
        //     if (users."Loan Porfolio Manager") and (users."Is Manager" = false) then begin
        //         debtCollectors.Reset();
        //         debtCollectors.SetRange(UserID, UserId);
        //         if debtCollectors.Find('-') then begin
        //             Rec.SetRange("Loan Debt Collector", debtCollectors."Debtors Code");
        //         end;
        //     end;

        //     if (users."Loan Porfolio Manager" = false) then begin
        //         Error('You do not have permissions to view this list');
        //     end;
        // end;
    end;

    trigger OnAfterGetRecord()
    begin
        // UserSetup.GET(USERID);
        // IF UserSetup."Loan Porfolio Manager"=FALSE THEN BEGIN
        // DebtCollectorsDetails.SETRANGE(DebtCollectorsDetails.UserID,USERID);
        // IF DebtCollectorsDetails.FINDFIRST THEN BEGIN
        // Rec.SETFILTER(Rec. "Debt Collector Name",DebtCollectorsDetails."Debt Collectors");
        // END ELSE BEGIN
        // ERROR('You do not have permmission to view this list.');
        // END;
        // END;

        users.Reset();
        users.SetRange("User ID", UserId);
        if users.Find('-') then begin
            if (users."Debt Collector") and (users."Loan Porfolio Manager" = false) then begin
                debtCollectors.Reset();
                debtCollectors.SetRange(UserID, UserId);
                if debtCollectors.Find('-') then begin
                    Rec.SetRange("Loan Debt Collector", debtCollectors."Debtors Code");
                end;
            end;

            if (users."Debt Collector" = false) then begin
                Error('You do not have permissions to view this list');
            end;
        end;
    end;

    var
        debtCollectors: Record "Debt Collectors Table";
        users: Record "User Setup";
        LoanApp: Record "Loans Register";
}

