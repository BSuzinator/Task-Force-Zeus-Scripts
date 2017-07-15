// wearable earplugs
// init.sqf -- _handle = []execVM "...\earplugs\playerEarplugs.sqf";
// by |TG189| Unkl for TacticalGamer.com
_inID = 78;
_outID = 79;

_inID = player addAction [
"<t color='#3399ff'>Put In Earplugs</t>",
"earplugs\earplugsPutIn.sqf",
"",
1,
false,
true,
"",
"player == player"];

_outID = player addAction ["<t color='#3399ff'>Take Out Earplugs</t>","earplugs\earplugsTakeOut.sqf","",1,false,true,"","player == player"];