unit UnitTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,{showmessage->} Dialogs, ExtCtrls, StdCtrls, Buttons,
  ComCtrls, StrUtils, jpeg, {Spin,} Mask, RXSpin;

type
  TfrmTest = class(TForm)
    Panel1: TPanel;
    okey: TBitBtn;
    nextQ: TBitBtn;
    splitter: TShape;
    pVariants: TPanel;
    toEnd: TTimer;
    query: TMemo;
    lcurQ: TLabel;
    pic: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure toEndTimer(Sender: TObject);
    procedure nextQClick(Sender: TObject);
    procedure okeyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ReadAllQ;//������ �� ����� � ������
    procedure ReadQ;
    procedure psiho;
    procedure selectQ;
    procedure orderQ;
    procedure inputQ;
    procedure propusk;
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TQ = record //������ ��������
    text: string;//����� �������
    resF: string;//���� � ������������ (�������)
    tipQ: string;//��� �������
    count: integer;//���-�� �������
    countV: integer;//���-�� ������
    variants: TStringList;//�������� �������
    ball: integer;//���� �� �����
  end;

var
  q: array of TQ;
  frmTest: TfrmTest;
//  tst: TStringList;
  balls: integer;//��������� ����
  curQ: integer;//������� ������

implementation

uses UnitStart, UnitStat;

{$R *.dfm}

//================================================================
procedure TfrmTest.FormShow(Sender: TObject);
var i: integer;
begin
{������}
if (TTh<>0) or (TTm<>0) or (TTs<>0) then toEnd.Enabled:=true;
frmTest.caption:='������������';
if pVariants.ControlCount<>0 then
  for i:=0 to pVariants.ControlCount-1 do
    pVariants.Controls[0].Destroy;
curQ:=0;
//Qok:=0;
balls:=0;
setlength(q,qh.kolQ);//������ ������ ������� ��������
//kolQ:=strtoint(frmStart.KolQ.Text);
//SetLength(Qs,kolQ);
//for i:=0 to qh.kolQ-1 do Qs[i]:=false;
readAllQ;
ReadQ;
end;

//================================================================
procedure TfrmTest.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if messagebox(0,'������������ ��� �� ���������.'+#13+'�������� ����?',
  'Cercando il vero',mb_iconquestion+mb_okcancel+mb_taskmodal+mb_topmost)
  =idcancel then canclose:=false
  else
  begin
  {-������� ��� �������� ���������� � �������}
  pic.Picture:=nil; pic.Refresh;
//  closefile(tstFile);
  frmStart.Show;
  end;

end;

//================================================================
procedure TfrmTest.toEndTimer(Sender: TObject);
var i: integer;
begin
TTs:=TTs-1;
if TTs<0 then
  begin
  TTs:=59;
  TTm:=TTm-1;
  end;
if TTm<0 then
  begin
  TTm:=59;
  TTh:=TTh-1;
  end;
if (TTh<0) {and (TTm<0) and (TTs<0)} then
  begin
  //����� �����
  toEnd.Enabled:=false;
  messagebox(0,'����� ������������ �������','����� �����',mb_ok+mb_iconinformation);
  for i:=0 to qh.kolQ-1 do q[i].text:='';//�������� ��� �������,
                                    //��� ����������
  ReadQ;
  end;
frmTest.caption:=rightstr('0'+inttostr(TTh),2)+':'+
rightstr('0'+inttostr(TTm),2)+':'+rightstr('0'+inttostr(TTs),2);

end;

//================================================================
procedure TfrmTest.ReadQ;
var
fileext: string;
i: integer;
reslt: boolean;
label nach;
begin
nach:
if curQ>(qh.kolQ-1) then
  begin
    reslt:=true;
    for i:=0 to qh.kolQ-1 do
      if q[i].text<>'' then reslt:=reslt and false;
    if reslt then
      begin
      //������� ���������
      { - ����������, ���������, ����� ����� �������}
      pic.Picture:=nil; pic.Refresh;
      toEnd.Enabled:=false;
      frmTest.Hide;
      frmStat.Show;
      exit;
      end
      else
      begin
      //���� ��� �������
      curQ:=0;
      end;
  //��� ������� ��������. ������������ � ����������� ��������.
//  goto nach;
  //exit;
  end;
//����� �� ������ ���, ������ ���������� ���...
if q[curQ].text='' then
  begin
  inc(curQ);
  goto nach;
  end;

lcurQ.Caption:='������: '+inttostr(curQ+1)+' �� '+inttostr(qh.kolQ);
Query.Text:=q[curQ].text;
fileext:='';
if q[curQ].resF<>'' then
  fileext:=lowercase(ExtractFileExt(q[curQ].resF));
//�������������� ����������� �������:
if (fileext='.jpg') or (fileext='.bmp') or (fileext='.wmf')
  or (fileext='.ico') or (fileext='.jpeg') then
  begin
  pic.Picture.LoadFromFile(qh.resD+q[curQ].resF);
  end;

