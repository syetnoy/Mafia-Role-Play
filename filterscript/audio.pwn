#include <audio>
// sscanf2 include from the sscanf plugin
#include <sscanf2>
// zcmd include by Zeex
#include <zcmd>

new stationNames[13][] =
{
	{ "Radio Off" },
	{ "Playback FM" },
	{ "K-Rose" },
	{ "K-DST" },
	{ "Bounce FM" },
	{ "SF-UR" },
	{ "Radio Los Santos" },
	{ "Radio X" },
	{ "CSR 103.9" },
	{ "K-Jah West" },
	{ "Master Sounds 98.3" },
	{ "WCTR" },
	{ "User Track Player" }
};

/*
	The audio pack is set here. Note that the TCP server is automatically
	created via callback hooking.
*/

public OnFilterScriptInit()
{
	Audio_SetPack("default_pack");
	return 1;
}

/*
	The TCP server is destroyed here. This is not necessary, but it's
	recommended if you don't intend to use any more natives or callbacks from
	the plugin.
*/

public OnFilterScriptExit()
{
	Audio_DestroyTCPServer();
}

/*
	Below are some callbacks from the plugin.
*/

public Audio_OnClientConnect(playerid)
{
	new hostname[64], string[128];
	format(string, sizeof(string), "Connected to audio TCP server (Player ID: %d)", playerid);
	SendClientMessageToAll(0xFFFF00FF, string);
	GetServerVarAsString("hostname", hostname, sizeof(hostname));
	format(string, sizeof(string), "Welcome to %s!", hostname);
	Audio_SendMessage(playerid, string);
	return 1;
}

public Audio_OnClientDisconnect(playerid)
{
	new string[128];
	format(string, sizeof(string), "Disconnected from audio TCP server (Player ID: %d)", playerid);
	SendClientMessageToAll(0xFFFF00FF, string);
	return 1;
}

public Audio_OnPlay(playerid, handleid)
{
	new string[128];
	format(string, sizeof(string), "Audio playback started (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	return 1;
}

public Audio_OnStop(playerid, handleid)
{
	new string[128];
	format(string, sizeof(string), "Audio playback stopped (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	return 1;
}

public Audio_OnTransferFile(playerid, file[], current, total, result)
{
	new string[128];
	switch (result)
	{
		case 0: format(string, sizeof(string), "Audio file \"%s\" (%d of %d) finished local download (Player ID: %d)", file, current, total, playerid);
		case 1: format(string, sizeof(string), "Audio file \"%s\" (%d of %d) finished remote download (Player ID: %d)", file, current, total, playerid);
		case 2: format(string, sizeof(string), "Audio file \"%s\" (%d of %d) passed check (Player ID: %d)", file, current, total, playerid);
		case 3: format(string, sizeof(string), "Audio file \"%s\" (%d of %d) could not be downloaded or checked (Player ID: %d)", file, current, total, playerid);
	}
	SendClientMessage(playerid, 0xFFFF00FF, string);
	if (current == total)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "All files have been processed");
	}
	return 1;
}

