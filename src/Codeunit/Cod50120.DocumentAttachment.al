codeunit 50120 DocumentAttachment
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
 
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        HRMeet: Record "Sacco Meetings";
        HREmp: Record "HR Employees";
        HRAppHeader: Record "HR Appraisal Header";
        employers: Record "Employers Register";
        saccoCommittees: Record "Sacco Committees";
        funeralRider: Record "Funeral Rider Processing";
        efts: Record "EFT/RTGS Header";
        pettycashTransactions: Record "Treasury Transactions";

    begin
        case DocumentAttachment."Table ID" of

            //HR Meeting Minutes
            DATABASE::"Sacco Meetings":
                begin
                    RecRef.Open(DATABASE::"Sacco Meetings");
                    if HRMeet.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRMeet);
                end;

            //HR Employees
            DATABASE::"HR Employees":
                begin
                    RecRef.Open(DATABASE::"HR Employees");
                    if HREmp.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(HREmp);
                end;

            //HR Appraisal Header
            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.Open(DATABASE::"HR Appraisal Header");
                    if HRAppHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRAppHeader);
                end;

            //Employers Documents
            DATABASE::"Employers Register":
                begin
                    RecRef.Open(DATABASE::"Employers Register");
                    if employers.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(employers);
                end;
            
            //Sacco Committees
            DATABASE::"Sacco Committees":
                begin
                    RecRef.Open(DATABASE::"Sacco Committees");
                    if saccoCommittees.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(saccoCommittees);
                end;

            //Funeral Rider
            DATABASE::"Funeral Rider Processing":
                begin
                    RecRef.Open(DATABASE::"Funeral Rider Processing");
                    if funeralRider.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(funeralRider);
                end;
            
            //EFT/RTGS
            Database::"EFT/RTGS Header":
                begin
                    RecRef.Open(Database::"EFT/RTGS Header");
                    if efts.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(efts);
                end;

            //EFT/RTGS
            Database::"Treasury Transactions":
                begin
                    RecRef.Open(Database::"Treasury Transactions");
                    if pettycashTransactions.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(pettycashTransactions);
                end;
        end;
    end;
 
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of

            //HR Meeting Minutes
            DATABASE::"Sacco Meetings":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;

            //HR Employees
            DATABASE::"HR Employees":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;

            //HR Appraisal Header
            DATABASE::"HR Appraisal Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            
            //Employers
            DATABASE::"Employers Register":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
                
            //Sacco Committees
            DATABASE::"Sacco Committees":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //Funeral Rider
            DATABASE::"Funeral Rider Processing":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //EFT/RTGS
            DATABASE::"EFT/RTGS Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //EFT/RTGS
            DATABASE::"Treasury Transactions":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;
 
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of

            //HR Meeting Minutes
            DATABASE::"Sacco Meetings":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            //HR Employees
            DATABASE::"HR Employees":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //HR Appraisal Header
            DATABASE::"HR Appraisal Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            
            //Employers
            DATABASE::"Employers Register":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            
            //Sacco Committees
            DATABASE::"Sacco Committees":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            
            //Funeral Rider
            DATABASE::"Funeral Rider Processing":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //EFT/RTGS
            DATABASE::"EFT/RTGS Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            //EFT/RTGS
            DATABASE::"Treasury Transactions":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;
}
