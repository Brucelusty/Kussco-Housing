report 50639 "EFT Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = EFTSlip;
    
    dataset
    {
        dataitem("EFT/RTGS Header";"EFT/RTGS Header")
        {
            column(No;No)
            {}
            column(Reason_for_EFT_RTGS;"Reason for EFT/RTGS")
            {}
            column(Transaction_Description;"Transaction Description")
            {}
            column(Expected_Amount;"Expected Amount")
            {}
            column(eftAccount;eftAccount)
            {}
            column(eftAccName;eftAccName)
            {}
            column(Cheque_No;"Cheque No")
            {}
            // column()
            // {}
            column(companyInfo_Name;companyInfo.Name)
            {}
            column(companyInfo_Picture;companyInfo.Picture)
            {}

            trigger OnAfterGetRecord() begin
                eftLines.Reset();
                eftLines.SetRange("Header No", "EFT/RTGS Header".No);
                if eftLines.Find('-') then begin
                    eftAccount := eftLines."Account No";
                    eftAccName := eftLines."Account Name";
                end;
            end;
        }
    }
    
    
    rendering
    {
        layout(EFTSlip)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/EFTPaymentSlip.rdlc';
        }
    }

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture, "CEO Signature");
    end;

    var
    myInt: Integer;
    eftAccount: Code[20];
    eftAccName: Code[20];
    companyInfo: Record "Company Information";
    eftLines: Record "EFT/RTGS Details";
}
