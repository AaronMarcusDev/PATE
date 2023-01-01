program PATE;

uses crt, sysutils, strutils, arraytools;

const
    Version: string = 'beta';
var
    User: string;
    Loop: boolean;
    Tokens: TStringArray;
    Command: string;
    Args: TStringArray;

begin
// Initialize variables
    User := 'user';
    Loop := true;
    Args := [];

// Start
    ClrScr;
    while loop do
    begin
        TextColor(Blue);
        Write(User);
        TextColor(White);
        Write('@');
        TextColor(Green);
        Write(GetCurrentDir + sLineBreak + '$ ');
        TextColor(White);
        
        readLn(Command);
        if (pos(' ' , Command) <> 0) then
        begin
            Tokens := Trim(LowerCase(Command)).Split(' ');
            Command := Tokens[0];
            Args := Copy(Tokens, 1, Length(Tokens))
        end;

        if (Length(command) = 0) then
            continue
        else if (command = 'exit') then
            begin
                loop := false;
                WriteLn('Bye :)');
            end
        else if (command = 'echo') then
            begin
                if (Length(Args) = 0) then
                    WriteLn('ERROR: Insufficient arguments')
                else
                    WriteLn(JoinArrayWithDelim(Args, ' '));
            end
        else
            begin
                TextColor(Red);
                WriteLn('ERROR: Unknown command `' + Command + '`');
                TextColor(White);
            end;
    end;
end.