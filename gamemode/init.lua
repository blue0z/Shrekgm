AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerInitialSpawn( ply )
	ply:SetGamemodeTeam( 2 )
end	
	
function GM:PlayerSetModel(ply)
	ply:SetModel("models/player/group01/female_07.mdl")
end

function team0( ply ) -- Creating the function.
	ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
	ply:SetTeam( 0 ) -- We'll set him to team 1
	ply:Spawn() -- Let's spawn him.
	ply:SetModel("models/player/group01/male_07.mdl") -- Setting the Hider's PM
	
end -- End the function
concommand.Add("runner", team0) -- Adding a concommand (Console Command) for the team.
 
 
function team1( ply ) -- Creating the function.
	ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
	ply:SetTeam( 1 ) -- We'll set him to team 1
	ply:Spawn() -- Let's spawn him.
	ply:SetModel("models/narry/shrek_playermodel_v1.mdl") -- Setting Shrek's PM
	ply:Freeze (true)										-- Freeze the player
	timer.Simple( 60, function() ply:Freeze(false) end )	-- Unfreeze the player after 60 seconds
	ply:Give ("has_seekgun") -- Equip the player with a hider's gun
	
end -- End the function
concommand.Add("shrek", team1) -- Adding a concommand (Console Command) for the team.

function roundstart(ply)