unit Support.NVMe.Samsung;

interface

uses
  SysUtils, Math,
  Support, Device.SMART.List;

type
  TSamsungNVMeSupport = class sealed(TNSTSupport)
  private
    InterpretingSMARTValueList: TSMARTValueList;
    function GetSemiSupport: TSupportStatus;
    function GetTotalWrite: TTotalWrite;
    function IsProductOfSamsung: Boolean;
    function IsSamsungOtherSSD: Boolean;
    function IsSamsungNVMe: Boolean;
  public
    function GetSupportStatus: TSupportStatus; override;
    function GetSMARTInterpreted(SMARTValueList: TSMARTValueList):
      TSMARTInterpreted; override;
  end;

implementation

{ TSamsungNVMeSupport }

function TSamsungNVMeSupport.IsSamsungOtherSSD: Boolean;
begin
  result :=
    Pos('SSD', UpperCase(Model)) > 0;
end;

function TSamsungNVMeSupport.IsSamsungNVMe: Boolean;
begin
  result :=
    Pos('BX', UpperCase(Firmware)) = 5;
end;

function TSamsungNVMeSupport.IsProductOfSamsung: Boolean;
begin
  result :=
    (Pos('SAMSUNG', UpperCase(Model)) > 0) and
    IsSamsungOtherSSD and IsSamsungNVMe;
end;

function TSamsungNVMeSupport.GetSemiSupport: TSupportStatus;
begin
  result.Supported := true;
  result.FirmwareUpdate := false;
  result.TotalWriteType := TTotalWriteType.WriteSupportedAsValue;
end;

function TSamsungNVMeSupport.GetSupportStatus: TSupportStatus;
begin
  result.Supported := false;
  if IsProductOfSamsung then
    result := GetSemiSupport;
end;

function TSamsungNVMeSupport.GetTotalWrite: TTotalWrite;
  function LBAToMB(const SizeInLBA: Int64): UInt64;
  begin
    result := SizeInLBA shr 1;
  end;
const
  IDOfHostWrite = 5;
var
  RAWValue: UInt64;
begin
  result.InValue.TrueHostWriteFalseNANDWrite := true;
  RAWValue :=
    InterpretingSMARTValueList.GetRAWByID(IDOfHostWrite);
  result.InValue.ValueInMiB := LBAToMB(RAWValue);
end;

function TSamsungNVMeSupport.GetSMARTInterpreted(
  SMARTValueList: TSMARTValueList): TSMARTInterpreted;
const
  IDOfEraseError = 12;
  IDOfReplacedSector = 5;
  IDOfUsedHour = 10;
  ReplacedSectorThreshold = 50;
  EraseErrorThreshold = 10;
begin
  InterpretingSMARTValueList := SMARTValueList;
  result.TotalWrite := GetTotalWrite;
  result.UsedHour :=
    InterpretingSMARTValueList.GetRAWByID(IDOfUsedHour);
  result.ReadEraseError.TrueReadErrorFalseEraseError := true;
  result.ReadEraseError.Value :=
    InterpretingSMARTValueList.GetRAWByID(IDOfEraseError);
  result.SMARTAlert.ReadEraseError :=
    result.ReadEraseError.Value >= EraseErrorThreshold;
  result.ReplacedSectors := 0;
  result.SMARTAlert.ReplacedSector :=
    result.ReplacedSectors >= ReplacedSectorThreshold;
end;

end.