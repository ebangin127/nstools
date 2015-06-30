unit TestAutoNSTSupport;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework,
  uNSTSupport, uAutoNSTSupport;

type
  // Test methods for class TAutoNSTSupport

  TestTAutoNSTSupport = class(TTestCase)
  strict private
    FAutoNSTSupport: TAutoNSTSupport;
    procedure TestSupportStatusWithModelFirmware(Model, Firmware: String);
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //SANDFORCE
    procedure TestHynixSandforceSupport;
    procedure TestMachMXDSFusionSupport;
    procedure TestOCZVertex3Support;
    procedure TestOCZVertex3MaxIOPSSupport;
    procedure TestOCZAgility3Support;
    procedure TestPatriotPyroSupport;
    procedure TestTHNSNSSupport;
    //SUPPORT
    procedure TestCrucialM500Support;
    procedure TestCrucialM550Support;
    procedure TestCrucialMX100Support;
    procedure TestLiteonS100Support;
    procedure TestLiteonS200Support;
    procedure TestLiteonE200Support;
    procedure TestMachMXMMYSupport;
    procedure TestMachJetUltraSupport;
    procedure TestPlextorNinjaSupport;
    procedure TestPlextorM3PSupport;
    procedure TestPlextorM5SSupport;
    procedure TestPlextorM5PSupport;
    procedure TestPlextorM5ProSupport;
    procedure TestSamsung470Support;
    procedure TestSamsung830Support;
    procedure TestSamsung840Support;
    procedure TestSamsung840EVOSupport;
    procedure TestSamsung840ProSupport;
    procedure TestSamsung850EVOSupport;
    procedure TestSamsung850ProSupport;
    procedure TestSandiskX110Support;
    procedure TestSeagate600Support;
    procedure TestToshibaQFSupport;
    procedure TestToshibaQHSupport;
    procedure TestToshibaQProSupport;
    procedure TestPhisonCT7Support;
  end;

implementation

procedure TestTAutoNSTSupport.SetUp;
begin
  FAutoNSTSupport := TAutoNSTSupport.Create;
end;

procedure TestTAutoNSTSupport.TearDown;
begin
  FAutoNSTSupport.Free;
  FAutoNSTSupport := nil;
end;

procedure TestTAutoNSTSupport.TestHynixSandforceSupport;
begin
  TestSupportStatusWithModelFirmware('HYNIX HFS120G3AMNM', '10301A00');
end;

procedure TestTAutoNSTSupport.TestMachMXDSFusionSupport;
begin
  TestSupportStatusWithModelFirmware('MXSSD3MDSF-120G', '5.04');
end;

procedure TestTAutoNSTSupport.TestPatriotPyroSupport;
begin
  TestSupportStatusWithModelFirmware('Patriot Pyro', '319ABBF0');
end;

procedure TestTAutoNSTSupport.TestTHNSNSSupport;
begin
  TestSupportStatusWithModelFirmware('TOSHIBA THNSNS120GBSP', 'TA5ABBF0');
end;

procedure TestTAutoNSTSupport.TestOCZAgility3Support;
begin
  TestSupportStatusWithModelFirmware('OCZ-AGILITY3', '2.06');
end;

procedure TestTAutoNSTSupport.TestOCZVertex3MaxIOPSSupport;
begin
  TestSupportStatusWithModelFirmware('OCZ-VERTEX3 MI', '2.22');
end;

procedure TestTAutoNSTSupport.TestOCZVertex3Support;
begin
  TestSupportStatusWithModelFirmware('OCZ-VERTEX3', '2.15');
end;

procedure TestTAutoNSTSupport.TestCrucialM500Support;
begin
  TestSupportStatusWithModelFirmware('Crucial_CT120M500SSD1', 'MU05');
  TestSupportStatusWithModelFirmware('Crucial_CT120M500SSD3', 'MU05');
end;

procedure TestTAutoNSTSupport.TestCrucialM550Support;
begin
  TestSupportStatusWithModelFirmware('Crucial_CT128M550SSD1', 'MU02');
  TestSupportStatusWithModelFirmware('Crucial_CT128M550SSD3', 'MU02');
end;

procedure TestTAutoNSTSupport.TestCrucialMX100Support;
begin
  TestSupportStatusWithModelFirmware('Crucial_CT128MX100SSD1', 'MU02');
  TestSupportStatusWithModelFirmware('Crucial_CT128MX100SSD3', 'MU02');
end;

