tableextension 50031 "PoBankAccReconciliationLine" extends "Bank Account Statement Line"
{
    fields
    {
        field(50000;Reconciled;Boolean)
        {
        }
        field(50007; "Payee Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Cash Book Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Cash In"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Entry No"; Integer)
        {
            Editable = false;

        }
        field(50004;"Open Type";Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005;Imported;Boolean)
        {
            Description = 'Imported from bank statement, not suggested';
        }
        field(50011;"Reconciling Date";Date)
        {
        }
        field(50012; "Debit"; Decimal)
        {

        }
        field(50013; "Credit"; Decimal)
        {

        }
    }

    var
        myInt: Integer;
}
