unit ScreenWin;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls;

type

  { TScreenForm }

  TScreenForm = class(TForm)
    Timer1: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormMouseMove(Sender: TObject;
      {%H-}Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; {%H-}Button: TMouseButton;
      {%H-}Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
     FixedMyInput: Boolean;
     Testing: Boolean;
     CurrentInputStr: string;
     Pass: string;
  protected
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
  public
     FixMyInputStr: string;

     constructor Create(TheOwner: TComponent; aTesting: Boolean; aPass: string);
  end;

var
  ScreenForm: TScreenForm;

implementation

{$R *.lfm}

Function IsKeyDown(Const VirtualKeyCode: Integer): Boolean; Inline;
Begin
  Result:= (GetKeyState(VirtualKeyCode) And $80) <> 0;
End;

{ TScreenForm }

procedure TScreenForm.CMHintShow(var Message: TCMHintShow);
begin
  with TCMHintShow(Message) do
    if not ShowHint then
      Message.Result := 1;

  inherited;
end;

constructor TScreenForm.Create(TheOwner: TComponent; aTesting: Boolean;
  aPass: string);
begin
  inherited Create(TheOwner);

  FixedMyInput:= False;
  Testing := aTesting;
  Pass := LowerCase(aPass);
end;

procedure TScreenForm.FormCreate(Sender: TObject);
begin
  Brush.Style := bsClear;
  Align:= alClient;
end;

procedure TScreenForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := FixedMyInput;
end;

procedure TScreenForm.FormHide(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TScreenForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Testing and ((key = VK_ESCAPE) or (key = VK_RETURN)) then
  begin
    FixedMyInput:= True;
    Close;
  end;

  if (ssAlt in Shift) then
    Hide;
end;

procedure TScreenForm.FormKeyPress(Sender: TObject; var Key: char);
var
  at: integer;
begin
  CurrentInputStr := CurrentInputStr + LowerCase(key);
  at:= length(CurrentInputStr);

  if CurrentInputStr[at] <> pass[at] then
    CurrentInputStr := '';

  if CurrentInputStr = pass then
  begin
    FixedMyInput := true;
    close;
  end
end;

procedure TScreenForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Application.ProcessMessages;
end;

procedure TScreenForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TScreenForm.FormShow(Sender: TObject);
begin
  Width := Screen.DesktopWidth;
  Height := Screen.DesktopHeight;
  Left := Screen.DesktopLeft;
  Top := Screen.DesktopTop;
end;

procedure TScreenForm.Timer1Timer(Sender: TObject);
begin
  if not IsKeyDown(VK_MENU) then
  begin
    Show;
    Timer1.Enabled:= False;
  end;
end;

end.
