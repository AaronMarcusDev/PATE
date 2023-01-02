unit error;

interface
    uses crt;

    procedure Report(message: string);

implementation
    procedure Report(message: string);
    begin
        TextColor(Red);
        WriteLn('ERROR: ', message);
        TextColor(White);
    end;
end.