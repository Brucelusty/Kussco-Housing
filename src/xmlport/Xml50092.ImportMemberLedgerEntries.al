xmlport 50092 "Import Member Ledger Entries"
{
    Format = VariableText;
    Direction = Import;
    
    schema
    {
        textelement(Root)
        {
            tableelement("Old_Member_Ledger_Entries";"Old Member Ledger Entries")
            {
                fieldattribute(a; "Old_Member_Ledger_Entries"."Entry No.")
                {}
                fieldattribute(b; "Old_Member_Ledger_Entries"."Member No.")
                {}
                fieldattribute(c; "Old_Member_Ledger_Entries"."Posting Date")
                {}
                fieldattribute(d; "Old_Member_Ledger_Entries".Amount)
                {}
                fieldattribute(e; "Old_Member_Ledger_Entries".Reveresed)
                {}
                fieldattribute(f; "Old_Member_Ledger_Entries".Transaction)
                {}
            }
        }
    }
    
    var
        myInt: Integer;
}
