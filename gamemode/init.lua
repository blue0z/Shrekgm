AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
include( "player.lua" )

resource.AddWorkshop( "314261589" ) -- Shrek Model
resource.AddWorkshop( "104910430" ) -- Rape Swep
resource.AddWorkshop( "795585981" ) -- All other content
sound.Add({
	name = "smash",
	sound = "smash.mp3"
})

sound.Add({
	name = "bonus",
	sound = "bonus.mp3"
})

sound.Add({
	name = "swamp",
	sound = "swamp.mp3"
})

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam(0)--Set Team to Players
end

function GM:PlayerDeath( ply )
	if ply:Team() == 0 then
		ply:SetTeam(2) --Set Team to Spectators
		if 0 >= #team.GetPlayers( 0 ) then --If all the runners are dead. End the round!
			return Round.Start()
		end

		Round.CurrentTime = Round.CurrentTime + Round.TimePerVictim
	end
end

function GM:PlayerDeathThink( ply )
	ply:Spawn()
end

function GM:PlayerSpawn( ply )
	ply:AllowFlashlight(false)
	if ply:Team() == 2 then --If spectator
		ply:Spectate(6) --Make them spectate
	elseif ply:Team() == 0 then
		ply:AllowFlashlight(true)
		ply:UnSpectate() -- As soon as the person joins the team, hde get's Un-spectated
		ply:SetModel("models/player/group01/male_07.mdl") -- Setting the Hider's PM
		ply:SetPlayerColor( Vector(0.22, 0.5, 0.10) )
		ply:Give ("weapon_taunt") -- Equip the player with a hider's gunddddddds
	elseif ply:Team() == 1 then
		ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
		ply:SetModel("models/player/pyroteknik/shrek.mdl") -- Setting Shrek's PM
		ply:SetPlayerColor( Vector(0.22, 0.5, 0.10) )
		ply:Give ("weapon_rapes") -- Equip the player with a hider's gunddddddds
	end
end

-- Round System
Round = {}
Round.DefaultTime = 180
Round.CurrentTime = 0
Round.ShrekCount = 1
Round.ShrekRelease = 174
Round.TimePerVictim = 30

SetGlobalInt("TimeLeft", Round.CurrentTime)
SetGlobalInt("TimeTotal", Round.DefaultTime)
function Round.Handle() --This function runs every second
	Round.CurrentTime = Round.CurrentTime - 1
	SetGlobalInt("TimeLeft", Round.CurrentTime)
	SetGlobalInt("RunnersRemain", #team.GetPlayers( 0 ))

	if Round.CurrentTime <= 0 and #player.GetAll() > 0 then --If its ended
		Round.Start() --Start the next round
	elseif Round.CurrentTime == Round.ShrekRelease then
		Round.Shrek:Freeze(false)
	else --Else do any stuff we want to run each second during gameplay. xd
		for k, v in pairs( player.GetAll() ) do
			--v:ChatPrint("Round Time Remaining: "..Round.CurrentTime)
		end
	end

end

function Round.Start() --This runs at the stadrt of deach roundffdd
	-- Round End
	game.CleanUpMap()
	-- Round Start
	Round.CurrentTime = Round.DefaultTime
	SetGlobalInt("TimeLeft", Round.CurrentTime)

	Round.Shrek = table.Random(player.GetAll()) --Pick shrek
	Round.Shrek:SetTeam(1) --Make random player shrek
	SetGlobalString("ShrekName", Round.Shrek:Nick())
	for k, v in pairs( player.GetAll() ) do
		v:ChatPrint("The new shrek is: "..Round.Shrek:Nick())
	end

	for k, v in pairs( player.GetAll() ) do
		if v != Round.Shrek then
			v:SetTeam(0) --Spawn them as a runner
		end
	end

	for k, v in pairs( player.GetAll() ) do
		v:KillSilent()
		v:StopSound("smash")
		v:StopSound("bonus")
	end
	timer.Simple( 0.1, function()
		Round.Shrek:Freeze(true)
	end)

	song = math.random (0,5) --calls random int between 0 and 5 inclusive.

	if song == 0 then
		Round.Shrek:EmitSound("bonus") --play secret song

	else
		Round.Shrek:EmitSound("smash") --play default song
	end
end

timer.Create("Round.Handle", 1, 0, Round.Handle)

-- Cause instant Kill
function GM:EntityTakeDamage(ply, dmginfo)
	if dmginfo:GetDamageType() != DMG_FALL then
		dmginfo:SetDamage(0)
	end
end

hook.Add( "PlayerSay", "Glitched", function( ply, text, public )
	text = string.lower( text ) -- Make the chat message entirely lowercase
	if ( text == "!unstuck" or text =="!stuck" or text =="!unglitch" ) then
		ply:ChatPrint("You will be spawned in 1 second!")
		timer.Simple( 1, function()
			ply:Spawn()
		end)
	end
end )