procedure TestTAutoNSTSupport.TestLiteonE200Support;
begin
  TestSupportStatusWithModelFirmware('LITEONIT E200-160', 'VF81');
end;

procedure TestTAutoNSTSupport.TestLiteonS100Support;
begin
  TestSupportStatusWithModelFirmware('LITEONIT S100-256', 'VB83');
end;

procedure TestTAutoNSTSupport.TestLiteonS200Support;
begin
  TestSupportStatusWithModelFirmware('LITEONIT LAM-256M3S', 'WBA1');
end;

procedure TestTAutoNSTSupport.TestMachJetUltraSupport;
begin
  TestSupportStatusWithModelFirmware('MXSSD2MJTU-128G', 'UNKNOWN');
end;

procedure TestTAutoNSTSupport.TestMachMXMMYSupport;
begin
  TestSupportStatusWithModelFirmware('MXSSD3MMY-128G', 'V1707');
end;

procedure TestTAutoNSTSupport.TestPlextorM3PSupport;
begin
  TestSupportStatusWithModelFirmware('PLEXTOR PX-128M3P', '1.01');
end;

procedure TestTAutoNSTSupport.TestPlextorM5ProSupport;
begin
  TestSupportStatusWithModelFirmware('PLEXTOR PX-128M5Pro', '1.07');
end;

procedure TestTAutoNSTSupport.TestPlextorM5PSupport;
begin
  TestSupportStatusWithModelFirmware('PLEXTOR PX-128M5P', '1.07');
end;

procedure TestTAutoNSTSupport.TestPlextorM5SSupport;
begin
  TestSupportStatusWithModelFirmware('PLEXTOR PX-128M5S', '1.05');
end;

procedure TestTAutoNSTSupport.TestPlextorNinjaSupport;
begin
  TestSupportStatusWithModelFirmware('Ninja-256', '1.00');
end;

procedure TestTAutoNSTSupport.TestSamsung470Support;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG 470 Series', 'AXM0601Q');
end;

procedure TestTAutoNSTSupport.TestSamsung830Support;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 830 Series', 'CXM03B1Q');
end;

procedure TestTAutoNSTSupport.TestSamsung840EVOSupport;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 840 EVO 250GB', 'EXT0AB0Q');
end;

procedure TestTAutoNSTSupport.TestSamsung840ProSupport;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 840 Pro Series', 'DXM02B0Q');
end;

procedure TestTAutoNSTSupport.TestSamsung840Support;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 840 Series', 'DXT06B0Q');
end;

procedure TestTAutoNSTSupport.TestSamsung850EVOSupport;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 850 EVO 120GB', 'EMT01B6Q');
end;

procedure TestTAutoNSTSupport.TestSamsung850ProSupport;
begin
  TestSupportStatusWithModelFirmware('SAMSUNG SSD 850 PRO 512GB', 'EXM01B6Q');
end;

procedure TestTAutoNSTSupport.TestSandiskX110Support;
begin
  TestSupportStatusWithModelFirmware('SanDisk SD6SB1M256G1022I', 'X230600');
end;

procedure TestTAutoNSTSupport.TestSeagate600Support;
begin
  TestSupportStatusWithModelFirmware('ST480HM000', 'B660');
end;

procedure TestTAutoNSTSupport.TestToshibaQFSupport;
begin
  TestSupportStatusWithModelFirmware('TOSHIBA THNSNF256GBSS', 'FSXAN104');
end;

procedure TestTAutoNSTSupport.TestToshibaQHSupport;
begin
  TestSupportStatusWithModelFirmware('TOSHIBA THNSNH128GBST', 'HTRAN101');
end;

procedure TestTAutoNSTSupport.TestToshibaQProSupport;
begin
  TestSupportStatusWithModelFirmware('TOSHIBA THNSNJ128GCST', 'JTRA0102');
end;

procedure TestTAutoNSTSupport.TestPhisonCT7Support;
begin
  TestSupportStatusWithModelFirmware('SATA SSD', 'SAFM00.f');
  TestSupportStatusWithModelFirmware('SATA SSD', 'SAFM01.3');
end;

procedure TestTAutoNSTSupport.TestSupportStatusWithModelFirmware(Model,
  Firmware: String);
begin
  FAutoNSTSupport.SetModelAndFirmware(Model, Firmware);
  CheckTrue(FAutoNSTSupport.GetSupportStatus.Supported,
    'Model: ' + Model + ' Firmware: ' + Firmware);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAutoNSTSupport.Suite);
end.

