unit UnitHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, AxCtrls, ComCtrls,
  StdCtrls, Shellapi, Buttons, jpeg;

type
  TfrmHelp = class(TForm)
    pages: TPageControl;
    pgHelp: TTabSheet;
    pgInfo: TTabSheet;
    email: TSpeedButton;
    site: TSpeedButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Image1: TImage;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure emailClick(Sender: TObject);
    procedure siteClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure pgInfoHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

uses UnitStart;

{$R *.dfm}

//================================================================
procedure TfrmHelp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frmStart.Hide;
frmStart.Show;
frmStart.Enabled:=true;
image2.Visible:=false;
end;

//================================================================
procedure TfrmHelp.emailClick(Sender: TObject);
begin
shellexecute(0,nil,'mailto:shurik83@mail.ru',nil,nil,0);
end;

//================================================================
procedure TfrmHelp.siteClick(Sender: TObject);
begin
shellexecute(0,nil,'http://www.shurik83.narod.ru',nil,nil,0);
end;

//================================================================
procedure TfrmHelp.Image1DblClick(Sender: TObject);
begin
image2.Visible:=true;
end;

//================================================================
procedure TfrmHelp.pgInfoHide(Sender: TObject);
begin
image2.Visible:=false;
end;

end.
