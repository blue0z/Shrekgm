AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
include( "player.lua" )

resource.AddWorkshop( "314261589" ) -- Shrek Model
resource.AddWorkshop( "104910430" ) -- Rape Swep
resource.AddWorkshop( "795585981" ) -- All other content
resource.AddWorkshop( "157420728" ) -- Waterworld
resource.AddWorkshop( "400754706" ) -- Musuem

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

sound.Add({
	name = "russia",
	sound = "russia.mp3"
})

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam(2)--Set Team to Spectators
	if #player.GetAll() < 3 then
		Round.Start()
	end
end

function GM:PlayerDeath( ply )
	if ply:Team() == 3 then
		ply:SetTeam(2) --Set Team to Spectators
		if 0 >= #team.GetPlayers( 3 ) then --If all the runners are dead. End the round!
			for k,v in pairs(team.GetPlayers(1)) do
				v:PS2_AddStandardPoints(20, "Rekkor", "You got em out of your swamp!!")
			end
			return Round.Start()
		end

		Round.CurrentTime = math.min(Round.CurrentTime + Round.TimePerVictim, Round.DefaultTime)
		SetGlobalInt("TimeLeft", Round.CurrentTime)
			--SetGlobalInt("TimeTotal", Round.CurrentTime)
	end
end

function GM:PlayerDeathThink( ply )
	ply:Spawn()
end

function GM:PlayerDisconnected( ply)
	if ply:Team() == 1 then
		Round.Start()
	end
end

function GM:PlayerSpawn( ply )
	ply:AllowFlashlight(false)
	if ply:Team() == 2 then --If spectator
		ply:Spectate(6) --Make them spectate
	elseif ply:Team() == 3 then
		ply:AllowFlashlight(true)
		ply:UnSpectate() -- As soon as the person joins the team, hde get's Un-spectated
		ply:SetModel("models/player/group01/male_07.mdl") -- Setting the Hider's PM
		ply:SetPlayerColor( Vector(0.22, 0.5, 0.10) )
		ply:Give ("weapon_taunt") -- Equip the player with a hider's gunddddddds
	elseif ply:Team() == 1 then
		ply:AllowFlashlight(true)
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
Round.TimePerVictim = 20

SetGlobalInt("TimeLeft", Round.CurrentTime)
SetGlobalInt("TimeTotal", Round.DefaultTime)
function Round.Handle() --This function runs every second
	Round.CurrentTime = Round.CurrentTime - 1
	SetGlobalInt("TimeLeft", Round.CurrentTime)
	SetGlobalInt("RunnersRemain", #team.GetPlayers( 3 ))

	if Round.CurrentTime <= 0 and #player.GetAll() > 0 then --If its ended
		Round.Start() --Start the next round
	elseif Round.CurrentTime == Round.ShrekRelease then
		for k,v in pairs(team.GetPlayers(1)) do
			v:Freeze(false)
		end
	else --Else do any stuff we want to run each second during gameplay. xd
		for k, v in pairs( player.GetAll() ) do
			--v:ChatPrint("Round Time Remaining: "..Round.CurrentTime)
		end
	end

end

function Round.Start() --This runs at the stadrt of deach roundffdd
	SetGlobalInt("TimeTotal", Round.DefaultTime)
	for k,v in pairs(team.GetPlayers( 3 )) do
		v:PS2_AddStandardPoints(50, "Survivor", "You protected your anus!")
	end

	for k, v in pairs( player.GetAll() ) do
		v:SetTeam(3) --Spawn them as a runner
	end

	game.CleanUpMap()
	-- Round Start
	Round.CurrentTime = Round.DefaultTime
	SetGlobalInt("TimeLeft", Round.CurrentTime)

	ShrekCount = math.Clamp(math.floor(#player.GetAll()/5), 1, 100)
	print("shrek"..ShrekCount)
	while (true) do
		if ShrekCount == 0 then
			break
		end
	  local ChosenPly = table.Random(team.GetPlayers( 3 ))
		ChosenPly:SetTeam(1)
		ShrekCount = ShrekCount - 1
	end

	SetGlobalString("ShrekName", "Somepeople")

	for k, v in pairs( player.GetAll() ) do
		v:KillSilent()
		v:StopSound("smash")
		v:StopSound("bonus")
	end
	timer.Simple( 0.1, function()
		for k,v in pairs(team.GetPlayers( 1 )) do
			v:Freeze(true)
		end
	end)

	timer.Simple( 0.5, function()
		print('handling song')
		song = math.random (0,10) --calls random int between 0 and 5 inclusive.


		if song == 0 then
			for k,v in pairs(team.GetPlayers( 1 )) do
				v:EmitSound("bonus") --play default song
			end
		elseif song == 1 then
			for k,v in pairs(team.GetPlayers( 1 )) do
				v:EmitSound("russia") --play default song
			end
		else
			for k,v in pairs(team.GetPlayers( 1 )) do
				v:EmitSound("smash") --play default song
			end
		end
	end)

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
		if !ply.Raping then
			ply:ChatPrint("You will be spawned in 1 second!")
			timer.Simple( 1, function()
				ply:Spawn()
			end)
		else
			ply:ChatPrint("You cant move whilst being raped!")
		end
	end
end )

hook.Add( "PlayerSay", "Glitched", function( ply, text, public )
	text = string.lower( text ) -- Make the chat message entirely lowercase
	if ( text == "!discord") then
		ply:SendLua('gui.OpenURL("https://discord.gg/ErtAtt8")')
	end
end )
