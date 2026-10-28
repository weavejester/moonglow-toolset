; Inno Setup script for Moonscar Toolset's Windows installer.
;
;   iscc /DVersion=0.1.0 /DSource=..\..\target\dist packaging\windows\moonglow.iss
;
; Source holds moonglow.exe, mg.exe and THIRD-PARTY-LICENSES.txt
; (packaging/windows/build-installer.ps1 puts them there). Installs per user
; by default (no administrator rights), per machine when chosen.

#ifndef Version
  #define Version "0.0.0"
#endif
#ifndef Source
  #define Source "..\..\target\dist"
#endif

[Setup]
AppId={{A83803F5-0DC6-4E68-8B97-1DBE4224BEAF}
AppName=Moonscar Toolset
AppVersion={#Version}
AppVerName=Moonscar Toolset {#Version}
AppPublisher=The Moonglow Toolset contributors and the Scars of Risenholm team
DefaultDirName={autopf}\Moonscar Toolset
DefaultGroupName=Moonscar Toolset
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
LicenseFile=..\..\LICENSE
SetupIconFile=..\icons\moonglow.ico
UninstallDisplayIcon={app}\moonglow.exe
OutputDir={#Source}
OutputBaseFilename=Moonscar-{#Version}-windows-x64-setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ChangesAssociations=yes

[Tasks]
Name: desktopicon; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: modassoc; Description: "Open modules (.mod) with Moonscar Toolset"; GroupDescription: "File associations:"; Flags: unchecked

[Files]
Source: "{#Source}\moonglow.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#Source}\mg.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\LICENSE"; DestDir: "{app}"; DestName: "LICENSE.txt"
Source: "{#Source}\THIRD-PARTY-LICENSES.txt"; DestDir: "{app}"
Source: "..\..\docs\manual\*"; DestDir: "{app}\manual"; Flags: recursesubdirs skipifsourcedoesntexist

[Icons]
Name: "{autoprograms}\Moonscar Toolset"; Filename: "{app}\moonglow.exe"
Name: "{autodesktop}\Moonscar Toolset"; Filename: "{app}\moonglow.exe"; Tasks: desktopicon

[Registry]
Root: HKA; Subkey: "Software\Classes\.mod\OpenWithProgids"; ValueType: string; ValueName: "MoonscarToolset.Module"; ValueData: ""; Flags: uninsdeletevalue; Tasks: modassoc
Root: HKA; Subkey: "Software\Classes\MoonscarToolset.Module"; ValueType: string; ValueName: ""; ValueData: "Neverwinter Nights module"; Flags: uninsdeletekey; Tasks: modassoc
Root: HKA; Subkey: "Software\Classes\MoonscarToolset.Module\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\moonglow.exe,0"; Tasks: modassoc
Root: HKA; Subkey: "Software\Classes\MoonscarToolset.Module\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\moonglow.exe"" ""%1"""; Tasks: modassoc

[Run]
Filename: "{app}\moonglow.exe"; Description: "{cm:LaunchProgram,Moonscar Toolset}"; Flags: nowait postinstall skipifsilent
