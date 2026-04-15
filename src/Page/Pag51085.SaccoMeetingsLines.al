page 51085 "Sacco Meetings Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Meeting Lines";
    // DeleteAllowed = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field(Allowance;Rec.Allowance)
                {
                    // Enabled = allowance;
                    Editable = false;
                }
                field("Member Present";Rec."Member Present")
                {
                }
                field(Dormant;Rec.Dormant)
                {
                    Editable = false;
                }
                field(Defaulter;Rec.Defaulter)
                {
                    Editable = false;
                }
                field("Already Paid";Rec."Already Paid")
                {
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Upload)
            {
                Caption = 'Upload Members';
                Image = CustomerContact;
                
                trigger OnAction()
                begin
                    saccoMeet.Reset();
                    saccoMeet.SetRange("Meeting No", rec."Doc No.");
                    if saccoMeet.Find('-') then begin
                        if saccoMeet."Approval Status" = saccoMeet."Approval Status"::Approved then Error('You cannot alter the attendees of this meeting once it has been approved.');
                    end;
                    
                    saccoMeet.Reset();
                    saccoMeet.SetRange("Meeting No", rec."Doc No.");
                    if saccoMeet.Find('-') then begin
                        if saccoMeet."Meeting Type" = saccoMeet."Meeting Type"::"Board Meeting" then begin
                            committeeMembers.Reset();
                            committeeMembers.SetRange(Committee, saccoMeet."Committee No");
                            if committeeMembers.FindSet() then begin
                                repeat
                                rec.Init();
                                rec."Member No" := insider."Member No";
                                rec.Validate("Member No");
                                if not rec.Insert() then rec.Modify();
                                until committeeMembers.Next() = 0;
                            end;
                        end else if saccoMeet."Meeting Type" = saccoMeet."Meeting Type"::Delegates then begin
                            insider.Reset();
                            insider.SetFilter("Position Held", '%1|%2', insider."Position Held"::Delegate, insider."Position Held"::Director);
                            if insider.FindSet() then begin
                                repeat
                                rec.Init();
                                rec."Member No" := insider."Member No";
                                rec.Validate("Member No");
                                if not rec.Insert() then rec.Modify();
                                until insider.Next()=0;
                            end;
                        end else if saccoMeet."Meeting Type" = saccoMeet."Meeting Type"::"Staff Meeting" then begin
                            insider.Reset();
                            insider.SetRange("Position Held", insider."Position Held"::Employee);
                            if insider.FindSet() then begin
                                repeat
                                rec.Init();
                                rec."Member No" := insider."Member No";
                                rec.Validate("Member No");
                                if not rec.Insert() then rec.Modify();
                                until insider.Next()=0;
                            end;
                        end;
                    end;
                end;
            }
            action(Update)
            {
                Caption = 'Update Deductions';
                Image = CustomerContact;
                
                trigger OnAction()
                begin
                    saccoMeet.Reset();
                    saccoMeet.SetRange("Meeting No", rec."Doc No.");
                    if saccoMeet.Find('-') then begin

                        fundsSetup.Get();

                        saccoMeetAttendees.Reset();
                        saccoMeetAttendees.SetRange("Doc No.", Rec."Doc No.");
                        if saccoMeetAttendees.FindSet() then begin
                            repeat
                            payment := 0;
                            cust.Reset();
                            if cust.Get(saccoMeetAttendees."Member No") then begin
                                // if (cust.Defaulter) or (cust."Loan Defaulter") then begin
                                if saccoMeet."Meeting Type" = saccoMeet."Meeting Type"::Delegates then begin
                                    payment := fundsSetup."Delegate Allowance";
                                end else if saccoMeet."Meeting Type" = saccoMeet."Meeting Type"::"Board Meeting" then begin
                                    committees.Reset();
                                    committees.SetRange("Committee", saccoMeet."Committee No");
                                    committees.SetRange("Is Active", true);
                                    committees.SetRange("Member No", saccoMeetAttendees."Member No");
                                    if committees.Find('-') then begin
                                        if saccoMeet."Special Meeting" then begin
                                            payment := committees."Sitting Allowance Special" + committees."Transport Allowance Special";
                                        end else begin
                                            payment := committees."Sitting Allowance" + committees."Transport Allowance";
                                        end;
                                    end;
                                end;
                                loansReg.Reset();
                                loansReg.SetRange("Client Code", cust."No.");
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetFilter("Expected Date of Completion", '<=%1', Today);
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                if loansReg.Find('-') then begin
                                    vend.Reset();
                                    vend.SetRange("BOSA Account No", cust."No.");
                                    vend.SetRange("Account Type", '103');
                                    if vend.Find('-') then begin
                                        if ((cust."Employer Code" = 'POSTAL CORP') or (cust."Employer Code" = 'KENYA POSTAL') and vend."Salary Processing") = false then begin
                                            saccoMeetAttendees.Defaulter := true;
                                            saccoMeetAttendees.Allowance := 0;
                                            saccoMeetAttendees.Modify;
                                        end else begin
                                            saccoMeetAttendees.Defaulter := false;
                                            saccoMeetAttendees.Allowance := payment;
                                            saccoMeetAttendees.Modify;
                                        end;
                                    end;
                                end else if (cust."Membership Status" <> cust."Membership Status"::Active) then begin
                                    saccoMeetAttendees.Dormant := true;
                                    saccoMeetAttendees.Allowance := 0;
                                    saccoMeetAttendees.Modify;
                                end else begin
                                    allowances.Reset();
                                    allowances.SetRange("Member No", saccoMeetAttendees."Member No");
                                    allowances.SetRange("Month No", Date2DMY(saccoMeet."Meeting Date", 2));
                                    allowances.SetRange(Year, Format(Date2DMY(saccoMeet."Meeting Date", 3)));
                                    allowances.SetFilter("Amount Paid", '>%1', 0);
                                    allowances.SetRange("Meeting Type", saccoMeet."Meeting Type");
                                    allowances.SetRange(Erroneous, false);
                                    if allowances.Find('-') then begin
                                        saccoMeetAttendees."Already Paid" := true;
                                        saccoMeetAttendees.Allowance := 0;
                                        saccoMeetAttendees.Modify;
                                    end else begin
                                        saccoMeetAttendees.Allowance := payment;
                                        saccoMeetAttendees.Modify;
                                    end;
                                end;

                                loansReg.Reset();
                                loansReg.SetRange("Client Code", cust."No.");
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetFilter("Expected Date of Completion", '<=%1', Today);
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                loansReg.SetRange("Loan Product Type", 'A03');
                                if loansReg.Find('-') then begin
                                    saccoMeetAttendees.Defaulter := true;
                                    saccoMeetAttendees.Allowance := 0;
                                    saccoMeetAttendees.Modify;
                                end;
                            end;
                            
                            if saccoMeetAttendees."Member Present" = false then begin
                                saccoMeetAttendees.Allowance := 0;
                                saccoMeetAttendees.Modify;
                            end;
                            until saccoMeetAttendees.Next() = 0;
                            Message('The members'' allowances have been updated successfully.');
                        end;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord() begin
        saccoMeet.Reset();
        saccoMeet.SetRange("Meeting No", Rec."Doc No.");
        if saccoMeet.Find('-') then begin
            if saccoMeet.Uploaded = true then begin
                allowance := true;
            end else allowance := false;
        end;
    end;
    var
    allowance: Boolean;
    payment: Decimal;
    cust: Record Customer;
    vend: Record Vendor;
    insider: Record InsiderLending;
    saccoMeet: Record "Sacco Meetings";
    loansReg: Record "Loans Register";
    saccoMeetAttendees: Record "Meeting Lines";
    allowances: Record "Meeting Allowances";
    fundsSetup: Record "Funds General Setup";
    committeeMembers: Record "Sacco Committee Members";
    committees: Record "Sacco Committee Members";
}


