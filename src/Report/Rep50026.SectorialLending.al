report 50026 "Sectorial Lending"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = 'Layouts/SectorialLending.rdlc';
    DefaultLayout = RDLC;
    //DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Main Sector"; "Main Sector")
        {
            column(Code; Code)
            {

            }
            column(Description; Description) { }
            dataitem("Sub Sector"; "Sub Sector")
            {
                DataItemLink = "Main Sector" = field(Code);
                column(CodeSub; Code) { }
                column(DescriptionSub; Description) { }
                column(Nosub; No) { }
                dataitem("Specific Sector"; "Specific Sector")
                {
                    DataItemLink = "Sub-Sector" = field(Code);
                    column(CodeSpecific; Code) { }
                    column(DescriptionSpecific; Description) { }
                    column(No; No) { }
                    column(Amount; Amount) { }
                    column(OffsetAmount; OffsetAmount) { }

                    column(LoansAmount; LoansAmount) { }

                    trigger OnAfterGetRecord()
                    var
                        Offsetdetails: record "Loans register";

                    begin
                        OffsetAmount := 0;
                        Offsetdetails.Reset();
                        Offsetdetails.SetRange(Offsetdetails.Posted, True);
                        Offsetdetails.SetRange(Offsetdetails.Reversed, false);
                        Offsetdetails.SetRange(Offsetdetails."Sector Specific", "Specific Sector".Code);
                        Offsetdetails.SetFilter(Offsetdetails."Issued Date", '%1..%2', QuarterStart, QuarterEnd);
                        if Offsetdetails.FindSet() then begin
                            repeat
                                Offsetdetails.CalcFields(Offsetdetails."Top Up Amount");
                                //TopUp Amount similar to the topup amount on the disbursed by product rep.
                                //Should it capture outstanding bal alone instead?
                                OffsetAmount := OffsetAmount + Offsetdetails."Top Up Amount";
                            until Offsetdetails.Next() = 0;
                        end;


                        LoansAmount := 0;
                        Offsetdetails.Reset();
                        Offsetdetails.SetRange(Offsetdetails.Posted, True);
                        // Offsetdetails.SetAutoCalcFields(Offsetdetails.Reversed);
                        Offsetdetails.SetRange(Offsetdetails.Reversed, false);
                        Offsetdetails.SetRange(Offsetdetails."Sector Specific", "Specific Sector".Code);
                        Offsetdetails.SetFilter(Offsetdetails."Issued Date", '%1..%2', QuarterStart, QuarterEnd);
                        if Offsetdetails.FindSet() then begin
                            repeat
                                LoansAmount := LoansAmount + Offsetdetails."Approved Amount";
                            until Offsetdetails.Next() = 0;
                        end;
                    end;
                }
            }
        }
    }

    requestpage
    {
        layout
        {

            area(Content)
            {
                group(GroupName)
                {
                    field(QuarterStart; QuarterStart)
                    {
                        ApplicationArea = All;
                    }

                    field(QuarterEnd; QuarterEnd)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }



    var
        myInt: Integer;
        OffsetAmount: decimal;

        QuarterStart: Date;

        QuarterEnd: Date;

        LoansAmount: Decimal;
}


