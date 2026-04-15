report 50754 "SMS not Charged"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = SMSnotCharged;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Account Type" = filter('103'));
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(BOSA_Account_No;"BOSA Account No")
            {}
            column(Personal_No_;"Personal No.")
            {}
            column(Balance;Balance)
            {}
            column(availableBal;availableBal)
            {}
            column(totalCharges;totalCharges)
            {}
            // column()
            // {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
            trigger OnPreDataItem() begin
                FnInitializeJournal();
            end;

            trigger OnAfterGetRecord() begin
                totalCharges:= 0;
                availableBal:= 0;
                vend.Reset();
                vend.SetRange("No.", Vendor."No.");
                if vend.Find('-') then begin
                    availableBal:= vend.GetAvailableBalance();

                    smsMessage.Reset();
                    smsMessage.SetRange("Account To Charge", vend."No.");
                    smsMessage.SetRange("Charge Member", true);
                    smsMessage.SetFilter(msg_category, '<>%1','CRM');
                    smsMessage.SetFilter("SMS Date", '<%1', 20240829D);
                    if smsMessage.FindSet() then begin
                        repeat
                            docNo:= 'SMS-'+smsMessage.receiver;
                            //Debit FOSA A/C SMS Charge
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
                            GenJournalLine."Account Type"::Vendor, vend."No.", smsMessage."SMS Date", smsCharge, '', 'SMS Charge', '');
                            //Credit SMS Charges A/C
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
                            GenJournalLine."Account Type"::"G/L Account", smsChargeAC, smsMessage."SMS Date", smsCharge*-1, '', 'SMS Charge', '');
                            //Debit FOSA A/C Excise Duty
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
                            GenJournalLine."Account Type"::Vendor, vend."No.", smsMessage."SMS Date", exciseDuty, '', 'Excise Duty on SMS Charge', '');
                            //Credit Excise Duty A/c
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
                            GenJournalLine."Account Type"::"G/L Account", exciseDutyAC, smsMessage."SMS Date", exciseDuty*-1, '', 'Excise Duty on SMS Charge', '');

                            totalCharges:= totalCharges + smsCharges;
                        until smsMessage.Next() = 0;
                    end else CurrReport.Skip();
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
                    field(refDate;refDate)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(SMSnotCharged)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/AccountsnotChargedSMS.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);

        smsCharges:= 0;
        saccoGensetup.Get();
        smsCharges:= saccoGensetup."SMS Fee Amount" + (saccoGensetup."SMS Fee Amount" *(saccoGensetup."Excise Duty(%)")/100);

    end;
    
    var
    myInt: Integer;
    lineNo: Integer;
    smsCharge: Decimal;
    exciseDuty: Decimal;
    refDate: Date;
    availableBal: Decimal;
    smsCharges: Decimal;
    totalCharges: Decimal;
    docNo: Code[20];
    batchName: Code[20];
    batchTemplate: Code[20];
    smsChargeAC: Code[20];
    exciseDutyAC: Code[20];
    AUFactory: Codeunit "Au Factory";
    chargeSMS: Codeunit "Charge SMS";
    company: Record "Company Information";
    smsMessage: Record "AU SMS Messages";
    saccoGensetup: Record "Sacco General Set-Up";
    vend: Record Vendor;
    cust: Record Customer;
    detVend: Record "Detailed Vendor Ledg. Entry";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";

    local procedure FnInitializeJournal()
    var
        myInt: Integer;
    begin
        smsCharge:= 0;
        exciseDuty:= 0;
        smsChargeAC:= '';
        exciseDutyAC:= '';
        docNo := '';
        batchTemplate := 'GENERAL';
        batchName := 'OLDSMS';
        lineNo := 0;

        saccoGenSetup.Get();
        smsCharge:= saccoGenSetup."SMS Fee Amount";
        smsChargeAC:= saccoGenSetup."SMS Fee Account";
        exciseDuty:= (smsCharge)* (saccoGenSetup."Excise Duty(%)"/100);
        exciseDutyAC:= saccoGenSetup."Excise Duty Account";

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", batchName);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", batchTemplate);
        GenBatches.SetRange(Name, batchName);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init();
            GenBatches."Journal Template Name" := batchTemplate;
            GenBatches.Name := batchName;
            GenBatches.Description := 'Uncharged SMS Charges';
            GenBatches.Insert();
        end;
    end;
}



