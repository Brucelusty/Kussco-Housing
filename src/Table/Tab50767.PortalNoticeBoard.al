table 50767 "Portal Notice Board"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(2; "Upload Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,File,Text';
            OptionMembers = " ","Upload File","Upload Text";
        }
        field(3; "Visibile To"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,All Members,Delegate Members,Board Members,Staff Members';
            OptionMembers = " ","All Members","Delegate Members","Board Members","Staff Members";
        }
        field(4; "Upload Title"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Upload Description"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Text Message"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Upload Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New,Pending,Approved,Rejected,';
            OptionMembers = " ",New,Pending,Approved,Rejected;
            InitValue = New;
        }
        field(8; Uploaded; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Uploaded By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Upload Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Upload Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Removed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Removed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Removal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Removal Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Image Upload"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(17; "File Upload"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "File Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "File Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Effective Date" < Today then Error('This upload cannot be effective from the past');

                "Effective Year" := Date2DMY("Effective Date", 3);
            end;
        }
        field(21; "Effective Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        // field(;""; )
        // {
        //     DataClassification = ToBeClassified;
        // }
    }

    keys
    {
        key(Key1; "Entry No.")
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
        setup: Record "Sacco No. Series";
        noSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "Entry No." = '' then begin
            setup.Get();
            setup.TestField("Sacco Correspondence Nos");
            "Entry No." := noSeries.GetNextNo(setup."Sacco Correspondence Nos", Today, true);
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
