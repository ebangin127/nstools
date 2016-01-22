unit TestAverageCountLogger;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Windows, AverageLogger, AverageLogger.Count,
  Dialogs, Classes, Sysutils, Math;

type
  TInput = record
    FileContents: TStringList;
    NewValue: String;
  end;

  TListCheckFunction =
    function (Input: TStringList): Boolean;

  TExpectedValue = record
    TodayDelta: String;
    Period: TAveragePeriod;
    FormattedAverageValue: String;
  end;

  // Test methods for class TAverageLogger
  TestTAverageCountLogger = class(TTestCase)
  public
    procedure SetUp; override;
  private
    AverageCountLogger: TAverageCountLogger;
    UserDefaultFormat: TFormatSettings;
    procedure TestByExpectedValue(Input: TInput;
      ExpectedResult: TExpectedValue; ListCheckFunction: TListCheckFunction);
    procedure CheckEquality(TodayDelta: String; OutputList: TStringList;
      PeriodAverageResult: TPeriodAverage; ExpectedResult: TExpectedValue;
      ListCheckFunction: TListCheckFunction);
  published
    procedure TestBuildFileName;
    procedure TestBlankToZero;
    procedure TestBlankToOtherValue;
    procedure TestSomeValueToOtherValue;
    procedure Test30DaysAverage;
    procedure Test90DaysAverage;
    procedure TestOver180Days;
  end;

implementation

procedure TestTAverageCountLogger.TestByExpectedValue(
  Input: TInput; ExpectedResult: TExpectedValue;
  ListCheckFunction: TListCheckFunction);
var
  PeriodAverageResult: TPeriodAverage;
begin
  AverageCountLogger := TAverageCountLogger.Create(Input.FileContents);
  AverageCountLogger.ReadAndRefresh(Input.NewValue);
  PeriodAverageResult := AverageCountLogger.GetMaxPeriodFormattedAverage;
  CheckEquality(AverageCountLogger.GetFormattedTodayDelta, Input.FileContents,
    PeriodAverageResult, ExpectedResult, @ListCheckFunction);
  FreeAndNil(AverageCountLogger);
end;

procedure TestTAverageCountLogger.CheckEquality(
  TodayDelta: String; OutputList: TStringList;
  PeriodAverageResult: TPeriodAverage; ExpectedResult: TExpectedValue;
  ListCheckFunction: TListCheckFunction);
begin
  CheckEqualsString(ExpectedResult.TodayDelta,
    AverageCountLogger.GetFormattedTodayDelta, 'TodayDelta');
  CheckEquals(Ord(ExpectedResult.Period),
    Ord(PeriodAverageResult.Period), 'Period');
  CheckEqualsString(ExpectedResult.FormattedAverageValue,
    PeriodAverageResult.FormattedAverageValue, 'AverageValue');
  if @ListCheckFunction <> nil then
    CheckTrue(ListCheckFunction(OutputList), 'ListCheckFunction');
end;

procedure TestTAverageCountLogger.TestBuildFileName;
begin
  CheckEquals('@Folder@\ WriteLog @Serial@ .txt',
    TAverageCountLogger.BuildFileName('@Folder@\ ', ' @Serial@ '));
end;

procedure TestTAverageCountLogger.TestBlankToZero;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '0.0'; Period: Days30; FormattedAverageValue: '0.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  Input.NewValue := '0';
  TestByExpectedValue(Input, ExpectedInThisScenario, nil);
end;

procedure TestTAverageCountLogger.SetUp;
begin
  UserDefaultFormat := TFormatSettings.Create(GetUserDefaultLCID);
  UserDefaultFormat.DateSeparator := '-';
end;

procedure TestTAverageCountLogger.TestBlankToOtherValue;
  function ListCheckFunction(Input: TStringList): Boolean;
  begin
    result :=
      (Input.Count = 2) and
      (Input[1] = '10');
  end;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '0.0'; Period: Days30; FormattedAverageValue: '0.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  Input.NewValue := '10';
  TestByExpectedValue(Input, ExpectedInThisScenario, @ListCheckFunction);
end;

procedure TestTAverageCountLogger.TestSomeValueToOtherValue;
  function ListCheckFunction(Input: TStringList): Boolean;
  begin
    result :=
      (Input.Count = 4) and
      (Input[1] = '20') and
      (Input[3] = '10');
  end;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '10.0'; Period: Days30; FormattedAverageValue: '5.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  Input.FileContents.Add(FormatDateTime('yy/mm/dd', Now - 1));
  Input.FileContents.Add('10');
  Input.NewValue := '20';
  TestByExpectedValue(Input, ExpectedInThisScenario, @ListCheckFunction);
end;

procedure TestTAverageCountLogger.Test30DaysAverage;
  function ListCheckFunction(Input: TStringList): Boolean;
  begin
    result :=
      (Input.Count = 4) and
      (Input[1] = '310') and
      (Input[3] = '10');
  end;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '300.0'; Period: Days90; FormattedAverageValue: '10.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  //29days because of ceil ->
  Input.FileContents.Add(FormatDateTime('yy/mm/dd', Now - 29));
  Input.FileContents.Add('10');
  Input.NewValue := '310';
  TestByExpectedValue(Input, ExpectedInThisScenario, @ListCheckFunction);
end;

procedure TestTAverageCountLogger.Test90DaysAverage;
  function ListCheckFunction(Input: TStringList): Boolean;
  begin
    result :=
      (Input.Count = 4) and
      (Input[1] = '910') and
      (Input[3] = '10');
  end;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '900.0'; Period: Days180; FormattedAverageValue: '10.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  //89days because of ceil ->
  Input.FileContents.Add(FormatDateTime('yy/mm/dd', Now - 89));
  Input.FileContents.Add('10');
  Input.NewValue := '910';
  TestByExpectedValue(Input, ExpectedInThisScenario, @ListCheckFunction);
end;

procedure TestTAverageCountLogger.TestOver180Days;
  function ListCheckFunction(Input: TStringList): Boolean;
  begin
    result :=
      (Input.Count = 2) and
      (Input[1] = '10');
  end;
const
  ExpectedInThisScenario: TExpectedValue =
    (TodayDelta: '0.0'; Period: Days30; FormattedAverageValue: '0.0');
var
  Input: TInput;
begin
  Input.FileContents := TStringList.Create;
  Input.FileContents.Add(FormatDateTime('yy/mm/dd', Now - 181));
  Input.FileContents.Add('5');
  Input.NewValue := '10';
  TestByExpectedValue(Input, ExpectedInThisScenario, @ListCheckFunction);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAverageCountLogger.Suite);
end.

