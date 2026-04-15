//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50258 "Membership Cue"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {


            cuegroup(Members)
            {
                field("Active Members"; Rec."Active Members")
                {
                    Image = People;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Dormant Members"; Rec."Dormant Members")
                {
                    Image = People;
                    DrillDownPageId = "Members List";

                }
                field("Retired"; Rec."Non-Active Members")
                {
                    Image = People;
                    Caption = 'Retired Members';
                    Style = Attention;
                    StyleExpr = true;
                    Visible = false;
                    DrillDownPageId = "Members List";


                }
                field("Deceased Members"; Rec."Deceased Members")
                {
                    Image = People;
                    DrillDownPageId = "Members List";
                    Visible = false;

                }
                field("Withdrawn Members"; Rec."Withdrawn Members")
                {
                    Image = People;
                    DrillDownPageId = "Members List";
                    Visible = false;

                }
                field("Closed Members"; Rec."Closed Members")
                {
                    Image = People;
                    Style = Unfavorable;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Non-Members";Rec."Non-Members")
                {
                    Image = People;
                    Style = Subordinate;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }

            }
            cuegroup("Account Categories")
            {
                field("Female Members"; Rec."Female Members")
                {
                    Image = "None";
                    DrillDownPageId = "Members List";

                }
                field("Male Members"; Rec."Male Members")
                {
                    Image = "None";
                    DrillDownPageId = "Members List";


                }
                field("Junior Members"; Rec."Junior Members")
                {
                    Image = Library;
                    DrillDownPageId = "Members List";
                }
            }
            cuegroup(Loans)
            {
                Caption = 'Member Transaction analysis';
                Visible=false;
                field("Jipange Balance"; Rec."Jipange Balance")
                {
                    Caption='Ordinary Account';


                }
                field("Fixed deposit Balance"; Rec."Fixed deposit Balance")
                {


                }
                field("HOLIDAY Account Balance"; Rec."HOLIDAY Account Balance")
                {


                }

                field("Share Capital Balance"; Rec."Share Capital Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("Deposit Contribution Balance"; Rec."Deposit Contribution Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("BBF Fund Balance"; Rec."BBF Fund Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }

                field("Loan Book Balance"; Rec."Loan Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("BOSA_SUPER-Book Balance"; Rec."BOSA_SUPER-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("BOSA_SUPER II-Book Balance"; Rec."BOSA_SUPER II-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("DEFAULT-Book Balance"; Rec."DEFAULT-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("DEVELOPMENT_LOAN-Book Balance"; Rec."DEVELOPMENT_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("DEVELOPMENT_LOAN 2-Book Balance"; Rec."DEVELOPMENT_LOAN 2-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("DEVELOPMENT_LOAN III-Book Balance"; Rec."DEVELOPMENT_LOAN III-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("DIVIDEND_ADVANCE-Book Balance"; Rec."DIVIDEND_ADVANCE-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("EMERGENCY_LOAN-Book Balance"; Rec."EMERGENCY_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("EMERGENCY_LOAN 2-Book Balance"; Rec."EMERGENCY_LOAN 2-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("FIT FOSA-Book Balance"; Rec."FIT FOSA-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("HIFADHI_LOAN-Book Balance"; Rec."HIFADHI_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("HIFADHI_LOAN II-Book Balance"; Rec."HIFADHI_LOAN II-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("KARIBU LOAN-Book Balance"; Rec."KARIBU LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("M-BANKING ADVANCE-Book Balance"; Rec."M-BANKING ADVANCE-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("MEGA_LOAN-Book Balance"; Rec."MEGA_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("MEGA_LOAN II-Book Balance"; Rec."MEGA_LOAN II-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("OKOA_LOAN-Book Balance"; Rec."OKOA_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("ONE_MONTH-Book Balance"; Rec."ONE_MONTH-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("P.O.A_LOAN-Book Balance"; Rec."P.O.A_LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SAFARICOM FOSA LOAN-Book Balance"; Rec."SAFARICOM FOSA LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SAFARICOM_FOSA-Book Balance"; Rec."SAFARICOM_FOSA-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SALARY IN ADVANCE-Book Balance"; Rec."SALARY IN ADVANCE-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SCHOOL_FEES-Book Balance"; Rec."SCHOOL_FEES-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SCHOOL_FEES 2-Book Balance"; Rec."SCHOOL_FEES 2-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SHAMBA LOAN-Book Balance"; Rec."SHAMBA LOAN-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("SIX_MONTHS-Book Balance"; Rec."SIX_MONTHS-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("STAFF_LOAN 2-Book Balance"; Rec."STAFF_LOAN 2-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }
                field("THREE MONTHS ADVANCE-Book Balance"; Rec."THREE MONTHS ADVANCE-Book Balance")
                {
                    DrillDownPageID = "Detailed Cust. Ledg. Entries";
                    Image = "None";
                    LookupPageID = "Detailed Cust. Ledg. Entries";
                }

            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}






