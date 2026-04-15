table 50741 "Meeting Allowances"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Doc_No; Code[20])
        {
            Editable = false;
        }
        field(2; "No Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Member No"; Code[20])
        {
            Editable = false;
        }
        field(4; "Month Paid"; Code[20])
        {
            Editable = false;
        }
        field(5; "Amount Paid"; Decimal)
        {
            Editable = false;
        }
        field(6; Defaulter; Boolean)
        {
            Editable = false;
        }
        field(7; Year; Code[20])
        {
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(9; "Meeting No"; Code[20])
        {
            Editable = false;
        }
        field(10; "Member Type"; Option)
        {
            OptionCaption = ' ,Delegate,Board';
            OptionMembers = " ",Delegate,Board;
            Editable = false;
        }
        field(11; "Month No"; Integer)
        {
            Editable = false;
        }
        field(12; Dormant; Boolean)
        {
            Editable = false;
        }
        field(13; "Already Paid"; Boolean)
        {
            Editable = false;
        }
        field(14; "Meeting Type"; Option)
        {
            OptionCaption = ' ,Staff, Board, Delegates, Other';
            OptionMembers = "","Staff Meeting","Board Meeting","Delegates","Other";
            FieldClass = FlowField;
            CalcFormula = lookup("Sacco Meetings"."Meeting Type" where("Meeting No" = field(Doc_No)));
        }
        field(15; Erroneous; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Doc_No, "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        noSeries: Codeunit "No. Series";
        saccoNoSeries: Record "Sacco No. Series";
        cust: Record Customer;
        vend: Record Vendor;
        saccoMeet: Record "Sacco Meetings";
        attendees: Record "Meeting Lines";


    trigger OnInsert()
    begin
        if Doc_No = '' then begin
            saccoNoSeries.Get();
            saccoNoSeries.TestField("Delegate Allowance Nos");
            noSeries.GetNextNo(saccoNoSeries."Delegate Allowance Nos");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
