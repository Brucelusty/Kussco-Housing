report 50665 "Change of Status"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/ChangeOfStatus.rdlc';
    
    dataset
    {
        dataitem("Change Request";"Change Request")
        {
            column(No;No)
            { 
            }
            
        }
    }
    
 
        
    var
        myInt: Integer;
}


