program PATE;

uses sysutils, crt;

const
    Version: string = 'beta';
var
    User: string;
    Loop: boolean;
    Command: string;

begin
// Initialize variables
    User := 'user';
    Loop := true;
    ClrScr;
    
    while loop do
    begin
        Write('> ');
        ReadLn(Command);
        WriteLn('Command issued: ', Command);
    end;
end.