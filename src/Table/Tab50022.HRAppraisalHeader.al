Table 50022 "HR Appraisal Header"
{

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PerformanceSetup.Get;
                    NoSeriesMgt.TestManual(PerformanceSetup."Performance Numbers");
                    "No. series" := '';
                end;
            end;
        }
        field(2; "Supervisor User ID"; Code[200])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3; "Appraisal Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Appraisal Periods".Code;
        }
        field(5; "Appraisal Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Appraisee,Supervisor,Others';
            OptionMembers = Appraisee,Supervisor,Others;
        }
        field(6; Recommendations; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Appraisal Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Target Setting","Achieved Target","Target Approval","Supervisor Evaluation","Appraisal Completed";

            trigger OnValidate()
            begin
                if "Appraisal Stage" = "Appraisal Stage"::"Achieved Target" then begin
                    // HREmp.Reset();
                    // HREmp.SetRange("User Id", UserId);
                    // if HREmp.Find('-') then begin

                    //     "Employee No." := HREmp."No.";
                    //     "Employee Name" := HREmp.FullName();
                    //     "User ID" := HREmp."User ID";
                    //     Manager := true;

                    //     TargetSeries := 0;
                    //     TargetLines.Reset;
                    //     TargetLines.SetRange("Department Code", HREmp."Responsibility Center");
                    //     if TargetLines.FindFirst then begin
                    //         repeat
                    //             TargetSeries := TargetSeries + 1;
                    //             AppraissalLinesWP.Init;
                    //             AppraissalLinesWP."Appraisal No." := TargetSeries;
                    //             AppraissalLinesWP."Key Value Driver" := TargetLines."Parent KVD";
                    //             AppraissalLinesWP."Key Performance Indicator" := TargetLines.KPI;
                    //             AppraissalLinesWP."Agreed Performance Targets" := TargetLines."KPI Target";
                    //             AppraissalLinesWP.Weight := TargetLines.Weight;
                    //             AppraissalLinesWP."Header No" := "No.";
                    //             AppraissalLinesWP.Insert(true);
                    //         until TargetLines.Next = 0;
                    //     end;

                    //     ValueSeries := 0;
                    //     StaffValues.Reset;
                    //     if StaffValues.FindFirst then begin
                    //         repeat
                    //             ValueSeries := ValueSeries + 1;
                    //             AppraisalLinesValues.Init;
                    //             AppraisalLinesValues."Appraisal No." := ValueSeries;
                    //             AppraisalLinesValues."Header No" := "No.";
                    //             AppraisalLinesValues.Values := StaffValues.Value;
                    //             AppraisalLinesValues.Description := StaffValues.Description;
                    //             AppraisalLinesValues."Target Score" := StaffValues.Weight;
                    //             AppraisalLinesValues.Insert(true);
                    //         until StaffValues.Next = 0;
                    //     end;

                    //     HREmpCopy.Reset();
                    //     HREmpCopy.SetRange("User ID", HREmp."Supervisor ID");
                    //     if HREmpCopy.Find('-') then begin
                    //         "Supervisor User ID" := HREmpCopy."User ID";
                    //         "Supervisor No." := HREmpCopy."No.";
                    //         "Supervisor Name" := HREmpCopy.FullName();
                    //     end;
                    // end;
                end;
            end;
        }
        field(9; Sent; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisee,Supervisor,Completed,Rated';
            OptionMembers = Appraisee,Supervisor,Completed,Rated;
        }
        field(10; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(11; Picture; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(12; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
            TableRelation = if ("Appraisal Stage" = filter("Target Setting")) "HR Employees"."No." where("Supervisor ID" = field("Supervisor User Id"))
            else
            if ("Appraisal Stage" = filter("Achieved Target")) "HR Employees"."No." where("Supervisor" = filter(true));

            trigger OnValidate()
            begin
                // HREmp.SetRange(HREmp."No.", "Employee No.");
                // if HREmp.FindFirst() then begin
                //     "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                //     "Department Code" := HREmp."Global Dimension 2 Code";
                //     "Supervisor No." := HREmp."Manager Emp No";
                //     "User ID" := UserId;
                //     "Supervisor User ID" := HREmp."Supervisor ID";
                // end;

                // TargetSeries := 0;
                // TargetLines.Reset;
                // TargetLines.SetRange(TargetLines.Period, "Appraisal Period");
                // TargetLines.SetRange(TargetLines."Staff No", "Employee No.");
                // if TargetLines.FindFirst then begin
                //     repeat
                //         TargetSeries := TargetSeries + 1;
                //         AppraissalLinesWP.Init;
                //         AppraissalLinesWP."Appraisal No." := TargetSeries;
                //         AppraissalLinesWP."Key Value Driver" := TargetLines."Key Value Drivers";
                //         AppraissalLinesWP."Key Performance Indicator" := TargetLines."Key Performance Indicator";
                //         AppraissalLinesWP."Agreed Performance Targets" := TargetLines.Target;
                //         AppraissalLinesWP.Weight := TargetLines.Weight;
                //         AppraissalLinesWP."Header No" := "No.";
                //         AppraissalLinesWP.Insert(true);
                //     until TargetLines.Next = 0;
                // end;

                // ValueSeries := 0;
                // StaffValues.Reset;
                // if StaffValues.FindFirst then begin
                //     repeat
                //         ValueSeries := ValueSeries + 1;
                //         AppraisalLinesValues.Init;
                //         AppraisalLinesValues."Appraisal No." := ValueSeries;
                //         AppraisalLinesValues."Header No" := "No.";
                //         AppraisalLinesValues.Values := StaffValues.Value;
                //         AppraisalLinesValues.Description := StaffValues.Description;
                //         AppraisalLinesValues.Insert(true);
                //     until StaffValues.Next = 0;
                // end;

                // HREmp.Reset();
                // HREmp.SetRange("No.", "Employee No.");

                // HREmp.Get("Employee No.");
                // deptHead := HREmp.Supervisor;

                // departments.Reset();
                // departments.SetRange("Department Head UserId", UserId);
                // if departments.Find('-') then begin
                //     repeat
                //     if HREmp.Supervisor then begin
                //         HREmp.Reset();
                //         HREmp.SetRange("No.", "Employee No.");
                //         HREmp.SetRange("Responsibility Center", departments.Code);
                //         if HREmp.Find('-') = false then begin
                //             Error('The selected staff, No: %1, is not pa');
                //         end
                //     end else begin

                //     end;
                //     until departments.Next() = 0;
                // end;

                HREmp.Reset();
                HREmp.SetRange("No.", "Employee No.");
                if HREmp.Find('-') then begin

                    "Employee No." := HREmp."No.";
                    "Employee Name" := HREmp.FullName();
                    "User ID" := HREmp."User ID";

                    TargetSeries := 0;
                    TargetLines.Reset;
                    TargetLines.SetRange("Department Code", HREmp."Responsibility Center");
                    if TargetLines.FindFirst then begin
                        repeat
                            TargetSeries := TargetSeries + 1;
                            AppraissalLinesWP.Init;
                            AppraissalLinesWP."Appraisal No." := TargetSeries;
                            AppraissalLinesWP."Key Value Driver" := TargetLines."Parent KVD";
                            AppraissalLinesWP."Key Performance Indicator" := TargetLines.KPI;
                            AppraissalLinesWP."Agreed Performance Targets" := TargetLines."KPI Target";
                            AppraissalLinesWP.Weight := TargetLines.Weight;
                            AppraissalLinesWP."Header No" := "No.";
                            AppraissalLinesWP.Insert(true);
                        until TargetLines.Next = 0;
                    end;

                    ValueSeries := 0;
                    StaffValues.Reset;
                    if StaffValues.FindFirst then begin
                        repeat
                            ValueSeries := ValueSeries + 1;
                            AppraisalLinesValues.Init;
                            AppraisalLinesValues."Appraisal No." := ValueSeries;
                            AppraisalLinesValues."Header No" := "No.";
                            AppraisalLinesValues.Values := StaffValues.Value;
                            AppraisalLinesValues.Description := StaffValues.Description;
                            AppraisalLinesValues."Target Score" := StaffValues.Weight;
                            AppraisalLinesValues.Insert(true);
                        until StaffValues.Next = 0;
                    end;

                end;
            end;
        }
        field(13; "Employee Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Date of First Appointment"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
            end;
        }
        field(18; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Comments Appraisee"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Comments Appraiser"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Evaluation Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Evaluation Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Target Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Company Targets,Individual Targets,Peer Targets,Surbodinates Targets,Out Agencies Targets,Company Rating,Individual Rating,Peer Rating,Surbodinates Rating,Out Agencies Rating';
            OptionMembers = " ","Company Targets","Individual Targets","Peer Targets","Surbodinates Targets","Out Agencies Targets","Company Rating","Individual Rating","Peer Rating","Surbodinates Rating","Out Agencies Rating";
        }
        field(25; "Supervisor No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";
        }
        field(26; "Final Scores"; Decimal)
        {
        }
        field(27; "Final Soft Scores"; Decimal)
        {
        }
        field(28; "Total Scores"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
        }
        field(29; "Rating Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Locked; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Supervisor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "E-mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Closed;
            Editable = false;

            trigger OnValidate()
            begin
                if Status = Status::Open then begin
                    "Appraisal Stage" := "Appraisal Stage"::"Achieved Target";
                    "Appraisal Status" := "Appraisal Status"::Appraisee;

                end else if Status = Status::"Pending Approval" then begin
                    "Appraisal Stage" := "Appraisal Stage"::"Target Approval";
                    "Appraisal Status" := "Appraisal Status"::Supervisor;

                end else if Status = Status::Approved then begin
                    "Appraisal Stage" := "Appraisal Stage"::"Supervisor Evaluation";
                    "Appraisal Status" := "Appraisal Status"::Supervisor;

                end;
            end;
        }
        field(34; "Current Scale"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Scale Year"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Appraisal Period."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "No. series"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(38; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Total KPI Score"; Decimal)
        {
            CalcFormula = sum("Appraissal Lines WP"."Supervisor-Assesment" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Total Behavioral Score"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines Values"."Supervisor Score" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Surbodinate Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(42; "Performance Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(43; "Competencies Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(44; "Appraised Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Appraised Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(46; "Score Grading"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Assign To Peers"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(48; "Assign To Subordinate"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(49; "Assign To Customer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50; Appraised; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Appraised By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Directorate Code"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Directorate Name"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "User Designation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Officer,Asst Manager,Manager,Director,CEO,BOD';
            OptionMembers = " ",Officer,"Asst Manager",Manager,Director,CEO,BOD;
        }
        field(55; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Total KPIs"; Decimal)
        {
            CalcFormula = sum("Appraissal Lines WP".Weight where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Total Behavioral"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines Values"."Target Score" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PerformanceSetup.Get;
            PerformanceSetup.TestField(PerformanceSetup."Performance Numbers");
            NoSeriesMgt.GetNextNo(PerformanceSetup."Performance Numbers");
        end;
        "Document Date" := Today;

        HREmp.Reset();
        HREmp.SetRange("User ID", UserId);
        HREmp.SetRange(Supervisor, true);
        if HREmp.FindFirst then begin

            AppraisalPeriods.Reset;
            AppraisalPeriods.SetRange(AppraisalPeriods.Open, true);
            if AppraisalPeriods.FindFirst then begin
                "Appraisal Period" := AppraisalPeriods.Code;
                "Evaluation Period End Date" := AppraisalPeriods."Period End Date";
                "Evaluation Period Start Date" := AppraisalPeriods."Period Start Date";
            end;

            // "Appraisal Stage" := "Appraisal Stage"::"Achieved Target";

            "Supervisor User ID" := HREmp."User ID";
            "Supervisor No." := HREmp."No.";
            "Supervisor Name" := HREmp.FullName();
            Manager := HREmp.Supervisor;

        end else begin
            Error('User not set up.');
        end;
    end;

    var
        HRAppHeader: Record "HR Appraisal Header";
        HREmp: Record "HR Employees";
        HREmpCopy: Record "HR Employees";
        departments: Record "Responsibility Center";
        NoSeriesMgt: Codeunit "No. Series";
        HREmpCard: Page "Employee Card";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
        LineNo: Integer;
        deptHead: Boolean;
        DimensionValue: Record "Dimension Value";
        PerformanceSetup: Record "HR Setup";
        AppraissalLinesWP: Record "Appraissal Lines WP";
        AppraisalPeriods: Record "Appraisal Periods";
        TargetLines: Record "Departmental KPIs";
        StaffValues: Record "Staff Values";
        AppraisalLinesValues: Record "Appraisal Lines Values";
        ValueSeries: Integer;
        TargetSeries: Integer;
}

