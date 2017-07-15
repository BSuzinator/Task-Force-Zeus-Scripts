[] execVM "IgiLoad\IgiLoadInit.sqf";
execVM "R3F_LOG\init.sqf";
enableSaving [false,false];
enableRadio false;
0 fadeRadio 0;

//Briefing: Lists in reverse order.
player createDiaryRecord ["Diary", ["Objective Charlie", "Fireteam strength. A couple of Boats. Not much here, but don't let them raise the alarm."]];
player createDiaryRecord ["Diary", ["Objective Bravo", "Intel suggests about a fireteam worth of guards. Location is a Vehicle Repair Center with quite a few engineers. You need to take out the AA emplacement before CAS can come on station."]];
player createDiaryRecord ["Diary", ["Objective Alpha", "Intel suggests squad-sized defense. No vehicles sighted, but close proximity to Airfield suggests a fast response time. A supply heli was shot down around this location, so it would not be impossible for extra NATO supplies to be around here somewhere."]];
player createDiaryRecord ["Diary", ["Main Objective", "Housing about a platoon of CSAT, the Selakano Airfield is a must-have for NATO. We CANNOT launch our Wipeouts until this airfield is captured. Expect Armor, IFVs, and Ifrits."]];
player createDiaryRecord ["Diary", ["Situation", "It's Spetember 9, 2035. Under the cover of night and storms, Task Force Zeus will infiltrate the South-Eastern part of Altis and attempt to achieve a foothold for the rest of the invasion. Once the airfield is secured, Wipeouts will be available for CAS. Other assets on standby include 2 each of AA and CAS Black Wasps, as well as 2 UCAV Sentinals. In order for the invasion to fully have a foothold, we must move the supplies from the USS Freedom to the Selakano Airfield. These supplies include one of each Zamak (On loan from the AAF), or one each of the Huron Containers. Once this is complete we will be able to start the invasion of Altis proper."]];

//Server Info tab in map
player createDiarySubject["SERVER INFO","SERVER INFO"];
player createDiaryRecord ["SERVER INFO", ["EULA", "By using this mission file you agree to: not decompile this .pbo file and/or reuse this mission file and/or modify/edit this file in any way, shape, or form unless permisison is granted by its creator, BSuzinator."]];
player createDiaryRecord ["SERVER INFO", ["TEAMSPEAK", "<br />ts69.gameservers.com:9385<br /><br />Frequencies for use with Task Force Radio (Unless otherwise stated):<br />Infantry: SR 101.5 <br />Command Net: SR/LR 50<br />Air Vehicles: LR 50.5 <br />"]];
