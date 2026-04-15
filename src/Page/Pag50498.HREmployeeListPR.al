//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50498 "HR Employee-List PR"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employees";
    SourceTableView = sorting("No.")
                      order(ascending)
                      where(Status = filter(Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No.";Rec."No.")
                {
                }
                field("First Name";Rec."First Name")
                {
                }
                field("Last Name";Rec."Last Name")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("Length Of Service";Rec."Length Of Service")
                {
                }
                field("Date Of Join";Rec."Date Of Join")
                {
                }
                field("Search Name";Rec."Search Name")
                {
                }
                field("Postal Address";Rec."Postal Address")
                {
                }
                field("Postal Address2";Rec."Postal Address2")
                {
                }
                field("Postal Address3";Rec."Postal Address3")
                {
                }
                field("Post Code";Rec."Post Code")
                {
                }
                field("Residential Address";Rec."Residential Address")
                {
                }
                field("Residential Address2";Rec."Residential Address2")
                {
                }
                field("Residential Address3";Rec."Residential Address3")
                {
                }
                field("Post Code2";Rec."Post Code2")
                {
                }
                field(City; Rec.City)
                {
                }
                field(County; Rec.County)
                {
                }
                field("Home Phone Number";Rec."Home Phone Number")
                {
                }
                field("Cellular Phone Number";Rec."Cellular Phone Number")
                {
                }
                field("Work Phone Number";Rec."Work Phone Number")
                {
                }
                field("Ext.";Rec."Ext.")
                {
                }
                field("E-Mail";Rec."E-Mail")
                {
                }
                field("ID Number";Rec."ID Number")
                {
                }
                field("Union Code";Rec."Union Code")
                {
                }
                field("UIF Number";Rec."UIF Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Country Code";Rec."Country Code")
                {
                }
                field("Statistics Group Code";Rec."Statistics Group Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Office; Rec.Office)
                {
                }
                field("Resource No.";Rec."Resource No.")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                }
                field("Fax Number";Rec."Fax Number")
                {
                }
                field("Company E-Mail";Rec."Company E-Mail")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Salespers./Purch. Code";Rec."Salespers./Purch. Code")
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Known As";Rec."Known As")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Full / Part Time";Rec."Full / Part Time")
                {
                }
                field("Contract Type";Rec."Contract Type")
                {
                }
                field("Contract End Date";Rec."Contract End Date")
                {
                }
                field("Notice Period";Rec."Notice Period")
                {
                }
                field("Union Member?";Rec."Union Member?")
                {
                }
                field("Shift Worker?";Rec."Shift Worker?")
                {
                }
                field("Contracted Hours";Rec."Contracted Hours")
                {
                }
                field("Pay Period";Rec."Pay Period")
                {
                }
                field("Cost Code";Rec."Cost Code")
                {
                }
                field("UIF Contributor?";Rec."UIF Contributor?")
                {
                }
                field("Marital Status";Rec."Marital Status")
                {
                }
                field("Ethnic Origin";Rec."Ethnic Origin")
                {
                }
                field("First Language (R/W/S)";Rec."First Language (R/W/S)")
                {
                }
                field("Driving Licence";Rec."Driving Licence")
                {
                }
                field("Vehicle Registration Number";Rec."Vehicle Registration Number")
                {
                }
                field(Disabled; Rec.Disabled)
                {
                }
                field("Health Assesment?";Rec."Health Assesment?")
                {
                }
                field("Health Assesment Date";Rec."Health Assesment Date")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field(Age; Rec.Age)
                {
                }
                field("End Of Probation Date";Rec."End Of Probation Date")
                {
                }
                field("Pension Scheme Join";Rec."Pension Scheme Join")
                {
                }
                field("Time Pension Scheme";Rec."Time Pension Scheme")
                {
                }
                field("Medical Scheme Join";Rec."Medical Scheme Join")
                {
                }
                field("Time Medical Scheme";Rec."Time Medical Scheme")
                {
                }
                field("Date Of Leaving";Rec."Date Of Leaving")
                {
                }
                field(Paterson; Rec.Paterson)
                {
                }
                field(Peromnes; Rec.Peromnes)
                {
                }
                field(Hay; Rec.Hay)
                {
                }
                field(Castellion; Rec.Castellion)
                {
                }
                field("Allow Overtime";Rec."Allow Overtime")
                {
                }
                field("Medical Scheme No.";Rec."Medical Scheme No.")
                {
                }
                field("Medical Scheme Head Member";Rec."Medical Scheme Head Member")
                {
                }
                field("Number Of Dependants";Rec."Number Of Dependants")
                {
                }
                field("Medical Scheme Name";Rec."Medical Scheme Name")
                {
                }
                field("Receiving Car Allowance ?";Rec."Receiving Car Allowance ?")
                {
                }
                field("Second Language (R/W/S)";Rec."Second Language (R/W/S)")
                {
                }
                field("Additional Language";Rec."Additional Language")
                {
                }
                field("Cell Phone Reimbursement?";Rec."Cell Phone Reimbursement?")
                {
                }
                field("Amount Reimbursed";Rec."Amount Reimbursed")
                {
                }
                field("UIF Country";Rec."UIF Country")
                {
                }
                field("Direct/Indirect";Rec."Direct/Indirect")
                {
                }
                field("Primary Skills Category";Rec."Primary Skills Category")
                {
                }
                field(Level; Rec.Level)
                {
                }
                field("Termination Category";Rec."Termination Category")
                {
                }
                field("Job Specification";Rec."Job Specification")
                {
                }
                field(DateOfBirth; Rec.DateOfBirth)
                {
                }
                field(DateEngaged; Rec.DateEngaged)
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Name Of Manager";Rec."Name Of Manager")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Disabling Details";Rec."Disabling Details")
                {
                }
                field("Disability Grade";Rec."Disability Grade")
                {
                }
                field("Passport Number";Rec."Passport Number")
                {
                }
                field("2nd Skills Category";Rec."2nd Skills Category")
                {
                }
                field("3rd Skills Category";Rec."3rd Skills Category")
                {
                }
                field(PensionJoin; Rec.PensionJoin)
                {
                }
                field(DateLeaving; Rec.DateLeaving)
                {
                }
                field(Region; Rec.Region)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*
        IF (DepCode <> '') THEN
           SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
           SETFILTER(Office, ' = %1', OfficeCode);
             */

    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];


    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}






