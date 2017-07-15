player addAction ["Holster weapons", {_unit=_this select 1; _unit action ['SwitchWeapon', _unit, _unit, 100];}, [], 1.5, false];
_handle = []execVM "earplugs\playerEarplugs.sqf";