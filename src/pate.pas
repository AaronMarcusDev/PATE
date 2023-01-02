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
            Args := Copy(Tokens, 1, Length(Tokens));
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
        else if (command = 'syscmd') then
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
                    end;
            end
        else if (command = 'echo') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else
                    WriteLn(JoinArrayWithDelim(Args, ' '));
            end
        else if (command = 'clr') then
            ClrScr
        else if (command = 'pwd') then
            WriteLn(GetCurrentDir)
        else if (command = 'cd') then
            begin
                if (Length(Args) = 0) then
                    Report('Insufficient arguments')
                else
                    begin
                        if (SetCurrentDir(Args[0])) then {}
                        else
                            Report('Failed to change directory to `' + Args[0] + '`');
                    end;
            end
        else if (command = 'touch') then
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
        else if (command = 'del') then
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
        else if (command = 'mkdir') then
            begin
                if (Length(Args) = 0) then
                    report('Insufficient arguments')
                else if (Length(Args) > 1) then
                    report('Too many arguments')
                else
                    begin
                        if (DirectoryExists(Args[0])) then
                            report('Directory `' + Args[0] + '` already exists')
                        else
                            MkDir(Args[0]);
                    end;
            end
        else if (command = 'deldir') then
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
        else if (command = 'help') then
            begin
                WriteLn('PATE version ' + Version);
                WriteLn('Available commands:');
                WriteLn('  exit - Exit PATE');
                WriteLn('  exitclr - Exit PATE and clear the screen');
                WriteLn('  sys - Run a system command');
                WriteLn('  syscmd - Run a system command in a new cmd.exe instance');
                WriteLn('  echo - Echo arguments');
                WriteLn('  clr - Clear the screen');
                WriteLn('  pwd - Print the current working directory');
                WriteLn('  cd - Change the current working directory');
                WriteLn('  touch - Create a new file');
                WriteLn('  rm - Delete a file');
                WriteLn('  help - Print this help message');
            end
        else
            begin
                TextColor(Red);
                Report('Unknown command `' + Command + '`');
                TextColor(White);
            end;
    end;
end.