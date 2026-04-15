//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50963 "Cases Assigned card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Cases Management";
    //SourceTableView = where(Status = filter(Escalated));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number";Rec."Case Number")
                {
                    Editable = false;
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field("Type of cases";Rec."Type of cases")
                {
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Action Taken";Rec."Action Taken")
                {
                }
            }
            group("Member Information")
            {
                Editable = false;
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                    Editable = false;
                }
                field("Share Capital";Rec."Share Capital")
                {
                    Editable = false;
                }
                field("Current Deposits";Rec."Current Deposits")
                {
                    Editable = false;
                }
                field("ID No";Rec."ID No")
                {
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                Editable = false;
                Visible=false;
                field(Control39; Rec."Employment Info")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if Rec."Employment Info" = Rec."employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;




                        /*IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;*/

                    end;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employer Name";Rec."Employer Name")
                {
                    Editable = EmployedEditable;
                }
                field("Employer Address";Rec."Employer Address")
                {
                    Editable = EmployerAddressEditable;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment";Rec."Terms of Employment")
                {
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment";Rec."Date of Employment")
                {
                    Editable = EmploymentDateEditable;
                }
                field("Position Held";Rec."Position Held")
                {
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income";Rec."Expected Monthly Income")
                {
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business";Rec."Nature Of Business")
                {
                    Editable = NatureofBussEditable;
                }
                field(Industry; Rec.Industry)
                {
                    Editable = IndustryEditable;
                }
                field("Business Name";Rec."Business Name")
                {
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location";Rec."Physical Business Location")
                {
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence";Rec."Year of Commence")
                {
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation; Rec.Occupation)
                {
                    Editable = OccupationEditable;
                }
                field("Others Details";Rec."Others Details")
                {
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                Caption = 'Referee Details';
                Editable = false;
                field("Referee Member No";Rec."Referee Member No")
                {
                }
                field("Referee Name";Rec."Referee Name")
                {
                    Editable = false;
                }
                field("Referee ID No";Rec."Referee ID No")
                {
                    Editable = false;
                }
                field("Referee Mobile Phone No";Rec."Referee Mobile Phone No")
                {
                    Editable = false;
                }
            }
            group("Case Information")
            {
                field("Captured By";Rec."Captured By")
                {
                    Editable = false;
                }
                field("Captured On";Rec."Captured On")
                {
                    Editable = false;
                }
                field("Date of Escalation";Rec."Date of Escalation")
                {
                    Editable = false;
                }
                field("Time of Escalation";Rec."Time of Escalation")
                {
                    Editable = false;
                }
                field("Date Resolved";Rec."Date Resolved")
                {
                    Editable = false;
                }
                field("Time Resolved";Rec."Time Resolved")
                {
                    Editable = false;
                }
                field("Resolved User";Rec."Resolved User")
                {
                    Caption = 'Resolved By';
                }
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                    Caption = 'Case Escalated to:';
                    Editable = false;
                }
                field("Case Received  Date";Rec."Case Received  Date")
                {
                }
                field(Timelines; Rec.SLA)
                {
                }
                field("Date To Settle Case";Rec."Date To Settle Case")
                {
                    Caption = 'Expected Date of Resolution';
                    Editable = false;
                }
                field(Recomendations; Rec.Recomendations)
                {
                }
                field("Support Documents";Rec."Support Documents")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Resource Assigned";Rec."Resource Assigned")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
                Visible=false;
            }
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("FOSA Account.");
                Visible=false;
            }
            part(Control1; "Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code" = field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark Resolved")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Resolved then begin
                        Error('Case already resolved');
                    end;

                    if Confirm('Are you sure you want to mark this case as resolved?', false) = true then begin
                        Rec.Status :=Rec. Status::Resolved;
                        Rec."Date Resolved" := Today;
                        Rec."Time Resolved" := Time;
                    end;
                end;
            }
            action("Additional Case Details")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Details";
                RunPageLink = "Case No" = field("Case Number");
            }
        
            action("Recall Case")
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                        if ObjGenEnquiry."Captured By" <> UserId then begin
                            Error('You can only recall an issue you have initiated');
                        end;
                    end;

                    if Confirm('Confirm you want to recall this case', false) = true then begin
                        ObjCaseManagement.Reset;
                        ObjCaseManagement.SetRange(ObjCaseManagement."Case Number", ObjCaseManagement."Case Number");
                        if ObjCaseManagement.FindSet then begin
                            ObjCaseManagement.Delete;
                        end;

                        if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                            ObjGenEnquiry.Status := ObjGenEnquiry.Status::New;
                            ObjGenEnquiry.Send := false;
                            ObjGenEnquiry.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec.SetRange("Resource Assigned", UserId);
    end;

    trigger OnOpenPage()
    begin
        //SetRange("Resource Assigned", UserId);
    end;

    var
        CustCare: Record "General Equiries.";
        AssignedReas: Record "Cases Management";
        caseCare: Record "Cases Management";
        casep: Record "Cases Management";
        GenSetUp: Record "Sacco General Set-Up";
        //notifymail: Codeunit "SMTP Mail";
        EmploymentInfoEditable: Boolean;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmployerCodeEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        OccupationEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        LoanNoVisible: Boolean;
        ObjCaseManagement: Record "Cases Management";
        ObjGenEnquiry: Record "General Equiries.";

    local procedure sms()
    var
        iEntryNo: Integer;
        SMSMessages: Record "SMS Messages";
        Cust: Record "Members Register";
    begin

        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := Rec."Member No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'Cases';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        //SMSMessages."Sent To Server":=SMSMessages."Sent To Server::No;
        SMSMessages."SMS Message" := 'Your case/complain has been received and assigned to.' + Rec."Resource #2" +
                                  ' kindly contact the resource for follow ups';
        Cust.Reset;
        if Cust.Get(Rec."Member No.") then
            SMSMessages."Telephone No" := Cust."Phone No.";
        SMSMessages.Insert;
    end;

    local procedure smsResolved()
    var
        iEntryNo: Integer;
        SMSMessages: Record "SMS Messages";
        cust: Record "Members Register";
    begin

        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := Rec."Member No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'Cases';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        //SMSMessages."Sent To Server":=SMSMessages."Sent To Server::No;
        SMSMessages."SMS Message" := 'Your case/complain has been resolved by.' + Rec."Resolved User" +
                                  ' Thank you for your being our priority customer';
        cust.Reset;
        if cust.Get(Rec."Member No.") then
            SMSMessages."Telephone No" := cust."Phone No.";
        SMSMessages.Insert;
    end;

    local procedure Sendtouser()
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Usersetup: Record User;
        phoneNo: Code[20];
        userAuthorizer: Text;
    begin
        Usersetup.Reset;
        Usersetup.SetRange(Usersetup."User Name", Rec."Resource Assigned");
        if Usersetup.Find('-') then begin
            //  phoneNo:=Usersetup."Phone No";
        end;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessage.Reset;
        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Account No" := userAuthorizer;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'CASES';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Your have been assigned a cases of ' + Rec."Member No." + 'of ' + Rec."Case Description" + 'on' + Format(Today) + 'at' + Format(Time) + 'kindly give it priority';
        SMSMessage."Telephone No" := phoneNo;
        SMSMessage.Insert;
    end;

    local procedure SendEmailuser()
    var
        Usersetup: Record User;
        phoneNo: Code[20];
        UserEmail: Text;
        Recipients: List of [Text];
    begin
        Usersetup.Reset;
        Usersetup.SetRange(Usersetup."User Name", Rec."Resource Assigned");
        if Usersetup.Find('-') then begin
            UserEmail := Usersetup."Contact Email";
        end;
        Recipients.Add(UserEmail);
        GenSetUp.Get;
        GenSetUp.Get;
        if GenSetUp."Send Email Notifications" = true then begin
            // notifymail.CreateMessage(UserId, GenSetUp."Sender Address", Recipients, 'Case Reported', 'Dear ' + Usersetup."User Name" + ' Your have been assigned a cases of ' + ' Member: ' + "Member No." + ' ' + "Case Description" + ' on '
            // + Format(Today) + 'kindly give it priority', false);



            // notifymail.Send;



        end;
    end;

    local procedure Emailcustomer()
    var
        CustomerEmailtext: Text;
        memb: Record "Members Register";
        CustRecipient: List of [Text];
    begin
        if memb.Get(Rec."Member No.") then begin
            CustomerEmailtext := memb."E-Mail (Personal)";
        end else
            CustomerEmailtext := memb."E-Mail";
        GenSetUp.Get();
        CustRecipient.Add(CustomerEmailtext);
        if GenSetUp."Send Email Notifications" = true then begin
            //notifymail.CreateMessage('Cases Reported',GenSetUp."Sender Address",UserEmail,'Your have been assigned a cases of '+ "Member No"+'of '+"Case Description"+'on'+FORMAT(TODAY)+'at'+FORMAT(TIME)+'kindly give it priority',FALSE);
            // notifymail.CreateMessage(UserId, GenSetUp."Sender Address", CustRecipient, 'Case Reported', 'Dear ' + memb.Name + ' Your case/complain has been fully resolved by ' + ' User: ' + UserId + ' ' + "Case Description" + ' on '
            // + Format(Today) + 'thank you  for being our customer', false);


            // notifymail.Send;



        end;
    end;
}






