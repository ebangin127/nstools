unit TestCommandSet.Factory;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, CommandSet.Factory, Mock.CommandSets;

type
  // Test methods for class TSCSIBufferInterpreter

  TestTCommandSetFactory = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreatingOrder;
  end;

implementation

procedure TestTCommandSetFactory.SetUp;
begin
end;

procedure TestTCommandSetFactory.TearDown;
begin
end;

procedure TestTCommandSetFactory.TestCreatingOrder;
begin
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfNVMeIntel,
    'CommandOrderOfNVMeIntel');
  CommandSetFactory.GetSuitableCommandSet('');
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfNVMeSamsung,
    'CommandOrderOfNVMeSamsung');
  CommandSetFactory.GetSuitableCommandSet('');
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfATA,
    'CommandOrderOfATA');
  CommandSetFactory.GetSuitableCommandSet('');
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfATALegacy,
    'CommandOrderOfATALegacy');
  CommandSetFactory.GetSuitableCommandSet('');
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfSAT,
    'CommandOrderOfSAT');
  CommandSetFactory.GetSuitableCommandSet('');
  CheckEquals(True, GetCurrentCommandSet = CommandOrderOfNVMeWithoutDriver,
    'CommandOrderOfNVMeWithoutDriver');
  StartExpectingException(ENoNVMeDriverException);
  CommandSetFactory.GetSuitableCommandSet('');
  StopExpectingException('ENoNVMeDriverException');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCommandSetFactory.Suite);
end.

