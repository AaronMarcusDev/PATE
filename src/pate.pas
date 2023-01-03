program PATE;

// Units
uses crt, sysutils, strutils, process,
// Custom units
arraytools, error;

const
    Version: string = 'beta';
var
    User: string;
    Loop: boolean;
    Tokens: TStringArray;
    Command: string;
    Args: TStringArray;
    ProcessResult: ansistring;
    F: THandle;

begin
// Initialize variable values
    {$IFDEF WINDOWS}
        User := GetEnvironmentVariable('USERNAME');
    {$ELSE}
        User := GetEnvironmentVariable('USER');
    {$ENDIF}

    Loop := true;
    Args := [];

// Start
    ClrScr;
    while Loop do
    begin
        TextColor(Blue);
        Write(User);
        TextColor(White);
        Write('@');
        TextColor(Green);
        Write(GetCurrentDir + sLineBreak + '$ ');
        TextColor(White);
        
        ReadLn(Command);
        if (Pos(' ' , Command) <> 0) then
        begin
            Tokens := Trim(Command).Split(' ');
            Command := Tokens[0];
            Args := Copy(Tokens, 1, Length(Tokens));
        end;

        if (Length(Command) = 0) then
            continue
        else if (Command = 'exit') then
            Loop := false
        else if (Command = 'exitclr') then
            begin
                Loop := false;
                ClrScr;
            end
        else if (Command = 'sys') then
            begin
                if (Length(Args) = 0) then
                    begin
                        WriteLn('Insufficient arguments');
                    end
                else if (Length(Args) = 1) then
                    begin
                        if (RunCommand(Args[0], [], ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            WriteLn('System command failed');
                    end
                else
                    begin
                        if (RunCommand(Args[0], Copy(Args, 1, Length(Args)), ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            WriteLn('System command failed');
                    end;
            end
        else if (Command = 'syscmd') then
            begin
                if (Length(Args) = 0) then
                    begin
                        Report('Insufficient arguments');
                    end
                else
                    begin
                        if (RunCommand('cmd.exe', ConcatArrays(['/c'], Args), ProcessResult)) then
                            WriteLn(ProcessResult)
                        else
                            Report('System command failed');
                    end
            end
        else if (Command = 'echo') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else
                    WriteLn(JoinArrayWithDelim(Args, ' '));
            end
        else if (Command = 'clr') then
            ClrScr
        else if (Command = 'pwd') then
            WriteLn(GetCurrentDir)
        else if (Command = 'cd') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else
                    begin
                        if (SetCurrentDir(Args[0])) then {}
                        else
                            Report('Failed to change directory to `' + Args[0] + '`');
                    end
            end
        else if (Command = 'touch') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else
                    begin
                        if (FileExists(Args[0])) then
                            Report('File `' + Args[0] + '` already exists')
                        else
                            begin
                                F := FileCreate(Args[0]);
                                FileClose(F);
                            end
                    end
            end
        else if (Command = 'del') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else if (Length(Args) > 1) then
                    Report('Too many arguments')
                else
                    begin
                        if (FileExists(Args[0])) then
                            DeleteFile(Args[0])
                        else
                            Report('File `' + Args[0] + '` does not exist');
                    end
            end
        else if (Command = 'mkdir') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else if (Length(Args) > 1) then
                    Report('Too many arguments')
                else
                    begin
                        if (DirectoryExists(Args[0])) then
                            Report('Directory `' + Args[0] + '` already exists')
                        else
                            MkDir(Args[0]);
                    end;
            end
        else if (Command = 'deldir') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else if (Length(Args) > 1) then
                    Report('Too many arguments')
                else
                    begin
                        if (DirectoryExists(Args[0])) then
                            RmDir(Args[0])
                        else
                            Report('Directory `' + Args[0] + '` does not exist');
                    end
            end
        else if (Command = 'help') then
            begin
                TextColor(Blue);
                WriteLn('PATE version' + Version);
                TextColor(White);
                WriteLn('PATE is a terminal emulator written in Pascal');
                WriteLn('Commands:');
                WriteLn('  exit - Exit PATE');
                WriteLn('  exitclr - Exit PATE and clear the screen');
                WriteLn('  sys - Run a system command');
                WriteLn('  syscmd - Run a system command in cmd.exe');
                WriteLn('  echo - Echo arguments');
                WriteLn('  clr - Clear the screen');
                WriteLn('  pwd - Print working directory');
                WriteLn('  cd - Change directory');
                WriteLn('  touch - Create a file');
                WriteLn('  del - Delete a file');
                WriteLn('  mkdir - Create a directory');
                WriteLn('  deldir - Delete a directory');
                WriteLn('  help - Show this help message');
            end
        else
            begin
                TextColor(Red);
                Report('Unknown command `' + Command + '`');
                TextColor(White);
            end;
    end
end.