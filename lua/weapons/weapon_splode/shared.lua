print("weapon_splode - init.lua");

SWEP.Instructions="Click to kill.";
SWEP.PrintName="Splode";
SWEP.Author="";
SWEP.Purpose="";
SWEP.Contact="";
SWEP.Category="damp";
SWEP.Slot=0;
SWEP.SlotPos=0;
SWEP.DrawAmmo=true;
SWEP.DrawCrosshair=true;
SWEP.ViewModelFOV=50;
SWEP.ViewModelFlip=false;
SWEP.WorldModel="models/weapons/w_rocket_launcher.mdl";
SWEP.ViewModel="models/weapons/v_rpg.mdl";
SWEP.Spawnable=true;
SWEP.AdminOnly=true;

SWEP.Primary.ClipSize=-1;
SWEP.Primary.DefaultClip=-1;
SWEP.Primary.Automatic=true;
SWEP.Primary.Ammo="none";

SWEP.Secondary.ClipSize=-1;
SWEP.Secondary.DefaultClip=-1;
SWEP.Secondary.Automatic=false;
SWEP.Secondary.Ammo="none";

SWEP.Primary.Radius=500;
SWEP.Primary.Damage=100;

function SWEP:Initialize()
	self:SetHoldType("rpg");
end

function SWEP:Deploy()
	return true;
end

function SWEP:Holster()
	return true;
end

function SWEP:PrimaryAttack()
	local o=self.Owner;
	local tr=o:GetEyeTrace();
	local hit_pos=tr.HitPos;
	local eye_pos=o:EyePos();
	local swep_pos=self:GetPos();
	o:ViewPunch(Angle(-0.1,0,0));
	self:EmitSound("weapons/rpg/rocketfire1.wav",70,100);

	if SERVER then
		util.BlastDamage(self,self.Owner,hit_pos,self.Primary.Radius,self.Primary.Damage);
	else
		local ed=EffectData();
		ed:SetOrigin(hit_pos);
		util.Effect("Explosion",ed);

		local tracer=EffectData();
		tracer:SetOrigin(eye_pos);
		util.Effect("MuzzleFlash",tracer);
	end
end