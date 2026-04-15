Page 50083 "Appraisal Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Appraisal Header";
    PromotedActionCategories = 'New,Process,Report,Approvals,Supervisor';

    layout
    {
        area(content)
        {
            group(General)
            {
                // Enabled = editableFa;
                field("No."; Rec."No.")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Appraisal Stage";Rec."Appraisal Stage")
                {
                    ShowMandatory = true;
                    Editable = not SupervisorEnabled;
                }
                field("Appraisal Status"; Rec."Appraisal Status")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Manager;Rec.Manager)
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = AppraiseeEnabled;
                    // Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Supervisor User ID"; Rec."Supervisor User ID")
                {
                    Editable = false;
                }
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    Editable = false;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Total KPIs";Rec."Total KPIs")
                {
                    // Visible = false;
                    Style = Subordinate;
                }
                field("Total Behavioral";Rec."Total Behavioral")
                {
                    // Visible = false;
                    Style = AttentionAccent;
                }
                field("Total KPI Score"; Rec."Total KPI Score")
                {
                    // Visible = false;
                    Style = Subordinate;
                }
                field("Total Behavioral Score"; Rec."Total Behavioral Score")
                {
                    // Visible = false;
                    Style = AttentionAccent;
                }
                field("Appraised Score"; Rec."Appraised Score")
                {
                    Editable = false;
                }
                field("Appraised Narration"; Rec."Appraised Narration")
                {
                    MultiLine = true;
                    // Visible = false;
                    Editable = Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation";
                    ShowMandatory = true;
                }
                field("Score Grading"; Rec."Score Grading")
                {
                    Visible = false;
                }
                field(Appraised; Rec.Appraised)
                {
                }
                field("Appraised By"; Rec."Appraised By")
                {
                }
                field(Remark; Rec.Remark)
                {
                    ShowMandatory = true;
                }
            }
            part(KPI; "Appraisal Lines Targets")
            {
                SubPageLink = "Header No" = field("No.");
                // Visible = false;
            }
            part(Behavioral; "Behavioral Objectives")
            {
                SubPageLink = "Header No" = field("No.");
                // Visible = false;
            }
            // part("Individual objectives"; "Departmental Objectives")
            // {
            //     SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Key Performance Areas" = filter(<> '');
            //     Editable = editableFa;

            // }
            // part("Job Specific objectives"; "Individual Perfomance Score")
            // {
            //     SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Perfomance Goals and Targets" = filter(<> '');
            //     Editable = editableFa;

            // }
            // part("Training Needs"; "Training Appraisee")
            // {
            //     SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Course Name" = filter(<> '');
            //     Editable = editableFa;

            // }
        }
        area(FactBoxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("Employee No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Staff Appraisal Attachments';
                SubPageLink = "Table ID" = const(Database::"HR Appraisal Header"), "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Send To Supervisor")
            {
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = EnableField;

                trigger OnAction()
                begin
                    Rec.TestField("Appraisal Period");
                    Rec.TestField("Employee No.");
                    Rec.TestField("Supervisor No.");

                    kpiLines.Reset();
                    kpiLines.SetRange("Header No", Rec."No.");
                    if kpiLines.Find('-') then begin
                        repeat
                        // kpiLines.TestField("Self Assesment Score");
                        kpiLines.TestField("Appraisee Comments");
                        until kpiLines.Next() = 0;
                    end;

                    behavioralLines.Reset();
                    behavioralLines.SetRange("Header No", Rec."No.");
                    if behavioralLines.Find('-') then begin
                        repeat
                        // behavioralLines.TestField(Score);
                        behavioralLines.TestField("Appraisee Comments");
                        until behavioralLines.Next() = 0;
                    end;

                    if Confirm('Do you wish to send your KPI self assessment for this period to your supervisor?',true) = false then exit;
                    
                    if workflows.CheckStaffPerformanceAppraisalWorkflowEnabled(Rec) then begin
                        workflows.OnSendForStaffPerformanceAppraisalApproval(Rec);
                    end;
                end;
            }
            action("Return From Supervisor")
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");

                trigger OnAction()
                begin
                    Rec.TestField("Appraisal Period");
                    Rec.TestField("Employee No.");
                    Rec.TestField("Supervisor No.");

                    kpiLines.Reset();
                    kpiLines.SetRange("Header No", Rec."No.");
                    if kpiLines.Find('-') then begin
                        repeat
                        kpiLines.TestField("Self Assesment Score");
                        kpiLines.TestField("Appraisee Comments");
                        until kpiLines.Next() = 0;
                    end;

                    behavioralLines.Reset();
                    behavioralLines.SetRange("Header No", Rec."No.");
                    if behavioralLines.Find('-') then begin
                        repeat
                        behavioralLines.TestField(Score);
                        behavioralLines.TestField("Appraisee Comments");
                        until behavioralLines.Next() = 0;
                    end;

                    if Confirm('Do you wish to return your KPI self assessment for this period from your supervisor?',true) = false then exit;
                    
                    if workflows.CheckStaffPerformanceAppraisalWorkflowEnabled(Rec) then begin
                        workflows.OnCancelStaffPerformanceAppraisalApprovalRequest(Rec);
                    end;
                end;
            }
        }
        area(processing)
        {
            group(ActionGroup1120054007)
            {
                // action("Send To Supervisor(Target Approval)")
                // {
                //     Image = SendConfirmation;
                //     Enabled = AppraiseeEnabled;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category4;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         if Rec."User ID" <> UserId then Error('You can only act on your appraisal form %1', Rec."User ID");
                //         if Confirm('Are you sure you want to send to supervisor?') = true then begin
                //             Rec."Appraisal Status" := Rec."Appraisal Status"::Supervisor;
                //             Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Approval";
                //             Rec.Modify();
                //             Message('Tragets send for approval');
                //         end;
                //     end;
                // }
                action("Approve Targets")
                {
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category5;
                    Enabled = (SupervisorEnabled and (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting"));

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Approve these targets?') = false then exit;
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Achieved Target";
                        Rec.Modify();
                        Message('Targets approved successfully');
                    end;
                }
                // action("Return To Appraisee")
                // {
                //     Image = SendConfirmation;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category5;
                //     Enabled = SupervisorEnabled;

                //     trigger OnAction()
                //     begin
                //         // Rec.TESTFIELD("Appraisal Stage", Rec."Appraisal Stage"::"Target Approval");
                //         // if Confirm('Are you sure you want to return to appraisee?') = false then exit;
                //         // Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Setting";
                //         // Rec.MODIFY;
                //         // MESSAGE('Appraisal returned to appraisee')

                //     end;
                // }
                // /*"Appraisal Period";*/
                // action("Send To Supervisor(Evaluation)")
                // {
                //     Image = SendConfirmation;
                //     Enabled = SendForevaluation;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category4;

                //     trigger OnAction()
                //     begin
                //         if Rec."User ID" <> UserId then Error('You can only act on your appraisal form %1', Rec."User ID");
                //         if Confirm('Are you sure you want to send to supervisor?') = true then begin

                //             Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Supervisor Evaluation";
                //             Rec.Modify();
                //             Message('Goals assessment send for Evaluation');
                //         end;
                //     end;
                // }
                action("Approve Goals")
                {
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category5;
                    Enabled = SupervisorEvaluation;

                    trigger OnAction()
                    var
                    avgKPI: Decimal;
                    avgBehavioral: Decimal;
                    actualScore: Decimal;
                    begin
                        if Confirm('Are you sure you want to Approve the the appraisal as final?') = false then exit;

                        avgBehavioral := 0;
                        avgKPI := 0;
                        actualScore := 0;

                        Rec.CalcFields("Total Behavioral Score", "Total KPI Score", "Total Behavioral", "Total KPIs");
                        avgKPI := Round((Rec."Total KPI Score"/Rec."Total KPIs") * 100, 0.01, '>');
                        avgBehavioral := Round((Rec."Total Behavioral Score"/Rec."Total Behavioral") * 100, 0.01, '>');
                        actualScore := avgBehavioral + avgKPI;

                        Rec.Status := Rec.Status::Closed;
                        Rec."Appraised Score" := actualScore;
                        Rec.Appraised := true;
                        Rec."Appraised By" := UserId;
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Appraisal Completed";
                        Rec.Modify();

                        Message('Appraisal process has been successfuly completed');
                    end;
                }

                action("Print Form")
                {
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;


                    trigger OnAction()
                    begin
                        AppraisalHeader.Reset();
                        AppraisalHeader.SetRange("No.", Rec."No.");
                        if AppraisalHeader.Find('-') then begin
                           // Report.Run(Report::"Appraisal Form", true, false, AppraisalHeader);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AppraiseeEnabled := false;
        SupervisorEnabled := false;
        editableFa := false;
        SupervisorEvaluation := false;
        SendForevaluation := false;
        EnableField := false;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting" then begin
            AppraiseeEnabled := true;
            SupervisorEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Approval" then begin
            SupervisorEnabled := true;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target" then begin
            SupervisorEnabled := true;
            AppraiseeEnabled := false;
            // SendForevaluation := true;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation" then begin
            SupervisorEnabled := false;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := true;
        end;
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target") then begin
            EnableField := true;
        end else begin
            EnableField := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed" then begin
            editableFa := false;
        end else begin
            editableFa := true;
        end;

    end;
    trigger OnAfterGetCurrRecord()
    begin
        AppraiseeEnabled := false;
        SupervisorEnabled := false;
        editableFa := false;
        SupervisorEvaluation := false;
        SendForevaluation := false;
        EnableField := false;
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target") then begin
            AppraiseeEnabled := true;
            SupervisorEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Approval" then begin
            SupervisorEnabled := true;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target" then begin
            SupervisorEnabled := true;
            AppraiseeEnabled := false;
            // SendForevaluation := true;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation" then begin
            SupervisorEnabled := false;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := true;
        end;
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target") then begin
            EnableField := true;
        end else begin
            EnableField := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed" then begin
            editableFa := false;
        end else begin
            editableFa := true;
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AppraisalHeader.Reset();
        AppraisalHeader.SetRange("User ID", UserId);
        AppraisalHeader.SetRange("Appraisal Stage", AppraisalHeader."Appraisal Stage"::"Target Setting");
        if AppraisalHeader.FindSet() then begin
            if AppraisalHeader.Count > 1 then begin
                Error('You have another target setting that is open kindly use that %1', AppraisalHeader."No.");
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Records are not allowed to be deleted. create another record instead!!!');
    end;

    trigger OnOpenPage()
    begin
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Achieved Target") then begin
            EnableField := true;
        end else begin
            EnableField := false;
        end;

        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed" then begin
            editableFa := false;
        end else begin
            editableFa := true;
        end;
        // Message('%1-%2-%3', Rec."Appraisal Stage", EnableField, editableFa);

    end;


    var
        SendForevaluation: Boolean;
        SupervisorEnabled: Boolean;
        AppraiseeEnabled: Boolean;
        SupervisorEvaluation: Boolean;
        editableFa: Boolean;
        EnableField: Boolean;
        workflows: Codeunit WorkflowIntegration;
        AppraisalHeader: Record "HR Appraisal Header";
        kpiLines: Record "Appraissal Lines WP";
        behavioralLines: Record "Appraisal Lines Values";
}



