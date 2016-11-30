GM.Name = "Shrek"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp( 3, "Hiders", Color( 0, 0, 255) )
team.SetUp( 1, "Shrek", Color( 117,245,20) )
team.SetUp( 2, "Spectators", Color( 0, 0, 0) )

function GM:Initialize()
	self.BaseClass.Initialize ( self )
end
