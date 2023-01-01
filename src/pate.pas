program PATE;

// Units
uses crt, sysutils, strutils, process, 
// Custom units
arraytools;

const
    Version: string = 'beta';
var
    User: string;
    Loop: boolean;
    Tokens: TStringArray;
    Command: string;
    Args: TStringArray;
    ProcessResult: ansistring;

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
            loop := false
        else if (command = 'exitclr') then
            begin
                loop := false;
                ClrScr;
            end
        else if (command = 'sys') then
            begin
                if (Length(Args) = 0) then
                    begin
                        WriteLn('ERROR: Insufficient arguments');
                    end
                else if (Length(Args) = 1) then
                    begin
                        if (RunCommand(Args[0], [], ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            WriteLn('ERROR: System command failed');
                    end
                else
                    begin
                        if (RunCommand(Args[0], Copy(Args, 1, Length(Args)), ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            WriteLn('ERROR: System command failed');
                    end;
            end
        else if (command = 'syscmd') then
            begin
                if (Length(Args) = 0) then
                    begin
                        WriteLn('ERROR: Insufficient arguments');
                    end
                else
                    begin
                        if (RunCommand('cmd.exe', ConcatArrays(['/c'], Args), ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            WriteLn('ERROR: System command failed');
                    end;
            end
        else if (command = 'echo') then
            begin
                if (Length(Args) = 0) then
                    WriteLn('ERROR: Insufficient arguments')
                else
                    WriteLn(JoinArrayWithDelim(Args, ' '));
            end
        else if (command = 'clr') then
            ClrScr
        else
            begin
                TextColor(Red);
                WriteLn('ERROR: Unknown command `' + Command + '`');
                TextColor(White);
            end;
    end;
end.