//Readln(tstFile,S);//��� �������

if q[curQ].tipQ='select' then
  begin
  selectQ;
  exit;
  end;

if q[curQ].tipQ='order' then
  begin
  orderQ;
  exit;
  end;

if q[curQ].tipQ='input' then
  begin
  inputQ;
  exit;
  end;

if q[curQ].tipQ='' then
  begin
  psiho;
  exit;
  end;

end;

//================================================================
procedure TfrmTest.nextQClick(Sender: TObject);
var i: integer;
cc: integer;
begin
pic.Picture:=nil; pic.Refresh;
cc:=pVariants.ControlCount;
Query.Text:='';
for i:=0 to cc-1 do pVariants.Controls[0].Destroy;

inc(curQ);

readQ;

end;

//================================================================
procedure TfrmTest.inputQ;
var
inbox: tedit;
i: integer;
begin
//Readln(tstFile,S);
inbox:=tedit.Create(self);
inbox.Left:=20;
inbox.Top:=20;
inbox.Width:=pVariants.Width-40;
inbox.AutoSize:=false;
inbox.Parent:=frmTest.pVariants;

end;

//================================================================
procedure TfrmTest.orderQ;
var
d, ic: integer;
vibr: string;
kolEl: integer;
i: integer;
//varC1: array of tspinedit;//������ ���������
varC1: array of trxspinedit;
varC2: array of tstatictext;//������ ����. ��� ��������������
begin
{��� ������ �� �������� ������ �������� ��� �������
  - ����� ������ - ����.
  - ������ ������ - ������.}

  kolEl:=q[curQ].count;
  SetLength(varC1,kolEl);
  SetLength(varC2,kolEl);
  for i:=1 to kolEl do vibr:=vibr+RightStr('0'+IntToStr(i),2);
  Randomize;
  for i:=0 to kolEl-1 do
    begin
    d:=random(Length(vibr)div 2);
    //showmessage(inttostr(d)+'/'+inttostr(length(vibr)div 2)+' - '+vibr);
    ic:=StrToInt(MidStr(vibr,d*2+1,2));
    delete(vibr,d*2+1,2);
//    varC1[i]:=tspinedit.Create(self);
    varC1[i]:=trxspinedit.Create(self);
    varC2[i]:=tstatictext.Create(self);
    varC1[i].Top:=ic*40-20;
    varC2[i].Top:=ic*40-20;
    varC1[i].Left:=20;
    varC2[i].Left:=70;
    varC1[i].MinValue:=1;
    varC1[i].MaxValue:=kolEl;
    varC1[i].MaxLength:=2;
    varC2[i].Caption:=q[curQ].variants.Strings[i];
    varC1[i].Width:=45;
    varC2[i].AutoSize:=false;
    varC2[i].Width:=pVariants.Width-90;
    varC1[i].Tag:=i;//������ ����. = ��� ����� �� �������
    varC2[i].Color:=clCream;
    end;
    for i:=0 to kolEl-1 do
      begin
      varC1[i].Parent:=frmTest.pVariants;
      varC2[i].Parent:=frmTest.pVariants;
      end;
pVariants.SetFocus;

end;

//================================================================
procedure TfrmTest.selectQ;
var
d, ic: integer;
vibr: string;
kolV: integer;
kolVV: integer;
i: integer;
varC: array of tcheckbox;//������ checkbox'�� (�������� �������)
begin
kolV:=q[curQ].count;
kolVV:=q[curQ].countV;
SetLength(varC,kolV);
for i:=1 to kolV do vibr:=vibr+RightStr('0'+IntToStr(i),2);
Randomize;
for i:=0 to kolV-1 do
  begin
  d:=random(Length(vibr)div 2);
  //showmessage(inttostr(d)+'/'+inttostr(length(vibr)div 2)+' - '+vibr);
  ic:=StrToInt(MidStr(vibr,d*2+1,2));
  delete(vibr,d*2+1,2);
  varC[i]:=tcheckbox.Create(self);
  varC[i].Top:=ic*40-20;
  varC[i].Left:=20;
//  Readln(tstFile,S);//������ �������� ������
  varC[i].Caption:=q[curQ].variants.Strings[i];
  varC[i].WordWrap:=true;
  varC[i].Width:=pVariants.Width-40;
  varC[i].Color:=clCream;
  if i<kolVV then
    varC[i].Tag:=1
    else
    varC[i].Tag:=0;
  end;
for i:=0 to kolV-1 do varC[i].Parent:=frmTest.pVariants;
pVariants.SetFocus;

end;

//================================================================
procedure TfrmTest.okeyClick(Sender: TObject);
var i, j: integer;
cc: integer;
rs: boolean;
begin
cc:=pVariants.ControlCount;

