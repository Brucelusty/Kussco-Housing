report 50739 "Funeral Rider Payment Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = Funeral;

    dataset
    {
        dataitem("Funeral Rider Processing";"Funeral Rider Processing")
        {
            RequestFilterFields = "FR No.";
            column(FR_No_;"FR No.")
            {}
            column(Deceased;Deceased)
            {}
            column(Member_No_;"Member No.")
            {}
            column(funeralExpenseAcc;funeralExpenseAcc)
            {}
            column(Member_FOSA_Account;"Member FOSA Account")
            {}
            column(funeralRider;funeralRider)
            {}
            column(Member_Name;"Member Name")
            {}
            column(Member_Deceased;"Member Deceased")
            {}
            column(Next_of_Kin_Deceased;"Next of Kin Deceased")
            {}
            column(NoK_is_Member;"NoK is Member")
            {}
            column(NoK_Member_No_;"NoK Member No.")
            {}
            column(Paid_By;"Paid By")
            {}
            column(Paid_On;"Paid On")
            {}
            column(Has_BBF_Contributions;"Has BBF Contributions")
            {}
            column(NoK_BBF;"NoK BBF")
            {}
            column(Captured_By;"Captured By")
            {}
            column(Captured_On;"Captured On")
            {}
            column(Approved_By;"Approved By")
            {}
            column(Approved_On;"Approved On")
            {}
            // column()
            // {}
            column(company_Pic; company.Picture)
            { }
            column(company_Name; company.Name)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Phone; company."Phone No.")
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Motto; company.Motto)
            { }
            trigger OnAfterGetRecord()
            begin
                if "Funeral Rider Processing"."Has BBF Contributions" = false then begin
                    funeralRider := 0;
                    if "Funeral Rider Processing"."NoK is Member" = true then begin
                        if "Funeral Rider Processing"."NoK BBF" = false then begin
                            funeralRider := 0;
                        end else
                        funeralRider := funeralRider * 2;
                    end else funeralRider := funeralRider;
                end
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

                }
            }
        }
    }

    rendering
    {
        layout(Funeral)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/FuneralRiderPaymentSlip.rdlc';
        }
    }
    trigger OnInitReport()
    begin
        funeralRider := 0;
        company.Get();
        saccoGen.Get();
        company.CalcFields(Picture);
        funeralRider := saccoGen."Funeral Expense Amount";
        funeralExpenseAcc := saccoGen."Funeral Expenses Account";
    end;

    var
        number: Integer;
        funeralRider: Decimal;
        totalRefund: Decimal;
        currentLiability: Decimal;
        totalLoans: Decimal;
        multipliedDeposits: Decimal;
        depMulti: Integer;
        regDate: Date;
        noticeDate: Date;
        matureDate: Date;
        reasonExit: Text[500];
        burialPermit: Code[50];
        funeralExpenseAcc: Code[20];
        saccoGen: Record "Sacco General Set-Up";
        company: Record "Company Information";
        withNotice: Record "Withdrawal Notice";
}
