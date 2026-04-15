tableextension 50037 "Sales Invoice Extension" extends "Sales Header"
{
    fields
    {
        field(50000; "Insurance Claim"; Boolean)
        {
            Caption = 'Insurance Claim';
            DataClassification = ToBeClassified;
        }
        field(50001; "Claim No"; Code[20])
        {
            Caption = 'Claim No';
            DataClassification = ToBeClassified;
        }
    }
}
