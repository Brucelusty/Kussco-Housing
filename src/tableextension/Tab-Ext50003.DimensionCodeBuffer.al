tableextension 50003 "DimensionCodeBuffer" extends "G/L Budget Entry"
{
    fields
    {

        field(50000; "Budget Line Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
         field(50001; "Actual Incurred"; Decimal)
        {
            
           CalcFormula=sum("G/L Entry".Amount where("G/L Account No."=filter('500-00'..'599-99'),"Global Dimension 1 Code"=field("Global Dimension 1 Code"),"Global Dimension 2 Code"=field("Global Dimension 2 Code")));
           FieldClass = FlowField;
           Editable=false;
        }
         field(50002; "Budget Not In Use"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
      
    }




}

