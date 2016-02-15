unit Getter.PhysicalDriveList.BruteForce;

interface

uses
  SysUtils, Threading, Classes, Dialogs, Generics.Collections,
  Device.PhysicalDrive, Getter.PhysicalDriveList,
  Device.PhysicalDrive.List, CommandSet.Factory;

type
  TBruteForcePhysicalDriveListGetter = class sealed(TPhysicalDriveListGetter)
  public
    function GetPhysicalDriveList: TPhysicalDriveList; override;
  private
    PhysicalDriveList: TThreadedPhysicalDriveList;
    procedure AddDriveToList(CurrentDrive: Integer);
    procedure IfThisDriveAccessibleAddToList(CurrentDrive: Integer);
    function TryToGetIsDriveAccessible(CurrentDrive: Integer): Boolean;
    procedure TryToGetPhysicalDriveList;
    function IsDriveAccessible(CurrentDrive: Integer): Boolean;
    function LockAndTransfer: TPhysicalDriveList;
  end;

implementation

{ TBruteForcePhysicalDriveGetter }

procedure TBruteForcePhysicalDriveListGetter.AddDriveToList
  (CurrentDrive: Integer);
begin
  try
    PhysicalDriveList.Add(
      TPhysicalDrive.Create(
        TPhysicalDrive.BuildFileAddressByNumber(CurrentDrive)));
  except
    on E: ENoCommandSetException do;
    on E: ENoNVMeDriverException do;
    on OSError: EOSError do
      if OSError.ErrorCode <> 2 then raise;
    else raise;
  end;
end;

function TBruteForcePhysicalDriveListGetter.TryToGetIsDriveAccessible
  (CurrentDrive: Integer): Boolean;
var
  PhysicalDrive: IPhysicalDrive;
begin
  PhysicalDrive :=
    TPhysicalDrive.Create(
      TPhysicalDrive.BuildFileAddressByNumber(CurrentDrive));
  result := PhysicalDrive.IsDriveAvailable;
end;

function TBruteForcePhysicalDriveListGetter.IsDriveAccessible
  (CurrentDrive: Integer): Boolean;
begin
  try
    result := TryToGetIsDriveAccessible(CurrentDrive);
  except
    result := false;
  end;
end;

procedure TBruteForcePhysicalDriveListGetter.IfThisDriveAccessibleAddToList
  (CurrentDrive: Integer);
begin
  if IsDriveAccessible(CurrentDrive) then
    AddDriveToList(CurrentDrive);
end;

procedure TBruteForcePhysicalDriveListGetter.TryToGetPhysicalDriveList;
const
  PHYSICALDRIVE_MAX = 99;
begin
  TParallel.For(0, PHYSICALDRIVE_MAX, procedure (CurrentDrive: Integer)
  begin
    try
      IfThisDriveAccessibleAddToList(CurrentDrive);
    except
      on E: Exception do
        raise E;
    end;
  end);
end;

function TBruteForcePhysicalDriveListGetter.LockAndTransfer:
  TPhysicalDriveList;
var
  LockedList: TList<IPhysicalDrive>;
begin
  LockedList := PhysicalDriveList.LockList;
  result := TPhysicalDriveList.Create;
  result.AddRange(LockedList.ToArray);
  PhysicalDriveList.UnlockList;
end;

function TBruteForcePhysicalDriveListGetter.GetPhysicalDriveList:
  TPhysicalDriveList;
begin
  PhysicalDriveList := TThreadedPhysicalDriveList.Create;
  try
    TryToGetPhysicalDriveList;
  except
    PhysicalDriveList.Clear;
  end;
  result := LockAndTransfer;
  FreeAndNil(PhysicalDriveList);
end;

end.