public Audio_OnTrackChange(playerid, handleid, track[])
{
	new string[128];
	format(string, sizeof(string), "Now playing \"%s\" (Handle ID: %d) (Player ID: %d)", track, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
}

public Audio_OnRadioStationChange(playerid, station)
{
	new string[128];
	format(string, sizeof(string), "Radio station set to %d (%s) (Player ID: %d)", station, stationNames[station], playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	return 1;
}

public Audio_OnGetPosition(playerid, handleid, seconds)
{
	new string[128];
	format(string, sizeof(string), "Audio position currently at %d seconds (Handle ID: %d) (Player ID: %d)", seconds, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	return 1;
}

/*
	Below are some test commands using natives from the plugin.
*/

COMMAND:setpack(playerid, params[])
{
	if (!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid, 0xFF0000FF, "ERROR: You do not have permission to use this command.");
		return 1;
	}
	new audiopack[32], bool:automated, bool:transferable;
	if (sscanf(params, "s[32]L(true)L(true)", audiopack, transferable, automated))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /setpack <audiopack> <transferable (0/1)> <automated (0/1)>");
		return 1;
	}
	if (Audio_SetPack(audiopack, transferable, automated))
	{
		new string[128];
		format(string, sizeof(string), "Audio pack \"%s\" set", audiopack);
	}
	return 1;
}

COMMAND:connected(playerid, params[])
{
	new clientMsg[32];
	if (Audio_IsClientConnected(strval(params)))
	{
		format(clientMsg, sizeof(clientMsg), "Player ID %d is connected", strval(params));
		SendClientMessage(playerid, 0xFFFF00FF, clientMsg);
	}
	else
	{
		format(clientMsg, sizeof(clientMsg), "Player ID %d is not connected", strval(params));
		SendClientMessage(playerid, 0xFFFF00FF, clientMsg);
	}
	return 1;
}

COMMAND:createsequence(playerid, params[])
{
	new sequenceid, string[128];
	sequenceid = Audio_CreateSequence();
	if (sequenceid)
	{
		format(string, sizeof(string), "Sequence ID %d created", sequenceid);
	}
	else
	{
		format(string, sizeof(string), "Error creating sequence ID %d", sequenceid);
	}
	SendClientMessageToAll(0xFFFF00FF, string);
	return 1;
}

COMMAND:destroysequence(playerid, params[])
{
	new sequenceid = strval(params);
	if (!sequenceid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /destroysequence <sequenceid>");
		return 1;
	}
	new string[128];
	if (Audio_DestroySequence(sequenceid))
	{
		format(string, sizeof(string), "Sequence ID %d destroyed", sequenceid);
	}
	else
	{
		format(string, sizeof(string), "Error destroying sequence ID %d", sequenceid);
	}
	SendClientMessageToAll(0xFFFF00FF, string);
	return 1;
}

COMMAND:addtosequence(playerid, params[])
{
	new audioid, sequenceid;
	if (sscanf(params, "dd", sequenceid, audioid))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /addtosequence <sequenceid> <audioid>");
		return 1;
	}
	new string[128];
	if (Audio_AddToSequence(sequenceid, audioid))
	{
		format(string, sizeof(string), "Audio ID %d added to sequence ID %d", audioid, sequenceid);
	}
	else
	{
		format(string, sizeof(string), "Error adding audio ID %d to sequence ID %d", audioid, sequenceid);
	}
	SendClientMessageToAll(0xFFFF00FF, string);
	return 1;
}

COMMAND:removefromsequence(playerid, params[])
{
	new audioid, sequenceid;
	if (sscanf(params, "dd", sequenceid, audioid))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /removefromsequence <sequenceid> <audioid>");
		return 1;
	}
	new string[128];
	if (Audio_RemoveFromSequence(sequenceid, audioid))
	{
		format(string, sizeof(string), "Audio ID %d removed from sequence ID %d", audioid, sequenceid);
	}
	else
	{
		format(string, sizeof(string), "Error removing audio ID %d from sequence ID %d", audioid, sequenceid);
	}
	SendClientMessageToAll(0xFFFF00FF, string);
	return 1;
}

COMMAND:play(playerid, params[])
{
	new audioid, bool:downmix, bool:loop, bool:pause;
	if (sscanf(params, "dL(false)L(false)L(false)", audioid, pause, loop, downmix))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /play <audioid> <pause (0/1)> <loop (0/1)> <downmix (0/1)>");
		return 1;
	}
	Audio_Play(playerid, audioid, pause, loop, downmix);
	return 1;
}

COMMAND:playstreamed(playerid, params[])
{
	new bool:downmix, bool:loop, bool:pause, url[256];
	if (sscanf(params, "s[256]L(false)L(false)L(false)", url, pause, loop, downmix))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /playstreamed <url> <pause (0/1)> <loop (0/1)> <downmix (0/1)>");
		return 1;
	}
	Audio_PlayStreamed(playerid, url, pause, loop, downmix);
	return 1;
}

