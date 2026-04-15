//<---------------------------------------------------------------------->															
report 50640 "Guarantor Final Default Notice"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
        {
            RequestFilterFields = "Loan No";

            column(Loan_No; "Loan No")
            { }
            column(Member_No; "Member No")
            { }
            trigger OnAfterGetRecord()
            var
            begin
                if sendEmail then begin
                    cust.Reset();
                    cust.SetRange("No.", "Loans Guarantee Details"."Member No");
                    if cust.Find('-') then begin
                        Recipients.Add(LowerCase(cust."E-Mail"));
                    end;

                    loansReg.Reset();
                    loansReg.SetRange("Loan  No.", "Loans Guarantee Details"."Loan No");
                    if loansReg.Find('-') then begin
                        cust.Reset();
                        cust.SetRange("No.", loansReg."Client Code");
                        if cust.Find('-') then begin
                            defaulterName := UpperCase(cust."First Name");
                            defaulterEmail := LowerCase(cust."E-Mail");
                            CCList.Add(defaulterEmail);
                            if defaulterEmail = '' then Error('Ensure the member %1 has an email address.', loansReg."Client Code");
                        end;

                        BccList.Add('info@telepostsacco.co.ke');
                        BccList.Add('debt@telepostsacco.co.ke');
                        // BccList.Add('mutuku.muia13@gmail.com');

                        Filename := 'Loan Defaulter Final Notice';
                        EmailSubject := 'FINAL DEFAULTER NOTICE';
                        EmailBody := 'Dear ' + "Loans Guarantee Details".Name + ', <br><br> Kindly find attached below the final defaulter notice on your guaranteed defaulted <strong>%1</strong> Loan.';
                        // EmailBody += '<br><br><hr> <strong> Be advised, this is a test case on defaulter notices </strong> </hr>';
                        FinalEmailBody := StrSubstNo(EmailBody, loansReg."Loan Product Type Name");

                        loanGuaranteed.Reset();
                        loanGuaranteed.SetRange("Loan No", "Loans Guarantee Details"."Loan No");
                        loanGuaranteed.SetRange("Member No", "Loans Guarantee Details"."Member No");
                        if loanGuaranteed.Find('-') then begin
                            TempBlob.CreateOutStream(Outstrm, TextEncoding::UTF8);
                            RecRef.GetTable(loanGuaranteed);
                            Report.SaveAs(Report::"Final Notice Loan Defaulter", '', ReportFormat::Pdf, Outstrm, RecRef);
                            TempBlob.CreateInStream(InStrm, TextEncoding::UTF8);
                            ConvertedFile := Base64Conversion.ToBase64(InStrm);

                            EmailMessage.Create(Recipients, EmailSubject, FinalEmailBody, true, CCList, BccList);
                            EmailMessage.AddAttachment(defaulterName + '-Final Defaulter Notice.pdf', 'PDF', ConvertedFile);
                            EmailSend.Send(EmailMessage, Enum::"Email Scenario"::"Demand Notice");
                        end;
                    end;

                    if Recipients.Count > 0 then begin
                        Recipients.RemoveRange(1, 1);
                    end;
                    if BccList.Count > 0 then begin
                        BccList.RemoveRange(1, 1);
                    end;
                    if CCList.Count > 0 then begin
                        CCList.RemoveRange(1, 1);
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Email Notification';
                    field(sendEmail; sendEmail)
                    {
                        Caption = 'Send Email';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

														


    var
    i: Integer;
    AmountToRecover: Decimal;
    ChildElements: Code[20];
    filters: Text;
    defaulterName: Text;
    defaulterEmail: Text;
    EmailSubject: Text;
    EmailBody: Text;
    FinalEmailBody: Text;
    ConvertedFile: Text;
    Filename: Text[200];
    Recipients: List of [text];
    CCList: List of [Text];
    BccList: List of [Text];
    RecRef: RecordRef;
    Outstrm: OutStream;
    InStrm: InStream;
    sendEmail: Boolean;
    EmailScenario: Enum "Email Scenario";
                       emailRecep: Enum "Email Recipient Type";
                       TempBlob: Codeunit "Temp Blob";
                       EmailSend: Codeunit Email;
                       EmailMessage: Codeunit "Email Message";
                       Base64Conversion: Codeunit "Base64 Convert";
                       loansReg: Record "Loans Register";
                       loanGuaranteed: Record "Loans Guarantee Details";
                       cust: Record Customer;
}




