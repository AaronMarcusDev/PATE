unit arraytools;

interface
    uses sysutils;

    function JoinArray(Arr: TStringArray): string;
    function JoinArrayWithDelim(Arr: TStringArray; Delim: string): string;
    function ConcatArrays(Arr: TStringArray; Arr2: TStringArray): TStringArray;

implementation
    var i: integer;

    function JoinArray(Arr: TStringArray): string;
    begin
        JoinArray := '';
        for i := 0 to Length(Arr) - 1 do
            JoinArray := JoinArray + Arr[i];
    end;

    function JoinArrayWithDelim(Arr: TStringArray; Delim: string): string;
    begin
        JoinArrayWithDelim := '';
        for i := 0 to Length(Arr) - 1 do
            JoinArrayWithDelim := JoinArrayWithDelim + Delim + Arr[i];
    end;

    function ConcatArrays(Arr: TStringArray; Arr2: TStringArray): TStringArray;
    var Result: TStringArray;
    begin
        SetLength(Result, Length(Arr) + Length(Arr2));
        for i := 0 to Length(Arr) - 1 do
            Result[i] := Arr[i];
        for i := 0 to Length(Arr2) - 1 do
            Result[Length(Arr) + i] := Arr2[i];
        ConcatArrays := Result;
    end;

    
end.