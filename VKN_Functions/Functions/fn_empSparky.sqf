// by ALIAS
// execVM "Scripts\sparky.sqf"
private ["_spark_poz_rel", "_pauza_intre_sclipiri", "_lamp"];

if (!hasinterface) exitwith {};

_lamp = _this select 0;

sleep 0.1 + (random 0.1);
_sclipiri = 1+ floor (random 5);
_nr = 0;
while {_nr<_sclipiri} do {
    _pauza_intre_sclipiri = 0.1+ (random 2);
    [_lamp, _pauza_intre_sclipiri] remoteExec ["VKN_fnc_empSparkEffect"];
    sleep _pauza_intre_sclipiri;
    _nr=_nr+1;
};