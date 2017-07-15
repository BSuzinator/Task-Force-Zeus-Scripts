/*
Confirms player truly wants to open the data terminal
*/

dt removeAllActions;

titleText["By activating this terminal you will send an updated location to friendly troops. \n You will also alert all other forces in the AO to your presence in a much larger radius.", "BLACK FADED",2];

dt addAction ["<t color='#FF0000'>Activate Data Terminal</t>", "dataTerminal.sqf"] call BIS_fnc_MP;