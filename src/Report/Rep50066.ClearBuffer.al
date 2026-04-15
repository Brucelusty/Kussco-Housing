report 50066 "ClearBuffer"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Interest Buffer Table"; "Interest Buffer Table")
        {
            column(Loan_No; "Loan No")
            {

            }
            trigger OnAfterGetRecord()
            begin
                buffertable.Reset();
                buffertable.DeleteAll();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout2.rdl';
        }
    }

    var
        myInt: Integer;
        buffertable: Record "Interest Buffer Table";
}
