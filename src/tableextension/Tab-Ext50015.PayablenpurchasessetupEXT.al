//************************************************************************
tableextension 50015 "PayablenpurchasessetupEXT" extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50014; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50015; "Quotation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50016; "Stores Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50017; "Max. Purchase Requisition"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Tender Request No"; Code[10])
        {
            Caption = 'Tender Request No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50019; "Stores Issue No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50020; "Requisition Default Vendor"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /* Vendor.RESET;
                 IF Vendor.GET(xRec."Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=FALSE;
                   Vendor.MODIFY;
                 END;

                  Vendor.RESET;
                  IF Vendor.GET("Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=TRUE;
                   Vendor.MODIFY;
                 END;*/

            end;
        }
        field(50021; "Use Procurement Limits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Inspection Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50000; "No. Of Order Copies"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Copies Print Text"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Text to show on print out';
        }
        field(50002; "LPO Expiry Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Allow Posting to Main Sub"; Boolean)
        {
            Caption = 'Allow Posting to Main Sub';
            DataClassification = ToBeClassified;
        }
        field(50004; "Implementing Partner"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50005; "Study Form Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "Vendor Category Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Vendor Contact Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Vendor Category Entries Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50009; "Proposal Code Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50010; "Start Order from Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Vendor Posting Group"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;
        }
        field(50011; "Default Vendor"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(50012; "Expense Reqisition Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //"Default Vendor"

    }

    var
        myInt: Integer;
}


