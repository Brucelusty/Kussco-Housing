//************************************************************************
tableextension 50022 "CompanyinfoExt" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Letter_Head; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Motto; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "CEO Signature"; BLOB)
        {
            Caption = 'CEO Signature';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
    }
    var
        myInt: Integer;
        PictureUpdated: Boolean;
}


