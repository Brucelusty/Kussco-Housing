tableextension 50036 "Sales Receivables Extension" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Claim Nos"; Code[20])
        {
            Caption = 'Claim No';
            TableRelation = "No. Series".Code;
        }
    }
}
