report 50777 "Member Deposit Refund Progress"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // ProcessingOnly = true;
    DefaultRenderingLayout = MemberOngoingRefunds;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where(IsNormalMember = filter(true));
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Current_Shares;"Current Shares")
            {}
            column(School_Fees_Shares;"School Fees Shares")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Mobile_Phone_No;"Mobile Phone No")
            {}
            column(E_Mail;"E-Mail")
            {}
            column(regDate;regDate)
            {}
            column(noticeDate;noticeDate)
            {}
            column(essBal;essBal)
            {}
            column(depositsBal;depositsBal)
            {}
            column(DocNo;DocNo)
            {}
            column(depositType;depositType)
            {}
            column(notPaid;notPaid)
            {}
            column(partial;partial)
            {}
            column(full;full)
            {}
            // column()
            // {}
            column(companyInfo_Name;companyInfo.Name)
            {}
            column(companyInfo_Pic;companyInfo.Picture)
            {}
            column(companyInfo_Address;companyInfo.Address)
            {}
            column(companyInfo_Motto;companyInfo.Motto)
            {}

            trigger OnPreDataItem()
            begin
                if depositType = depositType::" " then begin
                    depositType := depositType::Deposits;
                end;
            end;

            trigger OnAfterGetRecord() begin
                partial := false;
                full := false;
                notPaid := false;
                
                depositsBal := 0;
                essBal := 0;
                DocNo := '';
                if Customer."Current Shares" <= 0 then begin
                    CurrReport.Skip();
                end;
                
                exits.Reset();
                exits.SetRange("Member No", Customer."No.");
                exits.SetFilter("Notice Status", '%1|%2', exits."Notice Status"::Registered, exits."Notice Status"::Matured);
                if exits.Find('-') = false then begin
                    CurrReport.Skip();
                end else begin
                    exits.CalcFields("ESS Shares", "Current Shares", "Loan Balance");
                    
                    depositsBal := Customer."Current Shares";
                    essBal := Customer."School Fees Shares";
                    noticeDate := exits."Notice Date";
                    regDate := exits."Registration Date";
                    if regDate = 0D then begin
                        regDate := noticeDate
                    end;
                    DocNo := exits."No.";

                    exitPayments.Reset();
                    exitPayments.SetRange("Notice No", DocNo);
                    exitPayments.SetFilter("Refunded On", '<>%1', 0D);
                    if exitPayments.Find('-') then begin
                        if (exitPayments."Total Refund" > 0) and not (exitPayments."Fully Paid") and (exitPayments.Remainder = 0) then begin
                            notPaid := true;
                        end;
                        if (exitPayments.Remainder > 0) then begin
                            partial := true;
                        end;
                        if exitPayments."Fully Paid" then begin
                            full := true;
                        end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                // group("Type of Deposit")
                // {
                //     field(depositType;depositType)
                //     {
                //         Caption = 'Deposit Type';
                //         ShowMandatory = true;

                //         trigger OnValidate()
                //         begin

                //         end;
                //     }
                // }
            }
        }
    }
    
    rendering
    {
        layout(MemberOngoingRefunds)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MemberOngoingRefunds.rdlc';
        }
    }
    

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture, "CEO Signature");
    end;
    
    var
        myInt: Integer;
        depositsBal: Decimal;
        essBal: Decimal;
        notPaid: Boolean;
        partial: Boolean;
        full: Boolean;
        DocNo: Code[20];
        regDate: Date;
        noticeDate: Date;
        depositType: Option " ",Deposits,ESS;
        AUFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
        cust: Record Customer;
        vend: Record Vendor;
        exitPayments: Record "Membership Exist";
        exits: Record "Withdrawal Notice";
        essRefund: Record "ESS Refund";
        companyInfo: Record "Company Information";
}


