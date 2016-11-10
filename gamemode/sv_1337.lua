/*-------------------------------------------------------------------------------------------------------------------------
	Fuck a 1337
-------------------------------------------------------------------------------------------------------------------------*/

local PLUGIN = {}
PLUGIN.Title = "1337"
PLUGIN.Description = "1337 that cunt"
PLUGIN.Author = "William and Stridey"
PLUGIN.ChatCommand = "1337"
PLUGIN.Usage = "[players]"
PLUGIN.Privileges = { "1337" }

util.AddNetworkString( "1337Hax" )

function PLUGIN:Call( ply, args )
	if ( ply:EV_HasPrivilege( "1337" ) ) then
    -- Do whatever you need to do after verifying that you can execute the command.
    local players = evolve:FindPlayer( args, ply )

    for _, pl in ipairs( players ) do
      net.Start("1337Hax")
  		net.Send( pl )
		end
	end
end

evolve:RegisterPlugin( PLUGIN )