rs:=true;
if q[curQ].tipQ='' then
  begin
  for i:=0 to cc-1 do
    rs:=rs and not(pVariants.Controls[i] as tradiobutton).Checked;
  if rs then exit;
  end;

pic.Picture:=nil; pic.Refresh;
Query.Text:='';

if q[curQ].tipQ='select' then
  begin
  for i:=0 to cc-1 do
    if ord((pVariants.Controls[i] as tcheckbox).Checked)<>
        ((pVariants.Controls[i] as tcheckbox).Tag) then q[curQ].ball:=0;
  balls:=balls+q[curQ].ball;
  end;

if q[curQ].tipQ='order' then
  begin
  for i:=0 to (cc div 2)-1 do
    if (pVariants.Controls[i*2] as trxspinedit).Value<>
        ((pVariants.Controls[i*2] as trxspinedit).Tag+1) then q[curQ].ball:=0;
  balls:=balls+q[curQ].ball;
  end;

if q[curQ].tipQ='input' then
  begin
    for j:=0 to q[curQ].variants.Count-1 do
      if lowercase((pVariants.Controls[0] as tedit).Text)=lowercase(q[curQ].variants.Strings[j]) then
        begin
        balls:=balls+q[curQ].ball;
//        ballQ:=0;
        end;
  end;

if q[curQ].tipQ='' then
  for i:=0 to cc-1 do
    if (pVariants.Controls[i] as tradiobutton).Checked then
      balls:=balls+(pVariants.Controls[i] as tradiobutton).Tag;

for i:=0 to cc-1 do pVariants.Controls[0].Destroy;

q[curQ].text:='';//�������� ������ ��� ����������
//Qok:=Qok+1;//���� �������
//showmessage(inttostr(balls));

inc(curQ);

readQ;

end;

//================================================================
procedure TfrmTest.propusk;
var i, i2: integer;
tipQ: string;
begin
{Readln(tstFile,S);//������� �������
Readln(tstFile,S);//������� ����� �����������
Readln(tstFile,S);//��� �������
tipQ:=S;
  Readln(tstFile,S);//���-�� ���������
  i2:=strtoint(s);
if tipQ='select' then Readln(tstFile,S);//���-�� ������ ���������
for i:=0 to i2 do
  Readln(tstFile,S);//������� ���� ��������� � ����� �� �����
//ReadQ;}
end;

//================================================================
procedure TfrmTest.psiho;
var
kolV: integer;
i: integer;
//varC: array of tcheckbox;//������ checkbox'�� (�������� �������)
varC: array of tradiobutton;
begin
{Readln(tstFile,S);//���-�� ��������� �������
kolV:=strtoint(s);
SetLength(varC,kolV);
Randomize;
for i:=0 to kolV-1 do
  begin
//  varC[i]:=tcheckbox.Create(self);
varC[i]:=tradiobutton.Create(self);
  varC[i].Top:=i*40+20;
  varC[i].Left:=20;
  Readln(tstFile,S);//������ �������� ������
  varC[i].Caption:=s;
  varC[i].WordWrap:=true;
  varC[i].Width:=pVariants.Width-40;
  varC[i].Color:=clCream;
  Readln(tstFile,S);//���� �� ������� ������
  varC[i].Tag:=strtoint(S);
  end;
for i:=0 to kolV-1 do varC[i].Parent:=frmTest.pVariants;
pVariants.SetFocus;}

end;

//================================================================
procedure TfrmTest.ReadAllQ;
var tstFile: textfile;
s: string;
i, j: integer;
begin
//������� ������ ����� ����� ����� (��� ��� �������):
AssignFile(tstFile, frmStart.files.FileName);
Reset(tstFile);
for i:=1 to 7 do Readln(tstFile, S);
for i:=0 to qh.kolQ-1 do
  begin
  readln(tstFile,s);
  q[i].text:=s;
  readln(tstFile,s);
  q[i].resF:=s;
  readln(tstFile,s);
  q[i].tipQ:=s;
  if s='select' then
    begin
    readln(tstFile,s);
    q[i].count:=strtoint(s);
    readln(tstFile,s);
    q[i].countV:=strtoint(s);
    end
    else
    begin
    readln(tstFile,s);
    q[i].count:=strtoint(s);
    q[i].countV:=0;
    end;
  q[i].variants:=TStringList.Create;
  for j:=0 to q[i].count-1 do
    begin
    readln(tstFile,s);
    q[i].variants.Add(s);
    end;
  readln(tstFile,s);
  q[i].ball:=strtoint(s);
  end;
readln(tstFile,s);
qh.statballs:=strtobool(s);
qh.balls:=TStringList.Create;
while not(eof(tstFile)) do
  begin
  readln(tstFile,s);
  qh.balls.Add(s);
  end;

closefile(tstFile);

end;

//================================================================
procedure TfrmTest.FormCreate(Sender: TObject);
begin
//tst:=TStringList.Create;

end;

end.

