unit arraytools;

interface
    uses sysutils;

    function JoinArray(Arr: TStringArray): string;
    function JoinArrayWithDelim(Arr: TStringArray; Delim: string): string;

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

    
end.