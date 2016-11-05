AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
include( "player.lua" )

resource.AddWorkshop( "314261589" ) -- Shrek Model
resource.AddWorkshop( "104910430" ) -- Rape Swep

resource.AddFile("sound/smash.mp3") --smash
sound.Add({
	name = "smash",
	sound = "smash.mp3"
})

resource.AddFile("sound/swamp.mp3") --smash
sound.Add({
	name = "swamp",
	sound = "swamp.mp3"
})

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam(0)--Set Team to Players
end

function GM:PlayerDeath( ply )
	ply:SetTeam(2) --Set Team to Spectators
	if 0 >= #team.GetPlayers( 0 ) then --If all the runners are dead. End the round!
		Round.Start()
	end
end

function GM:PlayerSpawn( ply )
	if ply:Team() == 2 then --If spectator
		ply:Spectate(5) --Make them spectate
	elseif ply:Team() == 0 then
		ply:UnSpectate() -- As soon as the person joins the team, hde get's Un-spectated
		ply:SetModel("models/player/group01/male_07.mdl") -- Setting the Hider's PM
		ply:SetPlayerColor( Vector(0.22, 0.5, 0.10) )
	elseif ply:Team() == 1 then
		ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
		ply:SetModel("models/player/pyroteknik/shrek.mdl") -- Setting Shrek's PM
		ply:SetPlayerColor( Vector(0.22, 0.5, 0.10) )
		ply:Freeze (true)	-- Freeze the player
		timer.Simple( 2, function() ply:Freeze(false) end )	-- Unfreeze the player after 60 seconds
		ply:Give ("weapon_rapes") -- Equip the player with a hider's gunddddddds
	end
end

-- Round System
Round = {}
Round.DefaultTime = 120
Round.CurrentTime = 0
Round.ShrekCount = 1

SetGlobalInt("TimeLeft", Round.CurrentTime)

function Round.Handle() --This function runs every second
	Round.CurrentTime = Round.CurrentTime - 1
	SetGlobalInt("TimeLeft", Round.CurrentTime)

	if Round.CurrentTime <= 0 and #player.GetAll() > 0 then --If its ended
		Round.Start() --Start the next round
	else --Else do any stuff we want to run each second during gameplay. xd
		for k, v in pairs( player.GetAll() ) do
			v:ChatPrint("Round Time Remaining: "..Round.CurrentTime)
		end
	end

end

function Round.Start() --This runs at the stadrt of deach roundffdd
	-- Round End

	-- Round Start
	Round.CurrentTime = Round.DefaultTime
	SetGlobalInt("TimeLeft", Round.CurrentTime)

	Round.Shrek = table.Random(player.GetAll()) --Pick shrek
	Round.Shrek:SetTeam(1) --Make random player shrek

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
		v:Spawn()
		v:StopSound("smash")
	end

	Round.Shrek:EmitSound("smash")
end

timer.Create("Round.Handle", 1, 0, Round.Handle)

-- Cause instant Kill
function GM:EntityTakeDamage(ply, dmginfo)
	if dmginfo:GetDamageType() != DMG_FALL then
		dmginfo:SetDamage(0)
	end
end
