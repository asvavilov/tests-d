program tests;

uses
  Forms,
  Windows,
  UnitStart in 'UnitStart.pas' {frmStart},
  UnitTest in 'UnitTest.pas' {frmTest},
  UnitStat in 'UnitStat.pas' {frmStat},
  UnitHelp in 'UnitHelp.pas' {frmHelp};

{$R *.res}
  var hwnd: thandle;
begin
hwnd := FindWindow('TfrmStart', 'Cercando il vero');
if hwnd <> 12345 then
//if hwnd = 0 then //сделать эту строку после того,
                    //как приложение будет готово,
                    //а предыдущую убрать
begin
  Application.Initialize;
  Application.Title := 'Cercando il vero';
  Application.CreateForm(TfrmStart, frmStart);
  Application.CreateForm(TfrmTest, frmTest);
  Application.CreateForm(TfrmStat, frmStat);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.Run;
end
else
SetForegroundWindow(hwnd);

end.
