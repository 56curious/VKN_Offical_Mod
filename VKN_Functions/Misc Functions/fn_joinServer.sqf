/*
Script name:  fn_joinServer.sqf
Created on:   16 ‎March ‎2019
Author:       Curious

Description:  Get information and join a specific server with cached information.

License:      This file is under "Arma Public License No Derivatives (APL-ND)"
              More information can be found at:
              https://www.bohemia.net/community/licenses/arma-public-license-nd

Example:      N/A
*/


/*

IMPORTANT
TO-DO:
UPDATE THIS FUNCTION TO USE THE NEW connectToServer COMMAND


*/





#include "\A3\Ui_f\hpp\defineResincl.inc"

params
[
    ["_buttons", []],
    ["_IP", "127.0.0.1"],
    ["_PORT", "2302"],
    ["_PASS", ""],
    ["_TIMEOUT", 30]
];

_MainMenuServerIPVal = profileNamespace getVariable ["VKN_MainMenuServerIPVal_var", "127.0.0.1"];
_MainMenuServerPortVal = profileNamespace getVariable ["VKN_MainMenuServerPortVal_var", "2302"];
_MainMenuServerPasswordVal = profileNamespace getVariable ["VKN_MainMenuServerPasswordVal_var", ""];

if (isClass(configFile >> "CfgPatches" >> "cba_settings")) then {
	/*
	Check CBA Cache
	*/
	private _server = format ["%1:%2", _MainMenuServerIPVal, _MainMenuServerPortVal];
	private _passwordCache = profileNamespace getVariable ["cba_ui_ServerPasswords", [[], []]];
	private _index = (_passwordCache select 0) find _server;
	private _password = (_passwordCache select 1) param [_index, ""];

	_PASS = _password;

	if (_PASS == "") then { _PASS = _MainMenuServerPasswordVal; }; //If CBA returns false, fall back to settings.
};

ctrlactivate ((ctrlparent (_buttons # 0)) displayctrl 105);

/*
1	_IP
2	_PORT
3	_PASS
4	IDC_CANCEL
5	IDD_MISSION
6	IDD_DEBRIEFING
7	IDD_MP_SETUP
8	IDD_MULTIPLAYER
9	IDC_MULTI_TAB_DIRECT_CONNECT
10	IDD_IP_ADDRESS
11	IDC_IP_ADDRESS
12	IDC_IP_PORT
13	IDC_MULTI_SESSIONS
14	IDC_OK
15	IDC_MULTI_JOIN
16	IDD_PASSWORD
17	IDC_PASSWORD
18	diag_tickTime + _TIMEOUT
*/

onEachFrame format [
"
    onEachFrame
    {
		ctrlActivate (findDisplay %8 displayCtrl %9);

		onEachFrame
		{
			private _ctrlServerAddress = findDisplay %10 displayCtrl 2300;
			_ctrlServerAddress controlsGroupCtrl %11 ctrlSetText ""%1"";
			_ctrlServerAddress controlsGroupCtrl %12 ctrlSetText ""%2"";
			ctrlActivate (_ctrlServerAddress controlsGroupCtrl %14);

			onEachFrame
			{
				((findDisplay %8 displayCtrl %13) lbData 0) call
				{
					if (diag_tickTime > %18) then
					{
						diag_log ""RCTS Timeout (no server)"";
						onEachFrame {};
					};

					if !(_this isEqualTo '') then
					{
						findDisplay %8 displayCtrl %13 lbSetCurSel 0;

						onEachFrame
						{
							ctrlActivate (findDisplay %8 displayCtrl %15);

							onEachFrame
							{
								if (diag_tickTime > %18) then
								{
									diag_log ""RCTS Timeout (cannot join)"";
									onEachFrame {};
								};

								if (!isNull findDisplay %16) then
								{
									private _ctrlPassword = findDisplay %16 displayCtrl %17;
									_ctrlPassword ctrlSetTextColor [0,0,0,0];
									_ctrlPassword ctrlSetText ""%3"";
									ctrlActivate (findDisplay %16 displayCtrl %14);
								};

								if (getClientStateNumber >= 3) then
								{
									diag_log ""RCTS Success"";
									onEachFrame {};
								};
							};
						};
					};
				};
			};
		};
    };
", _MainMenuServerIPVal, _MainMenuServerPortVal, _PASS, IDC_CANCEL, IDD_MISSION, IDD_DEBRIEFING, IDD_MP_SETUP, IDD_MULTIPLAYER,
IDC_MULTI_TAB_DIRECT_CONNECT, IDD_IP_ADDRESS, IDC_IP_ADDRESS, IDC_IP_PORT, IDC_MULTI_SESSIONS,
IDC_OK, IDC_MULTI_JOIN, IDD_PASSWORD, IDC_PASSWORD, diag_tickTime + _TIMEOUT];
