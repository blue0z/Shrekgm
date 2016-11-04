local ply = FindMetaTable("Player")

function ply:SetGamemodeTeam( n )
	if n < 0 or n > 1 then return false end
	
	self:SetTeam( n )
	
	if n == 0 then
		self:SetPlayerColor(Vector ( .2, .2, 1.0 ) )
		self:SetModel("models/player/group01/male_07.mdl")
	
	elseif n == 1 then
		self:SetModel("models/narry/shrek_playermodel_v1.mdl")
	
	end
	
	return true
end