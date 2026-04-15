report 50708 "Generate Interest on Savings"
{
    ApplicationArea = All;
  UsageCategory = ReportsAndAnalysis;
  ProcessingOnly = true;
  
  dataset
  {
    dataitem(Vendor;Vendor)
    {
      DataItemTableView = where("Creditor Type" = filter("FOSA Account"));
      RequestFilterFields = "No.", "Account Type";
      column(No_;"No.")
      {}
      trigger OnPreDataItem() begin
        intOnSav.Reset();
        intOnSav.SetRange(Posted, false);
        if intOnSav.FindSet() then begin
          intOnSav.DeleteAll();
        end;
      end;
      trigger OnAfterGetRecord() begin
        monthlyInterest := 0;
        monthlySavings := 0;
        totalInterest := 0;
        fosaBal := 0;
        withdrawals := 0;
        withdrawalCount := 0;

        if (startDate = 0D) or (endDate = 0D) then CurrReport.Skip();

        if accType.Get(Vendor."Account Type") then begin
          if accType."Earns Interest" = true then begin
            detVend.Reset();
            detVend.SetRange("Vendor No.", Vendor."No.");
            detVend.SetFilter("Posting Date",'..%1', endDate);
            detVend.SetRange(Reversed, false);
            if detVend.FindSet() then begin
              detVend.CalcSums("Amount");
              fosaBal:= (detVend."Amount") * -1;
              // repeat
              //   fosaBal := fosaBal + detVend."Credit Amount";
              //   withdrawals := withdrawals + detVend."Debit Amount";
              // until detVend.Next()=0;
            end else fosaBal := 0;
            detVend.Reset();
            detVend.SetRange("Vendor No.", Vendor."No.");
            detVend.SetFilter("Posting Date",'%1..%2',startYear, endDate);
            detVend.SetFilter("Debit Amount",'>%1',0);
            detVend.SetRange(Reversed, false);
            if detVend.FindSet() then begin
              repeat
                withdrawalCount := withdrawalCount + 1;
              until detVend.Next()=0;
            end;

            if accType."Allowable Withdrawals" < withdrawalCount then CurrReport.Skip();
            firstInt := 0;
            secondInt := 0;
            thirdInt := 0;

            for i := refNo downto 1 do begin
              if fosaBal >= accType."Interest Calc Min Balance" then begin
                detVend.Reset();
                detVend.SetRange("Vendor No.", Vendor."No.");
                detVend.SetRange(Reversed, false);
                detVend.SetFilter("Posting Date", '%1..%2', startingDate[i], endingDate[i]);
                if detVend.FindSet() then begin
                  detVend.CalcSums(Amount);
                  monthlySavings := (detVend.Amount)*-1;
                end;
                if monthlySavings >= 1 then begin
                  monthlyInterest:= (((monthlySavings + monthlyInterest)*(accType."Interest Rate"/100))/12);
                  // totalInterest := totalInterest + monthlyInterest;
                  
                  if i = 3 then begin
                    // firstInt := totalInterest;
                    firstInt := monthlyInterest;
                  end else if i = 2 then begin
                    // secondInt := totalInterest;
                    secondInt := monthlyInterest;
                  end else if i = 1 then begin
                    // thirdInt := totalInterest;
                    thirdInt := monthlyInterest;
                  end;
                end else totalInterest := 0;
              end;
              // fosaBal := fosaBal + monthlySavings;
            end;

            totalInterest := firstInt + secondInt + thirdInt;

            if totalInterest <> 0 then begin
              intOnSav.Init();
              intOnSav."FOSA Account" := Vendor."No.";
              intOnSav.Date := Today;
              intOnSav."Start Date" := startDate;
              intOnSav."End Date" := endDate;
              intOnSav."Member No" := Vendor."BOSA Account No";
              intOnSav."Account Type" := Vendor."Account Type";
              intOnSav."Account Type Name" := accType.Description;
              intOnSav."FOSA Balance" := fosaBal;
              intOnSav."Member Name" := Vendor.Name;
              intOnSav."PF No" := Vendor."Personal No.";
              intOnSav."Gross Interest" := totalInterest;
              intOnSav."First Interest" := firstInt;
              intOnSav."Second Interest" := secondInt;
              intOnSav."Third Interest" := thirdInt;
              if (Date2DMY(startDate, 2) = 1) then begin
                intOnSav.Period := intOnSav.Period::"Jan-Mar";
              end else if (Date2DMY(startDate, 2) = 4) then begin
                intOnSav.Period := intOnSav.Period::"Apr-Jun"
              end else if (Date2DMY(startDate, 2) = 7) then begin
                intOnSav.Period := intOnSav.Period::"Jul-Sep"
              end else if (Date2DMY(startDate, 2) = 10) then begin
                intOnSav.Period := intOnSav.Period::"Oct-Dec";
              end;
              intOnSav.Year := Format(Date2DMY(startDate, 3));
              if not intOnSav.insert then intOnSav.modify;
            end;
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
          field("Start Date"; startDate)
          {
                    ApplicationArea = All;
            ShowMandatory = true;
            trigger OnValidate() begin
              startDate := CalcDate('<-CM>',startDate);
              converted:= Evaluate(refNo, (DelChr(Format(interestCalcMonths), '=', 'M')));
              // if converted then Message('Ref No %1', refNo);

              startingDay := startDate;
              for j := refNo downto 1 do begin
                startingDate[j] := startingDay;
                endingDate[j] := CalcDate('<CM>', startingDay);
                startingDay := CalcDate('<1M>', startingDay);
                // Message('Starting Date: %1, Ending Date: %2', startingDate[j], endingDate[j]);
              end;
              endDate:= endingDate[1];
              // Message('Start Date: %1, End Date: %2', startDate, endDate);
            end;
          }
          field("End Date"; endDate)
          {
                    ApplicationArea = All;
            ShowMandatory = true;
            Editable = false;
          }
        }
      }
    }
  }
  trigger OnInitReport()
  begin
    saccoGenSetup.Get();
    interestCalcMonths := saccoGenSetup."Int Calc Intervals";
    intAcc := saccoGenSetup."Interest on FOSA A/C";

    startYear:= CalcDate('<-CY>', Today);
    endYear:= CalcDate('<CY>', Today);
    // Message('Start Year: %1, End Year: %2', startYear, endYear);
  end;
  
  var
  converted: Boolean;
  myInt: Integer;
  i: Integer;
  j: Integer;
  refNo: Integer;
  withdrawalCount: Integer;
  firstInt: Decimal;
  secondInt: Decimal;
  thirdInt: Decimal;
  monthlyInterest: Decimal;
  totalInterest: Decimal;
  fosaBal: Decimal;
  withdrawals: Decimal;
  monthlySavings: Decimal;
  docNo: Code[30];
  batchName: Code[20];
  batchTemplate: Code[20];
  intAcc: Code[20];
  date: Date;
  startingDay: Date;
  startDate: Date;
  endDate: Date;
  startYear: Date;
  endYear: Date;
  startMonth: array[3] of Date;
  endMonth: array[3] of Date;
  startingDate: array[3] of Date;
  endingDate: array[3] of Date;
  interestCalcMonths: DateFormula;
  AUFactory: Codeunit "Au Factory";
  vend: Record Vendor;
  cust: Record Customer;
  intOnSav: Record "Interest On Savings Prog";
  detVend: Record "Detailed Vendor Ledg. Entry";
  accType: Record "Account Types-Saving Products";
  saccoGenSetup: Record "Sacco General Set-Up";
  GenBatches: Record "Gen. Journal Batch";
  GenJournalLine: Record "Gen. Journal Line";
}



