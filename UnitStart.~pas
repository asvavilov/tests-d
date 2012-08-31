unit UnitStart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, AxCtrls,
  ComCtrls, FileCtrl, Buttons, jpeg;

type
  TfrmStart = class(TForm)
    GrpInfo: TGroupBox;
    files: TFileListBox;
    Label2: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    tstName: TMemo;
    tstComment: TMemo;
    Panel2: TPanel;
    start: TBitBtn;
    Shape1: TShape;
    Label4: TLabel;
    tstTime: TMemo;
    Label5: TLabel;
    KolQ: TMemo;
    Learn: TCheckBox;
    Image1: TImage;
    btnExit: TBitBtn;
    btnInfo: TBitBtn;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure filesClick(Sender: TObject);
    procedure startClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure ReadHead;
  public
    { Public declarations }
  end;

type
  TQH = record //общ. инф-ия о тесте
    Name: string;//название
    Comment: string;//описание
    resD: string;//папка с ресурсами
    timer: string;//время на тест
    kolQ: integer;//кол-во вопросов
    propusk: boolean;//наличие кнопки "пропустить"
    learn: boolean;//доступность режима обучения
    statballs: boolean;//вывод расчетной статистики
    balls: TStringList;//пределы + комментарии
  end;

var
  qh: TQH;
  frmStart: TfrmStart;
  TTh: integer; // время
  TTm: integer; // на
  TTs: integer; // тест
//  mmdir: string; //имя папки с картинками
  filedir: string; //имя папки с программой

implementation

uses UnitTest, UnitHelp;

{$R *.dfm}

//================================================================
procedure TfrmStart.FormCreate(Sender: TObject);
begin
filedir:=ExtractFileDir(application.ExeName);
if DirectoryExists(filedir+'\tests') then
  files.Directory:=filedir+'\tests'
  else
  showmessage('Не найден каталог с тестами - "tests"');
end;

//================================================================
procedure TfrmStart.filesClick(Sender: TObject);
begin
ReadHead();//чтение инф-ии о тесте
end;

//================================================================
procedure TfrmStart.startClick(Sender: TObject);
begin
if (files.FileName='') then
  begin
  showmessage('Тест не выбран!');
  exit;
  end;
frmStart.Hide;
frmTest.show;
end;

//================================================================
procedure TfrmStart.btnExitClick(Sender: TObject);
begin
frmstart.Close;
end;

//================================================================
procedure TfrmStart.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
frmHelp.Close;
if messagebox(0,'Выйти из программы?','Cercando il vero',
    mb_iconquestion+mb_okcancel+MB_TASKMODAL+MB_TOPMOST)=idcancel
      then canclose:=false;
end;

//================================================================
procedure tfrmstart.ReadHead;//чтение начальной инф-ии о тесте
var tstFile: textfile;
s: string;
begin
if files.FileName='' then exit;
AssignFile(tstFile, files.FileName);
Reset(tstFile);
Readln(tstFile, S);//название
tstName.Text:=s;
qh.Name:=s;
Readln(tstFile, S);//комментарий
tstComment.text:=s;
qh.Comment:=s;
Readln(tstFile, S);//имя папки с картинками
if s<>'' then s:=s+'\';
qh.resD:=filedir+'\tests\'+s;
Readln(tstFile, S);//время на тест
tstTime.Text:=s;
qh.timer:=s;
if s<>'' then
  begin
  TTh:=strtoint(copy(s,1,2));
  TTm:=strtoint(copy(s,4,2));
  TTs:=strtoint(copy(s,7,2));
  end
  else
  begin
  TTh:=0;
  TTm:=0;
  TTs:=0;
  end;
Readln(tstFile, S);//наличие кнопки "пропустить"
frmTest.nextQ.Visible:=strtobool(s);
qh.propusk:=strtobool(s);
Readln(tstFile, S);//доступность режима обучения
Learn.Visible:=strtobool(s);
qh.learn:=strtobool(s);
Readln(tstFile, S);//количество вопросов в тесте
KolQ.Text:=s;
qh.kolQ:=strtoint(s);
closefile(tstFile);
if learn.Visible=false then learn.Checked:=false;
end;

//================================================================
procedure TfrmStart.FormShow(Sender: TObject);
begin
ReadHead();
end;

//================================================================
procedure TfrmStart.btnInfoClick(Sender: TObject);
begin
frmStart.Enabled:=false;
frmHelp.Show;
end;

//================================================================
procedure TfrmStart.FormPaint(Sender: TObject);
var i: integer;
begin
for i:=0 to 9 do
  begin
  frmStart.Canvas.Draw(i*64,0,image3.Picture.Graphic);
  frmStart.Canvas.Draw(i*64,64,image3.Picture.Graphic);
  frmStart.Canvas.Draw(i*64,416,image3.Picture.Graphic);
  frmStart.Canvas.Draw(0,i*64,image3.Picture.Graphic);
  frmStart.Canvas.Draw(576,i*64,image3.Picture.Graphic);
  end;
end;

end.
