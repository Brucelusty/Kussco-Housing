report 50076 "Staff Payslip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = StaffPayslip;

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            RequestFilterFields = "Employee Code", "Payroll Period";

            column(Payslip_Period; "prPeriod Transactions."."Payroll Period")
            { }
            column(TCode; "prPeriod Transactions."."Transaction Code")
            { }
            column(TName; "prPeriod Transactions."."Transaction Name")
            { }
            column(Amount; "prPeriod Transactions.".Amount)
            { }
            column(Grouping; "prPeriod Transactions."."Group Order")
            { }
            column(SubGroupOrder; "Sub Group Order")
            { }
            column(TBalances; Balance)
            { }
            column(payrollMonth; payrollMonth)
            { }
            column(PeriodMonth_prPeriodTransactions; "Period Month")
            { }
            column(PeriodYear_prPeriodTransactions; "Period Year")
            { }
            column(staffName; staffName)
            { }
            column(department; department)
            { }
            column(kra; kra)
            { }
            column(shif; shif)
            { }
            column(nssf; nssf)
            { }
            column(bankNo; bankNo)
            { }
            column(bankName; bankName)
            { }
            column(companyInfo_Name; companyInfo.Name)
            { }
            column(companyInfo_Pic; companyInfo.Picture)
            { }
            // column()
            // {}

            trigger OnAfterGetRecord()
            begin
                payrollMonth := dates.GetMonth("prPeriod Transactions."."Payroll Period");
                staff.Reset();
                staff.SetRange("No.", "prPeriod Transactions."."Employee Code");
                if staff.Find('-') then begin
                    staffName := staff.FullName();
                    department := staff."Responsibility Center name";
                    kra := staff."PIN No.";
                    nssf := staff."NSSF No.";
                    shif := staff."NHIF No.";
                end;
                payroll.Reset();
                payroll.SetRange("No.", "prPeriod Transactions."."Employee Code");
                if payroll.Find('-') then begin
                    bankNo := payroll."Bank Account No";
                    bankName := payroll."Bank Name";
                    employee := UpperCase(payroll.Firstname);
                    employeeEmail := LowerCase(payroll."Employee Email");
                end;

            end;

            trigger OnPostDataItem()
            begin

                if sendEmail then begin

                    payslipPeriod := Uppercase(dates.ConvertDate("prPeriod Transactions."."Payroll Period"));
                    fileName := employee + '-' + payslipPeriod + '-PAYSLIP';

                    emailSubject := payslipPeriod + ' PAYSLIP';
                    emailBody := 'Dear ' + employee + ',<br><br>Kindly find your <strong>Payslip</strong> for the year of <strong>' + payslipPeriod + '</strong> attached below.<br><br>Kind Regards,<br><br><strong>' + companyInfo.Name + '</strong>';

                    periodTrans.Reset();
                    periodTrans.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    periodTrans.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    if periodTrans.FindSet() then begin
                        tempBlob.CreateOutStream(outStr, TextEncoding::UTF8);
                        recRef.GetTable(periodTrans);
                        Report.SaveAs(Report::"Staff Payslip", '', ReportFormat::Pdf, outStr, recRef);
                        tempBlob.CreateInStream(inStr, TextEncoding::UTF8);
                        fileX64 := baseX64.ToBase64(inStr);
                    end;

                    emailMessage.Create(employeeEmail, emailSubject, emailBody, true);
                    emailMessage.AddAttachment(fileName + '.pdf', 'PDF', fileX64);
                    email.Send(emailMessage, Enum::"Email Scenario"::Payslip);
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
                    field(sendEmail; sendEmail)
                    {
                        Caption = 'Send Via Email';
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    rendering
    {
        layout(StaffPayslip)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/StaffPayslip.rdlc';
        }
    }

    trigger OnInitReport()
    begin
        companyInfo.Get();
        companyInfo.CalcFields("CEO Signature", Picture);
    end;

    var
        myInt: Integer;
        sendEmail: Boolean;
        fileX64: Text;
        payslipPeriod: Text;
        employee: Text;
        employeeEmail: Text;
        fileName: Text;
        emailSubject: Text;
        emailBody: Text;
        payrollMonth: Code[50];
        department: Code[50];
        nssf: Code[20];
        shif: Code[20];
        kra: Code[20];
        bankNo: Code[50];
        bankName: Code[100];
        staffName: Code[200];
        outStr: OutStream;
        inStr: InStream;
        recRef: RecordRef;
        tempBlob: Codeunit "Temp Blob";
        baseX64: Codeunit "Base64 Convert";
        email: Codeunit Email;
        emailMessage: Codeunit "Email Message";
        dates: Codeunit "Dates Calculation";
        companyInfo: Record "Company Information";
        staff: Record "HR Employees";
        payroll: Record "Payroll Employee.";
        periodTrans: Record "prPeriod Transactions.";
}


