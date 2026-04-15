report 50077 "Staff P9 Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = StaffP9Slip;
    
    dataset
    {
        
        dataitem("Payroll Employee P9."; "Payroll Employee P9.")
        {
            RequestFilterFields = "Period Year";
            column(PensionAmt; PensionAmt)
            {
            }
            column(PenNSSF; PenNSSF)
            {
            }
            column(employeePin;employeePin)
            {
            }
            column(EmployeeCode_PayrollEmployeeP9; "Payroll Employee P9."."Employee Code")
            {
            }
            column(BasicPay_PayrollEmployeeP9; "Payroll Employee P9."."Basic Pay")
            {
            }
            column(Allowances_PayrollEmployeeP9; "Payroll Employee P9.".Allowances)
            {
            }
            column(Benefits_PayrollEmployeeP9; "Payroll Employee P9.".Benefits)
            {
            }
            column(ValueOfQuarters_PayrollEmployeeP9; "Payroll Employee P9."."Value Of Quarters")
            {
            }
            column(DefinedContribution_PayrollEmployeeP9; "Payroll Employee P9."."Defined Contribution")
            {
            }
            column(OwnerOccupierInterest_PayrollEmployeeP9; "Payroll Employee P9."."Owner Occupier Interest")
            {
            }
            column(GrossPay_PayrollEmployeeP9; "Payroll Employee P9."."Gross Pay" + Bonus)
            {
            }
            column(TaxablePay_PayrollEmployeeP9; "Payroll Employee P9."."Taxable Pay")
            {
            }
            column(TaxCharged_PayrollEmployeeP9; "Payroll Employee P9."."Tax Charged")
            {
            }
            column(InsuranceRelief_PayrollEmployeeP9; "Payroll Employee P9."."Insurance Relief")
            {
            }
            column(TaxRelief_PayrollEmployeeP9; "Payroll Employee P9."."Tax Relief")
            {
            }
            column(PAYE_PayrollEmployeeP9; "Payroll Employee P9.".PAYE)
            {
            }
            column(NSSF_PayrollEmployeeP9; "Payroll Employee P9.".NSSF)
            {
            }
            column(NHIF_PayrollEmployeeP9; "Payroll Employee P9.".NHIF)
            {
            }
            column(Deductions_PayrollEmployeeP9; "Payroll Employee P9.".Deductions)
            {
            }
            column(NetPay_PayrollEmployeeP9; "Payroll Employee P9."."Net Pay")
            {
            }
            column(PeriodMonth_PayrollEmployeeP9; "Payroll Employee P9."."Period Month")
            {
            }
            column(PeriodYear_PayrollEmployeeP9; "Payroll Employee P9."."Period Year")
            {
            }
            column(PayrollPeriod_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Period")
            {
            }
            column(PeriodFilter_PayrollEmployeeP9; "Payroll Employee P9."."Period Filter")
            {
            }
            column(Pension_PayrollEmployeeP9; "Payroll Employee P9.".Pension)
            {
            }
            column(HELB_PayrollEmployeeP9; "Payroll Employee P9.".HELB)
            {
            }
            column(Housing_Levy_PayrollEmployeeP9; "Payroll Employee P9."."Housing Levy")
            {
            }
            column(PayrollCode_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Code")
            {
            }
            column(MonthText; MonthText)
            {
            }
            column(ColG; ColG)
            {
            }
            column(Grosspay_ColG; "Payroll Employee P9."."Gross Pay" - ColG)
            {
            }
            column(FixedContribution; FixedContribution)
            {
            }
            column(Amount3; Amount3)
            {
            }
            column(Amount1; Amount1)
            {
            }
            column(Provident; Provident)
            {
            }
            column(Allowance; Allowance)
            {
            }
            column(payrollMonth;payrollMonth)
            {}
            column(staffName;staffName)
            {}
            column(department; department)
            {}
            column(kra;kra)
            {}
            column(shif;shif)
            {}
            column(nssf;nssf)
            {}
            column(bankNo;bankNo)
            {}
            column(bankName;bankName)
            {}
            
            column(No_HREmployees; "Employee Code")
            {
            }
            column(FirstName_HREmployees; firstname)
            {
            }
            column(MiddleName_HREmployees; surname)
            {
            }
            column(LastName_HREmployees; lastname)
            {
            }
            column(Initials_HREmployees; lastname)
            {
            }
            column(SearchName_HREmployees; surname)
            {
            }
            column(PostalAddress_HREmployees; pfNo)
            {
            }
            column(ResidentialAddress_HREmployees; pfNo)
            {
            }
            column(PIN; PINNo)
            {
            }
            column(Bonus;Bonus)
            {
            }
            column(TotalH; TotalH)
            {
            }
            column(TotalL; TotalL)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(TaxRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            // column()
            // {}
            trigger OnAfterGetRecord() begin

                hrSetup.Get();
                employeePin := hrSetup."Employer Pin";
                
                staff.Reset();
                staff.SetRange("No.", "Payroll Employee P9."."Employee Code");
                if staff.Find('-') then begin
                    staffName := staff.FullName();
                    department := staff."Responsibility Center name";
                    kra := staff."PIN No.";
                    nssfNo := staff."NSSF No.";
                    shif := staff."NHIF No.";
                end;
                payroll.Reset();
                payroll.SetRange("No.", "Payroll Employee P9."."Employee Code");
                if payroll.Find('-') then begin
                    bankNo := payroll."Bank Account No";
                    bankName := payroll."Bank Name";
                    PINNo := payroll."PIN No";
                    pfNo := payroll."Payroll No";
                    surname := payroll.Surname;
                    lastname := payroll.Lastname;
                    firstname := payroll.Firstname;
                    employeeEmail := payroll."Employee Email";
                end;

                PensionAmt := 0;
                NSSFAmt := 0;
                PenNSSF := 0;
                BPAY := 0;
                Allowance := 0;
                BPAY := "Payroll Employee P9."."Basic Pay";
                Provident := 0;
                Allowance := "Payroll Employee P9.".Allowances;
                NSSFAmt := "Payroll Employee P9.".NSSF;
                PenNSSF := PensionAmt;
                if PenNSSF = 0 then
                    PenNSSF := NSSFAmt;
                Provident := NSSFAmt + PensionAmt;


                case "Period Month" of
                    1:
                        MonthText := 'January';
                    2:
                        MonthText := 'February';
                    3:
                        MonthText := 'March';
                    4:
                        MonthText := 'April';
                    5:
                        MonthText := 'May';
                    6:
                        MonthText := 'June';
                    7:
                        MonthText := 'July';
                    8:
                        MonthText := 'August';
                    9:
                        MonthText := 'September';
                    10:
                        MonthText := 'October';
                    11:
                        MonthText := 'November';
                    12:
                        MonthText := 'December';
                    else
                        MonthText := '';
                end;

                if (NSSF) > 20000 then begin
                    ColG := 20000 + "Owner Occupier Interest";
                end
                else begin
                    ColG := (NSSF) + "Owner Occupier Interest";
                end;
                FixedContribution := 20000;
                HTotal := "Gross Pay" - ColG;

                Amount1 := 0;
                Amount2 := 0;
                Amount3 := 0;
                if PenNSSF < FixedContribution then
                    Amount1 := PenNSSF
                else
                    if FixedContribution < PenNSSF then
                        Amount1 := FixedContribution;

                Amount2 := Amount1 + "Payroll Employee P9."."Owner Occupier Interest";
                Amount3 := "Payroll Employee P9."."Gross Pay" - Provident;
                TotaA := 0;
                TotalB := 0;
                totalC := 0;
                totalD := 0;
                TotalE1 := 0;
                TotalE2 := 0;
                TotalE3 := 0;
                TotalF := 0;
                TotalG := 0;
                TotalH := 0;
                TotalJ := 0;
                TotalK := 0;
                TotalL := 0;
                P9.Reset;
                P9.SetRange(P9."Employee Code", "Payroll Employee P9."."Employee Code");
                P9.SetRange(P9."Period Year", 2016);
                if P9.Find('-') then begin
                    repeat
                        TotaA := TotaA + P9."Basic Pay";
                        TotalB := TotalB + P9.Benefits;
                        totalC := totalC + P9."Value Of Quarters";
                        totalD := totalD + P9."Gross Pay";
                        TotalE1 := TotalE1 + (P9."Basic Pay" * 0.3);
                        TotalE2 := TotalE2 + (P9.NSSF);
                        TotalE3 := TotalE3 + 20000;
                        TotalF := TotalF + P9."Owner Occupier Interest";
                        if P9.NSSF < 20000 then begin
                            TotalH := TotalH + (P9."Gross Pay" - (P9.NSSF));
                        end else begin
                            TotalH := TotalH + (P9."Gross Pay" - 20000);
                        end;
                        TotalJ := TotalJ + P9."Tax Charged";
                        TotalK := TotalK + (P9."Tax Relief" + P9."Insurance Relief");
                        TotalL := TotalL + P9.PAYE;
                    until P9.Next = 0;
                end;

                cust.Reset();
                cust.SetRange("Payroll No", "Payroll Employee P9."."Employee Code");
                if cust.Find('-') then begin
                    bonusLines.Reset();
                    bonusLines.SetRange("Vendor No.", cust."Ordinary Savings Acc");
                    bonusLines.SetRange("Document No.", 'SAL0023');
                    bonusLines.SetFilter("Credit Amount", '>%1', 0);
                    bonusLines.SetRange(Reversed, false);
                    if bonusLines.Find('-') then begin
                        Bonus := bonusLines."Credit Amount";
                    end;
                    if ("Payroll Employee P9."."Period Month" = 4) and ("Payroll Employee P9."."Period Year" = 2024) then begin
                        Bonus := Bonus;
                    end else Bonus := 0;

                    // bonusLines.Reset();
                    // bonusLines.SetRange("Vendor No.", cust."Ordinary Savings Acc");
                    // bonusLines.SetRange("Document No.", 'SAL0288');
                    // bonusLines.SetFilter("Credit Amount", '>%1', 0);
                    // bonusLines.SetRange(Reversed, false);
                    // if bonusLines.Find('-') then begin
                    //     Bonus := bonusLines."Credit Amount";
                    // end;
                    // if ("Payroll Employee P9."."Period Month" = 4) and ("Payroll Employee P9."."Period Year" = 2025) then begin
                    //     Bonus := Bonus;
                    // end else Bonus := 0;
                end;

                if "Payroll Employee P9."."Period Month" = 4 then begin

                    payrollSetup.Get();
                    "Payroll Employee P9."."Taxable Pay" := (("Payroll Employee P9."."Gross Pay" + Bonus) - 2160);
                    "Payroll Employee P9."."Tax Charged" := ProcessPayroll.fnGetEmployeePaye(("Payroll Employee P9."."Gross Pay" + Bonus) - 2160) + 2400;
                    "Payroll Employee P9.".NHIF := ProcessPayroll.fnGetEmployeeNHIF("Payroll Employee P9."."Gross Pay");
                    // "Payroll Employee P9."."Housing Levy" := Round((payrollSetup."Zakayo Levy"/100) * "Payroll Employee P9."."Gross Pay", 0.01, '=');

                    "Payroll Employee P9.".PAYE := ProcessPayroll.fnGetEmployeePaye(("Payroll Employee P9."."Gross Pay" + Bonus) - 2160) - (240);
                    "Payroll Employee P9.".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                if sendEmail then begin
                    
                    p9Year := Format("Payroll Employee P9."."Period Year");
                    fileName := staffName + '-' + p9Year + '-P9 SLIP';
                    
                    emailSubject := p9Year + ' P9 SLIP';
                    emailBody := 'Dear '+staffName+',<br>Kindly find your <strong>P9 Slip</strong> for the year of <strong>' + p9Year + '</strong> attached below.<br>Kind Regards,<br><strong>'+companyInfo.Name+'</strong>';
                    
                    Recipients.Add(LowerCase(employeeEmail));
                    BccList.Add('mmutuku@auinnovation.co.ke');
                    
                    P9.Reset();
                    P9.SetRange("Employee Code", "Payroll Employee P9."."Employee Code");
                    P9.SetRange("Period Year", "Payroll Employee P9."."Period Year");
                    if P9.FindSet() then begin
                        tempBlob.CreateOutStream(outStr, TextEncoding::UTF8);
                        recRef.GetTable(P9);
                        Report.SaveAs(Report::"Staff P9 Slip", '', ReportFormat::Pdf, outStr, recRef);
                        tempBlob.CreateInStream(inStr, TextEncoding::UTF8);
                        fileX64 := baseX64.ToBase64(inStr);
                    end;

                    emailMessage.Create(Recipients, emailSubject, emailBody, true, CCList, BccList);
                    emailMessage.AddAttachment(fileName + '.pdf', 'PDF', fileX64);
                    email.Send(emailMessage, Enum::"Email Scenario"::Payslip);
                    
                    if Recipients.Count > 0 then begin
                        Recipients.RemoveRange(1, 1);
                    end;
                    if BccList.Count > 0 then begin
                        BccList.RemoveRange(1, 1);
                    end;
                end;
            end;

        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(sendEmail;sendEmail)
                    {
                        Caption = 'Send Via Email';
                    ApplicationArea = All;
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(StaffP9Slip)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/StaffP9Slip.rdlc';
        }
    }

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields("CEO Signature", Picture);
    end;

    
    var
    myInt: Integer;
    sendEmail: Boolean;
    MonthText: Text;
    fileX64: Text;
    employee: Text;
    employeeEmail: Text;
    fileName: Text;
    emailSubject: Text;
    emailBody: Text;
    Recipients: List of [text];
    CCList: List of [Text];
    BccList: List of [Text];
    payrollMonth: Code[50];
    pfNo: Code[50];
    surname: Code[50];
    lastname: Code[50];
    firstname: Code[50];
    department: Code[50];
    nssfNo: Code[20];
    shif: Code[20];
    kra: Code[20];
    bankNo: Code[50];
    p9Year: Code[50];
    bankName: Code[100];
    staffName: Code[200];
    PINNo: Code[20];
    employeePin: Code[20];
    ColG: Decimal;
    FixedContribution: Decimal;
    Bonus: Decimal;
    HTotal: Decimal;
    TotaA: Decimal;
    TotalB: Decimal;
    totalC: Decimal;
    totalD: Decimal;
    TotalE1: Decimal;
    TotalE2: Decimal;
    TotalE3: Decimal;
    TotalF: Decimal;
    TotalG: Decimal;
    TotalH: Decimal;
    TotalI: Decimal;
    TotalJ: Decimal;
    TotalK: Decimal;
    TotalL: Decimal;
    PensionAmt: Decimal;
    NSSFAmt: Decimal;
    PenNSSF: Decimal;
    Amount1: Decimal;
    Amount2: Decimal;
    Amount3: Decimal;
    BPAY: Decimal;
    Provident: Decimal;
    Allowance: Decimal;
    outStr: OutStream;
    inStr: InStream;
    recRef: RecordRef;
    ProcessPayroll: Codeunit "AU Payroll Processing";
    tempBlob: Codeunit "Temp Blob";
    baseX64: Codeunit "Base64 Convert";
    email: Codeunit Email;
    emailMessage: Codeunit "Email Message";
    dates: Codeunit "Dates Calculation";
    payrollSetup: Record "Payroll General Setup.";
    companyInfo: Record "Company Information";
    staff: Record "HR Employees";
    payroll: Record "Payroll Employee.";
    P9: Record "Payroll Employee P9.";
    bonusHeader: Record "Bonus Header";
    cust: Record Customer;
    bonusLines: Record "Detailed Vendor Ledg. Entry";
    hrSetup: Record "HR Setup";
}