COMMAND:playsequence(playerid, params[])
{
	new audioid, bool:downmix, bool:loop, bool:pause;
	if (sscanf(params, "dL(false)L(false)L(false)", audioid, pause, loop, downmix))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /playsequence <sequenceid> <pause (0/1)> <loop (0/1)> <downmix (0/1)>");
		return 1;
	}
	Audio_PlaySequence(playerid, audioid, pause, loop, downmix);
	return 1;
}

COMMAND:pause(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /pause <handleid>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio playback paused (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_Pause(playerid, handleid);
	return 1;
}

COMMAND:resume(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /resume <handleid>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio playback resumed (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_Resume(playerid, handleid);
	return 1;
}

COMMAND:stop(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /stop <handleid>");
		return 1;
	}
	Audio_Stop(playerid, handleid);
	return 1;
}

COMMAND:restart(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /restart <handleid>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio playback restarted (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_Restart(playerid, handleid);
	return 1;
}

COMMAND:getposition(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /getposition <handleid>");
		return 1;
	}
	Audio_GetPosition(playerid, handleid);
	return 1;
}

COMMAND:setposition(playerid, params[])
{
	new handleid, seconds;
	if (sscanf(params, "dd", handleid, seconds))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /setposition <handleid> <seconds>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio position set to %d seconds (Handle ID: %d) (Player ID: %d)", seconds, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_SetPosition(playerid, handleid, seconds);
	return 1;
}

COMMAND:setvolume(playerid, params[])
{
	new handleid, volume;
	if (sscanf(params, "dd", handleid, volume))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /setvolume <handleid> <volume (0-100)>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio volume set to %d (Handle ID: %d) (Player ID: %d)", volume, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_SetVolume(playerid, handleid, volume);
	return 1;
}

COMMAND:setfx(playerid, params[])
{
	new handleid, type;
	if (sscanf(params, "dd", handleid, type))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /setfx <handleid> <type (0-8)>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio FX type %d applied (Handle ID: %d) (Player ID: %d)", type, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_SetFX(playerid, handleid, type);
	return 1;
}

COMMAND:removefx(playerid, params[])
{
	new handleid, type;
	if (sscanf(params, "dd", handleid, type))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /removefx <handleid> <type (0-8)>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio FX type %d removed (Handle ID: %d) (Player ID: %d)", type, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_RemoveFX(playerid, handleid, type);
	return 1;
}

COMMAND:set3dposition(playerid, params[])
{
	new handleid, Float:distance, Float:x, Float:y, Float:z;
	if (sscanf(params, "df", handleid, distance))
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /set3dposition <handleid> <distance>");
		return 1;
	}
	new string[128];
	GetPlayerPos(playerid, x, y, z);
	format(string, sizeof(string), "Audio 3D position set to %.01f, %.01f, %.01f with a distance of %.01f (Handle ID: %d) (Player ID: %d)", x, y, z, distance, handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_Set3DPosition(playerid, handleid, x, y, z, distance);
	return 1;
}

COMMAND:remove3dposition(playerid, params[])
{
	new handleid = strval(params);
	if (!handleid)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /remove3dposition <handleid>");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), "Audio 3D position removed (Handle ID: %d) (Player ID: %d)", handleid, playerid);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	Audio_Remove3DPosition(playerid, handleid);
	return 1;
}

COMMAND:setradiostation(playerid, params[])
{
	new station = strval(params);
	if (station < 0 || station > 12)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "USAGE: /setradiostation <station (0-12)>");
		return 1;
	}
	Audio_SetRadioStation(playerid, station);
	return 1;
}

COMMAND:stopradio(playerid, params[])
{
	Audio_StopRadio(playerid);
	return 1;
}
