codeunit 50123 "KPI Management"
{
    procedure CalculatePerformance(HeaderNo: Code[20])
    var
        Header: Record "Performance Header";
        Line: Record "Performance Line";
        KPI: Record "KPI Setup";
        TotalScore: Decimal;
    begin
        if not Header.Get(HeaderNo) then
            Error('Header not found');

        TotalScore := 0;

        Line.SetRange("Document No.", Header."No.");
        if Line.FindSet() then
            repeat
                KPI.Get(Line."KPI Code");

                Line.Score := CalculateScore(Line.Actual, Line.Target, KPI."Reverse Score");
                Line."Weighted Score" := (Line.Score / 100) * Line.Weight;

                TotalScore += Line."Weighted Score";

                Line.Modify();
            until Line.Next() = 0;

        Header."Total Score" := TotalScore;
        Header."Rating" := GetRating(TotalScore);
        Header.Status := Header.Status::Calculated;

        Header.Modify();
    end;

    local procedure CalculateScore(Actual: Decimal; Target: Decimal; Reverse: Boolean): Decimal
    begin
        if Target = 0 then
            exit(0);

        if Reverse then
            exit((Target / Actual) * 100)
        else
            exit((Actual / Target) * 100);
    end;

    local procedure GetRating(Score: Decimal): Enum "Performance Rating"
    begin
        if Score >= 90 then
            exit("Performance Rating"::Excellent)
        else
            if Score >= 75 then
                exit("Performance Rating"::Good)
            else
                if Score >= 60 then
                    exit("Performance Rating"::Average)
                else
                    exit("Performance Rating"::Poor);
    end;
}
