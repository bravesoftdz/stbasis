unit Main;
{ ������ ���������� ��� }

procedure ViewInterface;
var
  ct: TObject;
begin
  ct:=TObject.Create(nil);
  try

  finally
    ct.Free;
  end;
end;

end.
