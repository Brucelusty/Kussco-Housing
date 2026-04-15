page 50324 "Staff Dashboard Cue"
{
    ApplicationArea = All;
    Caption = 'Infomation Analysis';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Staff Cue";

    layout
    {
        area(content)
        {
#if not CLEAN18
            cuegroup("Intelligent Cloud")
            {
                Caption = 'Intelligent Cloud';
                Visible = false;
                ObsoleteTag = '18.0';
                ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                ObsoleteState = Pending;

                actions
                {
                    action("Learn More")
                    {
                        Caption = 'Learn More';
                        Image = TileInfo;
                        RunPageMode = View;
                        ToolTip = ' Learn more about the Intelligent Cloud and how it can help your business.';
                        Visible = false;
                        ObsoleteTag = '18.0';
                        ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                        ObsoleteState = Pending;

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                         //   HyperLink(IntelligentCloudManagement.GetIntelligentCloudLearnMoreUrl);
                        end;
                    }
                    action("Intelligent Cloud Insights")
                    {
                        Caption = 'Intelligent Cloud Insights';
                        Image = TileCloud;
                        RunPageMode = View;
                        ToolTip = 'View your Intelligent Cloud insights.';
                        Visible = false;
                        ObsoleteTag = '18.0';
                        ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                        ObsoleteState = Pending;

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                            //HyperLink(IntelligentCloudManagement.GetIntelligentCloudInsightsUrl);
                        end;
                    }
                }
            }




      
            cuegroup(PurchaseRequisition)
            {
                Caption = 'Purchase Requisition';
                field("Purchase Request New - All"; Rec."Purchase Request New - All")
                {
                    DrillDownPageID = "Task Order";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Request Pending Approval - All"; Rec."Purchase Request Pending Approval - All")
                {

                    DrillDownPageID = "Pending Purchase Requisition";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Request Approved - All"; Rec."Purchase Request Approved - All")
                {
                    // DrillDownPageID = "Approved Purchase Requisition";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
            }
            cuegroup(LocalPurchaseOrders)
            {
                Caption = 'Local Purchase Orders';
                field("LPOs"; Rec."Purchase Orders")
                {
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
            }
            cuegroup("LeaveManagement")
            {
                Caption = 'Leave Application Management';
                field("Leave Application New"; Rec."Leave Application New")
                {
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Pending Approval"; Rec."Leave Application Pending Approval")
                {
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Approved"; Rec."Leave Application Approved")
                {
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Posted"; Rec."Leave Application Posted")
                {
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Rejected"; Rec."Leave Application Rejected")
                {
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }
#endif




            /*cuegroup(CashRequisitionForm)
            {
                Caption = 'Cash Requisition Form';
                field("Request Form New - All"; Rec."Request Form New - All")
                {
                    DrillDownPageID = "Request List";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Request Form Pending Approval - All"; Rec."Request Form Pending Approval - All")
                {

                    DrillDownPageID = "Request List Pending";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Request Form Approved - All"; Rec."Request Form Approved - All")
                {
                    DrillDownPageID = "Request List Approved";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }*/
            /*cuegroup(PurchaseQuotes)
            {
                Caption = 'Purchase Quotes';
                field("Purchase Quote Awarded - All";Rec."Purchase Quote Awarded - All")
                {
                    DrillDownPageID = "PQ Awarded List ";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Quote NOT Awarded - All";Rec."Purchase Quote NOT Awarded - All")
                {

                    DrillDownPageID = "PQ NOT Awarded List ";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
              


            }*/
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRange("User ID Filter", UserId());

        ShowIntelligentCloud := not EnvironmentInfo.IsSaaS();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        EnvironmentInfo: Codeunit "Environment Information";
        ShowIntelligentCloud: Boolean;
}

