

program listdir;

uses
  SysUtils;

var
    sr: TSearchRec;
    res: Integer;

begin
    res := FindFirst('*', faAnyFile, sr);
    while res = 0 do
    begin
        if (sr.Attr and faDirectory) = faDirectory then
            writeln('<DIR>  ', sr.Name)
        else
            writeln('<FILE> ', sr.Name);
        res := FindNext(sr);
    end;
    FindClose(sr);
end.