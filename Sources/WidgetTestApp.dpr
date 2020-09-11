program WidgetTestApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in 'View.Main.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
