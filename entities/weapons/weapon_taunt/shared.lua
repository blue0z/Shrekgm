
SWEP.DrawWeaponInfoBox = true
SWEP.Author			= "Strideynet"
SWEP.Contact		= "Steam Profile"
SWEP.Purpose		= "Taunt shrek!"
SWEP.Instructions	= "Mouse1: Taunt!"

SWEP.Category			= "Stridey"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.IconLetter				= "C"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ViewModel = Model("models/weapons/v_hands.mdl")

SWEP.SoundDelay = 5


local sounds2 = {
	"vo/npc/male01/help01.wav",
	"vo/npc/male01/illstayhere01.wav",
	"vo/npc/female01/letsgo01.wav",
	"vo/npc/female01/help01.wav",
	"vo/npc/female01/moan01.wav",
	"vo/npc/female01/no01.wav",
	"vo/npc/female01/ohno.wav",
	"vo/npc/female01/runforyourlife01.wav",
	"vo/npc/female01/runforyourlife02.wav",
	"vo/npc/male01/gethellout.wav",
	"vo/npc/male01/goodgod.wav"
}



/*---------------------------------------------------------
---------------------------------------------------------*/
function SWEP:Initialize()
	--self:SetWeaponHoldType( self.HoldType )
end

function SWEP:DrawWorldModel()
end


/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end


/*---------------------------------------------------------
   Think
---------------------------------------------------------*/
function SWEP:Think()
end

SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if ( self.NextSecondaryAttack > CurTime() ) then return end

	self.NextSecondaryAttack = CurTime() + self.SoundDelay

	if SERVER then
		self.Owner:EmitSound( sounds2[math.random(#sounds2)] )
	end

end

function SWEP:SecondaryAttack()

	if ( self.NextSecondaryAttack > CurTime() ) then return end

	self.NextSecondaryAttack = CurTime() + self.SoundDelay

	if SERVER then
		self.Owner:EmitSound( sounds2[math.random(#sounds2)] )
	end

end


/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )

	// try to fool them into thinking they're playing a Tony Hawks game
	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-14, 14), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-9, 9), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )

end*/


/*---------------------------------------------------------
	DrawHUD

	Just a rough mock up showing how to draw your own crosshair.

---------------------------------------------------------*/
function SWEP:DrawHUD()



end
