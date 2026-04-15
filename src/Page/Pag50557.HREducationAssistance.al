//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50557 "HR Education Assistance"
{
    ApplicationArea = All;
    PageType = Document;
    SourceTable = "HR Education Assistance";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No.";Rec."Employee No.")
                {
                }
                field("Employee First Name";Rec."Employee First Name")
                {
                }
                field("Employee Last Name";Rec."Employee Last Name")
                {
                }
            }
            group(Details)
            {
                field("Year Of Study";Rec."Year Of Study")
                {
                }
                field("Study Period";Rec."Study Period")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field(Year; Rec.Year)
                {
                }
                field("To";Rec."To")
                {
                }
                field("Student Number";Rec."Student Number")
                {
                }
                field("Type Of Institution";Rec."Type Of Institution")
                {
                }
                field("Enrollment Fee";Rec."Enrollment Fee")
                {
                }
                field("Total Cost";Rec."Total Cost")
                {
                }
                field(Qualification; Rec.Qualification)
                {
                }
                field("Refund Level";Rec."Refund Level")
                {
                }
                field("Educational Institution";Rec."Educational Institution")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
            group("Subjects Registered")
            {
                fixed(Control1102755054)
                {
                    group(Subjects)
                    {
                        field("Subject Registered1";Rec."Subject Registered1")
                        {
                        }
                        field("Subject Registered2";Rec."Subject Registered2")
                        {
                        }
                        field("Subject Registered3";Rec."Subject Registered3")
                        {
                        }
                        field("Subject Registered4";Rec."Subject Registered4")
                        {
                        }
                        field("Subject Registered5";Rec."Subject Registered5")
                        {
                        }
                        field("Subject Registered6";Rec."Subject Registered6")
                        {
                        }
                    }
                    group("Cost Of Subject")
                    {
                        field("Cost Of Subject1";Rec."Cost Of Subject1")
                        {
                        }
                        field("Cost Of Subject2";Rec."Cost Of Subject2")
                        {
                        }
                        field("Cost Of Subject3";Rec."Cost Of Subject3")
                        {
                        }
                        field("Cost Of Subject4";Rec."Cost Of Subject4")
                        {
                        }
                        field("Cost Of Subject5";Rec."Cost Of Subject5")
                        {
                        }
                        field("Cost Of Subject6";Rec."Cost Of Subject6")
                        {
                        }
                    }
                    group("Cost Of Books")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("Book Cost Subject1";Rec."Book Cost Subject1")
                        {
                        }
                        field("Book Cost Subject2";Rec."Book Cost Subject2")
                        {
                        }
                        field("Book Cost Subject3";Rec."Book Cost Subject3")
                        {
                        }
                        field("Book Cost Subject4";Rec."Book Cost Subject4")
                        {
                        }
                        field("Book Cost Subject5";Rec."Book Cost Subject5")
                        {
                        }
                        field("Book Cost Subject6";Rec."Book Cost Subject6")
                        {
                        }
                    }
                    group("Education Credits")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("Education Credits1";Rec."Education Credits1")
                        {
                        }
                        field("Education Credits2";Rec."Education Credits2")
                        {
                        }
                        field("Education Credits3";Rec."Education Credits3")
                        {
                        }
                        field("Education Credits4";Rec."Education Credits4")
                        {
                        }
                        field("Education Credits5";Rec."Education Credits5")
                        {
                        }
                        field("Education Credits6";Rec."Education Credits6")
                        {
                        }
                    }
                    group("Training Credits")
                    {
                        field("Training Credits1";Rec."Training Credits1")
                        {
                        }
                        field("Training Credits2";Rec."Training Credits2")
                        {
                        }
                        field("Training Credits3";Rec."Training Credits3")
                        {
                        }
                        field("Training Credits4";Rec."Training Credits4")
                        {
                        }
                        field("Training Credits5";Rec."Training Credits5")
                        {
                        }
                        field("<Training Credits6>";Rec."Training Credits6")
                        {
                            Caption = '<Training Credits6>';
                        }
                    }
                }
            }
            group("Subjects Results")
            {
                fixed(Control1102755057)
                {
                    group("Subjects& Results")
                    {
                        field(Subject1; Rec."Subject Registered1")
                        {
                        }
                        field(Subject2; Rec."Subject Registered2")
                        {
                        }
                        field(Subject3; Rec."Subject Registered3")
                        {
                        }
                        field(Subject4; Rec."Subject Registered4")
                        {
                        }
                        field(Subject5; Rec."Subject Registered5")
                        {
                        }
                        field(Subject6; Rec."Subject Registered6")
                        {
                        }
                    }
                    group("Date Completed")
                    {
                        field("Date Completed1";Rec."Date Completed1")
                        {
                        }
                        field("Date Completed2";Rec."Date Completed2")
                        {
                        }
                        field("Date Completed3";Rec."Date Completed3")
                        {
                        }
                        field("Date Completed4";Rec."Date Completed4")
                        {
                        }
                        field("Date Completed5";Rec."Date Completed5")
                        {
                        }
                        field("Date Completed6";Rec."Date Completed6")
                        {
                        }
                    }
                    group(Control1102755072)
                    {
                        field(CompletedResult1; Rec.CompletedResult1)
                        {
                        }
                        field(CompletedResult2; Rec.CompletedResult2)
                        {
                        }
                        field(CompletedResult3; Rec.CompletedResult3)
                        {
                        }
                        field(CompletedResult4; Rec.CompletedResult4)
                        {
                        }
                        field(CompletedResult5; Rec.CompletedResult5)
                        {
                        }
                        field(CompletedResult6; Rec.CompletedResult6)
                        {
                        }
                    }
                    group("Rewrite Date")
                    {
                        field("Date Rewrite1";Rec."Date Rewrite1")
                        {
                        }
                        field("Date Rewrite2";Rec."Date Rewrite2")
                        {
                        }
                        field("Date Rewrite3";Rec."Date Rewrite3")
                        {
                        }
                        field("Date Rewrite4";Rec."Date Rewrite4")
                        {
                        }
                        field("Date Rewrite5";Rec."Date Rewrite5")
                        {
                        }
                        field("Date Rewrite6";Rec."Date Rewrite6")
                        {
                        }
                    }
                    group(Control1102755086)
                    {
                        field(RewriteResult1; Rec.RewriteResult1)
                        {
                        }
                        field(RewriteResult2; Rec.RewriteResult2)
                        {
                        }
                        field(RewriteResult3; Rec.RewriteResult3)
                        {
                        }
                        field(RewriteResult4; Rec.RewriteResult4)
                        {
                        }
                        field(RewriteResult5; Rec.RewriteResult5)
                        {
                        }
                        field(RewriteResult6; Rec.RewriteResult6)
                        {
                        }
                    }
                    group(Refunded)
                    {
                        field(Refunded1; Rec.Refunded1)
                        {
                        }
                        field(Refunded2; Rec.Refunded2)
                        {
                        }
                        field(Refunded3; Rec.Refunded3)
                        {
                        }
                        field(Refunded4; Rec.Refunded4)
                        {
                        }
                        field(Refunded5; Rec.Refunded5)
                        {
                        }
                        field(Refunded6; Rec.Refunded6)
                        {
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }
}






