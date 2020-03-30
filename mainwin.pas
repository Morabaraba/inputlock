unit MainWin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLType, lclintf,
  screenwin;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    FScreenFrm: TScreenForm;
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabeledEdit1: TLabeledEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure UnlockWithEnterOrEscClick(Sender: TObject);
    procedure UnlockWithPassClick(Sender: TObject);
    procedure QuitClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure BitcoinClick(Sender: TObject);
    procedure LitecoinClick(Sender: TObject);
    procedure WWWClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.UnlockWithEnterOrEscClick(Sender: TObject);
begin
  Hide;
  FScreenFrm := TScreenForm.Create(Application, True, LabeledEdit1.Text);
  try
    FScreenFrm.ShowModal;
  finally
    FScreenFrm.Free;
    Show;
  end;
end;

procedure TForm1.UnlockWithPassClick(Sender: TObject);
begin
  Hide;
  FScreenFrm := TScreenForm.Create(Application, False, LabeledEdit1.Text);
  try
    FScreenFrm.ShowModal;
  finally
    FScreenFrm.Free;
    Show;
  end;
end;

procedure TForm1.QuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  Application.MessageBox('To lock input, select passphrase or enter/esc button.', 'Hint', MB_ICONINFORMATION)
end;

procedure TForm1.BitcoinClick(Sender: TObject);
begin
  OpenUrl('bitcoin:395AkXQv4TMW2DyLwMZqX7LDBjLWB7kCia')
end;

procedure TForm1.LitecoinClick(Sender: TObject);
begin
  OpenUrl('litecoin:MVouZNe12WYeAv5yaLjpLf3J4muo9VwzJ6')
end;

procedure TForm1.WWWClick(Sender: TObject);
begin
  OpenUrl('https://gitlab.com/profhound/inputlock')
end;

end.

