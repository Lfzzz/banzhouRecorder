; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppId "{{DF9A3D1D-C83B-4F97-B49C-8FBDCBBBB883}"
#define MyAppName "????¼??"
#define MyAppNameZh "????¼??"
#define MyAppVersion "1.0"
#define MyAppPublisher "??????"
#define MyAppExeName "????¼??.exe"
#define MyAppURL ""
; ?????ļ?
#define SourceMain "D:\electron_Project\bzlp1\dist_electron\win-unpacked\????¼??.exe"
#define SourceFolder "D:\electron_Project\bzlp1\dist_electron\win-unpacked\*"
#define SetupIconFilePath "D:\electron_Project\bzlp1\src\assets\images\logo.ico"
#define ResourcesPath "D:\electron_Project\mh2\*"
; license?ļ?
#define LicenseFilePath "D:\electron_Project\mh2\license.txt"
; ????????λ??
#define OutputPath "D:\electron_Project\"
#define OutputFileName "????¼??"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile={#LicenseFilePath}
OutputDir={#OutputPath}
OutputBaseFilename={#OutputFileName}v{#MyAppVersion}
SetupIconFile=D:\electron_Project\bzlp1\src\assets\images\logo.ico
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
Uninstallable=yes
UninstallDisplayName={#MyAppNameZh}
Versioninfodescription={#MyAppName} ??װ????
versioninfocopyright=Copyright(c) 2022
VersionInfoProductName={#MyAppName}
DisableReadyPage=yes
DisableProgramGroupPage=yes
DirExistsWarning=no
DisableDirPage=yes

[Languages]
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
Source: {#ResourcesPath}; DestDir: {tmp}; Flags: dontcopy solidbreak ; Attribs: hidden system
Source: {#SourceMain}; DestDir: "{app}"; Flags: ignoreversion
Source: {#SourceFolder}; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Messages]
SetupAppTitle={#MyAppName} ??װ????
SetupWindowTitle={#MyAppName} ??װ????

[Icons]
Name: "{commondesktop}\{#MyAppNameZh}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{group}\{#MyAppNameZh}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\ж??{#MyAppNameZh}"; Filename: "{uninstallexe}"

[Code]
type
  TBtnEventProc = procedure (h:HWND);
  TPBProc = function(h:hWnd;Msg,wParam,lParam:Longint):Longint;  //?ٷֱ?
  TTimerProc = procedure(h:longword; msg:longword; idevent:longword; dwTime:longword);
const
  Radius  = 9;
  GWL_EXSTYLE = (-20);
  //?????ƶ?
  WM_SYSCOMMAND = $0112;
  WS_EX_LAYERED = $80000;
  WS_EX_TRANSPARENT = $20;
  LWA_COLORKEY = 1;
  TransparentColor = clLime;  //Ҫȥ????ͼƬ??ɫ
  TransparentPercent = 80;
  BTN_MAX_PATH = 1024;

  BtnClickEventID      = 1;
  BtnMouseEnterEventID = 2;
  BtnMouseLeaveEventID = 3;
  BtnMouseMoveEventID  = 4;
  BtnMouseDownEventID  = 5;
  BtnMouseUpEventID    = 6;

//function WrapBtnCallback(Callback: TBtnEventProc; ParamCount: Integer): Longword;  external 'wrapcallback@files:innocallback.dll stdcall';
function  WrapTimerProc(callback: TTimerProc; Paramcount: Integer): Longword; external 'wrapcallback@files:innocallback.dll stdcall';

function  DeleteObject(p1: Longword): BOOL; external 'DeleteObject@gdi32.dll stdcall';
function  GetPM(nIndex:Integer):Integer; external 'GetSystemMetrics@user32.dll stdcall';
//botva2
function  ImgLoad(Wnd :HWND; FileName :PAnsiChar; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean) :Longint; external 'ImgLoad@{tmp}\botva2.dll stdcall delayload';
procedure ImgSetVisibility(img :Longint; Visible :boolean); external 'ImgSetVisibility@{tmp}\botva2.dll stdcall delayload';
procedure ImgApplyChanges(h:HWND); external 'ImgApplyChanges@{tmp}\botva2.dll stdcall delayload';
procedure ImgSetPosition(img :Longint; NewLeft, NewTop, NewWidth, NewHeight :integer); external 'ImgSetPosition@files:botva2.dll stdcall';
procedure ImgRelease(img :Longint); external 'ImgRelease@{tmp}\botva2.dll stdcall delayload';
procedure gdipShutdown;  external 'gdipShutdown@{tmp}\botva2.dll stdcall delayload';
function  WrapBtnCallback(Callback: TBtnEventProc; ParamCount: Integer): Longword; external 'wrapcallback@{tmp}\innocallback.dll stdcall delayload';
function  BtnCreate(hParent:HWND; Left,Top,Width,Height:integer; FileName:PAnsiChar; ShadowWidth:integer; IsCheckBtn:boolean):HWND;  external 'BtnCreate@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetText(h:HWND; Text:PAnsiChar);  external 'BtnSetText@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetVisibility(h:HWND; Value:boolean); external 'BtnSetVisibility@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetFont(h:HWND; Font:Cardinal); external 'BtnSetFont@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetFontColor(h:HWND; NormalFontColor, FocusedFontColor, PressedFontColor, DisabledFontColor: Cardinal); external 'BtnSetFontColor@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetEvent(h:HWND; EventID:integer; Event:Longword); external 'BtnSetEvent@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetCursor(h:HWND; hCur:Cardinal); external 'BtnSetCursor@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetEnabled(h:HWND; Value:boolean); external 'BtnSetEnabled@{tmp}\botva2.dll stdcall delayload';
function  GetSysCursorHandle(id:integer):Cardinal; external 'GetSysCursorHandle@{tmp}\botva2.dll stdcall delayload';
function  BtnGetChecked(h:HWND):boolean; external 'BtnGetChecked@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetChecked(h:HWND; Value:boolean); external 'BtnSetChecked@{tmp}\botva2.dll stdcall delayload';
procedure CreateFormFromImage(h:HWND; FileName:PAnsiChar); external 'CreateFormFromImage@{tmp}\botva2.dll stdcall delayload';
procedure BtnSetPosition(h:HWND; NewLeft, NewTop, NewWidth, NewHeight: integer);  external 'BtnSetPosition@{tmp}\botva2.dll stdcall delayload';
function  SetLayeredWindowAttributes(hwnd:HWND; crKey:Longint; bAlpha:byte; dwFlags:longint ):longint;
external  'SetLayeredWindowAttributes@user32 stdcall'; //????????
function  SetWindowLong(Wnd: HWnd; Index: Integer; NewLong: Longint): Longint; external 'SetWindowLongA@user32.dll stdcall';
function  PBCallBack(P:TPBProc;ParamCount:integer):LongWord; external 'wrapcallback@files:innocallback.dll stdcall';
function  CallWindowProc(lpPrevWndFunc: Longint; hWnd: HWND; Msg: UINT; wParam, lParam: Longint): Longint; external 'CallWindowProcA@user32.dll stdcall';
procedure ImgSetVisiblePart(img:Longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetVisiblePart@files:botva2.dll stdcall';
function  SetTimer(hWnd: LongWord; nIDEvent, uElapse: LongWord; lpTimerFunc: LongWord): LongWord; external 'SetTimer@user32.dll stdcall';
function  KillTimer(hWnd: LongWord; nIDEvent: LongWord): LongWord; external 'KillTimer@user32.dll stdcall';
function  GetWindowLong(Wnd: HWnd; Index: Integer): Longint; external 'GetWindowLongA@user32.dll stdcall';
function  ReleaseCapture(): Longint; external 'ReleaseCapture@user32.dll stdcall';
function  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THandle; external 'CreateRoundRectRgn@gdi32 stdcall';
function  SetWindowRgn(hWnd: HWND; hRgn: THandle; bRedraw: Boolean): Integer; external 'SetWindowRgn@user32 stdcall';
procedure shape_form_round(aForm : TForm; edgeSize : integer);
  var
    FormRegion : longword;
  begin
    FormRegion := CreateRoundRectRgn(0, 0, aForm.ClientWidth, aForm.ClientHeight, edgeSize, edgeSize);
    SetWindowRgn(aForm.Handle, FormRegion, True);
  end;

// ??װǰǿ??ɱ??
// ?ú????ڰ?װ??????ʼ??ʱ???ã?????False ???жϰ?װ??True????????װ.??
function InitializeSetup(): Boolean;
  var ErrorCode: Integer;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppName}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;

// ж??ǰǿ??ɱ????
function InitializeUninstall(): Boolean;
  var ErrorCode: Integer;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppName}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;

var
  BGimg:longint;
  btnShowLicense,MinBtn,CancelBtn,btnBrowser,btnSetup,btnBack:HWND;
  isWelcomePage:boolean;
  pathEdit:tedit;
  labelReadImg,licenseImg,progressbgImg,PBOldProc,labelAutoRunImg:longint;
  checkboxLicense,checkboxAutoRun:HWND;
  licenseRich:TRichEditViewer;

// ?򵼵????????¼?????ȷ???Ƿ???????ҳ??????һ??????ҳ (??PageID ָ??) ??ʾ??????????True??????????ҳ???????㷵??False????ҳ????ʾ??
// ע??: ?????¼?????????wpWelcome??wpPreparing ??wpInstalling ҳ???ã????а?װ?????Ѿ?ȷ??Ҫ??????ҳҲ????????
// wpWelcome, wpLicense, wpPassword, wpInfoBefore, wpUserInfo, wpSelectDir, wpSelectComponents, wpSelectProgramGroup, wpSelectTasks, wpReady, wpPreparing, wpInstalling, wpInfoAfter, wpFinished
function ShouldSkipPage(PageID: Integer): Boolean;
  begin
    if PageID=wpLicense then
      result:=true;
    if PageID=wpInfoBefore then
      result:=true;
    if PageID=wpUserInfo then
      result:=true;
    if PageID=wpSelectDir then
      result:=true;
    if PageID=wpSelectComponents then
      result:=true;
    if PageID=wpSelectProgramGroup then
      result:=true;
    if PageID=wpSelectTasks then
      result:=true;
  end;

// ?رհ?ť
procedure CancelBtnOnClick(hBtn:HWND);
  begin
    WizardForm.CancelButton.OnClick(WizardForm);
  end;

// ??С????ť
procedure MinBtnOnClick(hBtn:HWND);
  begin
    SendMessage(WizardForm.Handle,WM_SYSCOMMAND,61472,0);
  end;

// ?????ļ??а?ť
procedure btnBrowserclick(hBtn:HWND);
  begin
    WizardForm.DirBrowseButton.OnClick(WizardForm);
    pathEdit.text := WizardForm.DirEdit.text;
  end;

// ·??ѡ???? change
procedure pathEditChange(Sender: TObject);
  begin
    WizardForm.DirEdit.text:=pathEdit.Text ;
  end;

// ??????װ?Ȱ?ť?Ĳ??????ǲ??ϵ???һ??
procedure nextSetpBtnClick(hBtn:HWND);
  begin
    WizardForm.NextButton.OnClick(WizardForm);
  end;

// ??װ?Ľ?????
function PBProc(h:hWnd;Msg,wParam,lParam:Longint):Longint;
  var
    pr,i1,i2 : Extended;
    w : integer;
  begin
    Result:=CallWindowProc(PBOldProc,h,Msg,wParam,lParam);
    if (Msg=$402) and (WizardForm.ProgressGauge.Position>WizardForm.ProgressGauge.Min) then
    begin
      i1:=WizardForm.ProgressGauge.Position-WizardForm.ProgressGauge.Min;
      i2:=WizardForm.ProgressGauge.Max-WizardForm.ProgressGauge.Min;
      pr:=i1*100/i2;
      w:=Round(650*pr/100);
      ImgSetPosition(progressbgImg,0,320,w,15);
      ImgSetVisiblePart(progressbgImg,0,0,w,15);
      ImgApplyChanges(WizardForm.Handle);
    end;
  end;

// ?????϶?
procedure WizardMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    ReleaseCapture
    SendMessage(WizardForm.Handle, $0112, $F012, 0)
  end;

// ?鿴 license
procedure btnShowLicenseClick(hBtn:HWND);
  begin
    if isWelcomePage=true then
    begin
      licenseImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_license.png'),0,0,650,450,false,false);
      isWelcomePage:=false
      licenseRich.Height:=295
      BtnSetVisibility(checkboxLicense,false)
      BtnSetVisibility(btnShowLicense,false)
      BtnSetVisibility(btnSetup,false)
      BtnSetVisibility(btnBrowser,false)
      pathEdit.Hide
      BtnSetVisibility(btnBack,true)
    end else
    begin
      isWelcomePage:=true
      BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_welcome.png'),0,0,650,450,false,true);
      labelReadImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_read.png'),243,398,72,20,false,true);
      licenseRich.Height:=0
      BtnSetVisibility(checkboxLicense,true)
      BtnSetVisibility(btnShowLicense,true)
      BtnSetVisibility(btnSetup,true)
      ImgRelease(licenseImg)
      BtnSetVisibility(btnBrowser,true)
      pathEdit.show
      BtnSetVisibility(btnBack,false)
    end;
      ImgApplyChanges(WizardForm.Handle)
  end;

// ??ѡ?鿴 license
procedure checkboxLicenseClick(hBtn:HWND);
  begin
    if BtnGetChecked(checkboxLicense)=true then
    begin
      BtnSetEnabled(btnSetup,true)
    end else
    begin
      BtnSetEnabled(btnSetup,false)
    end
  end;

// ?ù????ڿ?ʼ??ʱ???ı??򵼻???????ҳ????Ҫָ??ʹ??InitializeSetup????ʵ?ָı?????ҳ?Ĺ??ܣ???ΪInitializeSetup????????ʱ?򵼴??ڲ??????ڡ?
procedure InitializeWizard();
  var 
      MainLabel: TLabel;
  begin
    // ???û?ӭ????ҳ?ĳߴ???С
    WizardForm.OuterNotebook.hide;
    WizardForm.Bevel.Hide;
    WizardForm.BorderStyle:=bsnone;
    WizardForm.Position:=poScreenCenter;
    // WizardForm.Center;
    WizardForm.Width:=650;
    WizardForm.Height:=450;
    // WizardForm.Color:=clWhite;
    isWelcomePage:=true;
    // WizardForm.InnerNotebook.Hide;
    // wizardform.Color:=TransparentColor;

    // ???ӿ????϶????ڵ?Label
    MainLabel := TLabel.Create(WizardForm);
    MainLabel.Parent := WizardForm;
    MainLabel.AutoSize := False;
    MainLabel.Left := 0;
    MainLabel.Top := 0;
    MainLabel.Width := WizardForm.Width;
    MainLabel.Height := WizardForm.Height;
    MainLabel.Caption := '';
    MainLabel.Transparent := True;
    MainLabel.OnMouseDown := @WizardMouseDown;

    // ??????Դ?? tmp ??ʱĿ¼
    ExtractTemporaryFile('bg_welcome.png');
    ExtractTemporaryFile('bg_installing.png');
    ExtractTemporaryFile('bg_license.png');
    ExtractTemporaryFile('label_read.png');
    ExtractTemporaryFile('label_license.png');
    ExtractTemporaryFile('license.txt');
    ExtractTemporaryFile('btn_close.png');
    ExtractTemporaryFile('btn_min.png');
    ExtractTemporaryFile('btn_back.png');
    ExtractTemporaryFile('btn_setup.png');
    ExtractTemporaryFile('btn_browser.png');
    ExtractTemporaryFile('checkbox.png');
    ExtractTemporaryFile('bg_finished.png');
    ExtractTemporaryFile('btn_complete.png');
    ExtractTemporaryFile('loading.png');
    ExtractTemporaryFile('label_autorun.png');

    // ?رհ?ť??ʽ
    CancelBtn:=BtnCreate(WizardForm.Handle,617,8,20,20,ExpandConstant('{tmp}\btn_close.png'),1,False)
    BtnSetEvent(CancelBtn,BtnClickEventID,WrapBtnCallback(@CancelBtnOnClick,1));
    
    // ??С????ť??ʽ
    MinBtn:=BtnCreate(WizardForm.Handle,588,8,20,20,ExpandConstant('{tmp}\btn_min.png'),1,False)
    BtnSetEvent(MinBtn,BtnClickEventID,WrapBtnCallback(@MinBtnOnClick,1));
    
    // ??????װ??ť??ʽ
    btnSetup:=BtnCreate(WizardForm.Handle,195,360,260,44,ExpandConstant('{tmp}\btn_setup.png'),1,False)
    BtnSetEvent(btnSetup,BtnClickEventID,WrapBtnCallback(@nextSetpBtnClick,1));
    
    // ???ذ?ť??ʽ
    btnBack:=BtnCreate(WizardForm.Handle,285,390,80,32,ExpandConstant('{tmp}\btn_back.png'),1,False)
    BtnSetEvent(btnBack,BtnClickEventID,WrapBtnCallback(@btnShowLicenseClick,1));
    BtnSetVisibility(btnBack,false)
    
    pathEdit:= TEdit.Create(WizardForm);
    with pathEdit do
    begin
      Parent:=WizardForm;
      text:=WizardForm.DirEdit.text;
      Font.Name:='????'
      BorderStyle:=bsNone;
      SetBounds(110,272,340,15)
      OnChange:=@pathEditChange;
      TabStop:=false;
    end;

    // ??????ť??ʽ
    btnBrowser:=BtnCreate(WizardForm.Handle,470,263,80,32,ExpandConstant('{tmp}\btn_browser.png'),1,False)
    BtnSetEvent(btnBrowser,BtnClickEventID,WrapBtnCallback(@btnBrowserclick,1));

    PBOldProc:=SetWindowLong(WizardForm.ProgressGauge.Handle,-4,PBCallBack(@PBProc,4));

    // ?鿴 license ???ı?????
    licenseRich:= TRichEditViewer.Create(WizardForm);
    with licenseRich do
    begin
      Parent:=WizardForm;
      ReadOnly:=true;
      SCROLLBARS:=ssVertical;
      font.Name:='????'
      Color:=clWhite;
      BorderStyle:=bsNone;
      SetBounds(40,65,570,0)
      Lines.LoadFromFile(ExpandConstant('{tmp}\license.txt'));
      TabStop:=false;
    end;
    
    ImgApplyChanges(WizardForm.Handle)
  end;

// ?ù????ڰ?װ??ֹʱ?????ã?ע?⼰ʱ???û?û?а?װ?κ??ļ?֮ǰ?˳?Ҳ?ᱻ???á?
procedure DeinitializeSetup();
  var RCode: Integer;
  begin
    // ?????Ƿ???Ҫ?Զ?????
    if BtngetChecked(checkboxAutoRun)=true then
    begin
      Exec(ExpandConstant('{app}\{#MyAppExeName}'),'','',SW_SHOW, ewNoWait,RCode);
    end;

    gdipShutdown;
  end;

// ????????ҳ (??CurPageID ָ??) ??ʾ?????á?
procedure CurPageChanged(CurPageID: Integer);
  begin
    // Ĭ?ϵ????̰?ť???ص?
    WizardForm.NextButton.Visible:=false;
    WizardForm.CancelButton.Height:=0;
    WizardForm.BackButton.Height:=0;

    if CurPageID=wpWelcome then
      begin
        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_welcome.png'),0,0,650,450,true,true);

        // license ??ʾ
        //checkboxLicense:=BtnCreate(WizardForm.Handle,220,400,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
        //BtnSetEvent(checkboxLicense,BtnClickEventID,WrapBtnCallback(@checkboxLicenseClick,1))

        // Ĭ?Ϲ?ѡ ?Ķ???ͬ??
        BtnSetChecked(checkboxLicense,true)
        //labelReadImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_read.png'),243,398,39,20,false,true);
        //btnShowLicense:=BtnCreate(WizardForm.Handle,342,398,65,20,ExpandConstant('{tmp}\label_license.png'),4,false)
        //BtnSetEvent(btnShowLicense,BtnClickEventID,WrapBtnCallback(@btnShowLicenseClick,1))
        
        WizardForm.Width:=650;
        WizardForm.Height:=450;
        WizardForm.Show;
      end;

    if CurPageID = wpInstalling then
      begin
        BtnSetPosition(checkboxLicense,560,421,75,15);
        pathEdit.Hide;
        BtnSetVisibility(btnBrowser,false)
        WizardForm.Height:=450
        BtnSetVisibility(btnShowLicense,false);
        BtnSetVisibility(checkboxLicense,false);
        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_installing.png'),0,0,650,450,false,true);
        
        progressbgImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\loading.png'),0,320,0,0,True,True);

        BtnSetVisibility(btnSetup,false);
      end;

    if CurPageID = wpFinished then
      begin
        ImgSetVisibility(progressbgImg,false)
        btnSetup:=BtnCreate(WizardForm.Handle,195,360,260,44,ExpandConstant('{tmp}\btn_complete.png'),1,False)
        BtnSetEvent(btnSetup,BtnClickEventID,WrapBtnCallback(@nextSetpBtnClick,1));

        BGimg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\bg_finished.png'),0,0,650,450,false,true);

        // ?Ƿ??Զ?????
        checkboxAutoRun:=BtnCreate(WizardForm.Handle,275,243,16,16,ExpandConstant('{tmp}\checkbox.png'),1,true)
        labelAutoRunImg:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\label_autorun.png'),295,233,84,20,false,true);

        // Ĭ?Ϲ?ѡ
        BtnSetChecked(checkboxAutoRun,true);

        // ????ҳ?????عرպ???С??
        BtnSetVisibility(CancelBtn,false);
        BtnSetVisibility(MinBtn,false);
      end;

    ImgApplyChanges(WizardForm.Handle)
  end;