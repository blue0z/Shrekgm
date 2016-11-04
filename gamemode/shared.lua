GM.Name = "Shrek"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp( 0, "hiders", Color( 0, 0, 255) )
team.SetUp( 1, "shrek", Color( 255, 0, 0) )
team.SetUp( 2, "spec", Color( 0, 0, 0) )

function GM:Initialize()
	self.BaseClass.Initialize ( self )
end
