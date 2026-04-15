table 50751 "Temp Transaction Buffer"
{
    DataClassification = ToBeClassified;
    
    // fields
    // {
    //     field(1;"P2F No"; Integer)
    //     {
    //         Editable = false;
    //     }
    //     field(2;"ID No"; Code[20])
    //     {
    //         Editable = false;
    //         trigger OnValidate() begin
    //             // cust.Reset();
    //             // cust.fi
    //         end;
    //     }
    //     field(3;"Member No"; Code[20])
    //     {
    //         Editable = false;
    //     }
    //     field(4; "Date Entered"; Date)
    //     {
    //         Editable = false;
    //         trigger OnValidate() begin
    //             Month := Date2DMY("Date Entered", 2);

    //             p2fBuffer.Reset();
    //             p2fBuffer.SetFilter("P2F No", '<>%1',"P2F No");
    //             p2fBuffer.SetRange("ID No", "ID No");
    //             p2fBuffer.SetRange(Month, Month);
    //             if p2fBuffer.Find('-') = false then begin
    //                 "First Pay of the month":= true;
    //             end else "First Pay of the month" := false;
    //         end;
    //     }
    //     field(5;"Month"; Integer)
    //     {
    //         Editable = false;
    //     }
    //     field(6;"First Pay of the month"; Boolean)
    //     {
    //         Editable = false;
    //     }
    //     field(7;"Amount"; Decimal)
    //     {
    //         Editable = false;
    //     }
    //     field(8;"Employer"; Code[20])
    //     {
    //         Editable = false;
    //     }
    //     field(9;"Payroll No"; Code[20])
    //     {
    //         Editable = false;
    //     }
    //     field(10;"FOSA Account No"; Code[20])
    //     {
    //         Editable = false;
    //     }
    //     field(11;"Member Name"; Text[500])
    //     {
    //         Editable = false;
    //     }
    // }
    
    // keys
    // {
    //     key(Key1; "P2F No")
    //     {
    //         Clustered = true;
    //     }
    // }
    
    // fieldgroups
    // {
    //     // Add changes to field groups here
    // }
    
    // var
    // myInt: Integer;
    // dateCalc: Codeunit "Dates Calculation";
    // p2fBuffer: Record "Pay-to-FOSA Buffer";
    // cust: Record Customer;
    
    // trigger OnInsert()
    // begin
    // end;
    
    // trigger OnModify()
    // begin
        
    // end;
    
    // trigger OnDelete()
    // begin
    //     // Error('You cannot delete');
    // end;
    
    // trigger OnRename()
    // begin
        
    // end;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = CustomerContent;
        }
        field(7; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Running Balance"; Decimal)
        {
            Caption = 'Running Balance';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }
    
}
