print("weapon_splode - init.lua");

SWEP.Instructions="";
SWEP.PrintName="Suck my NADS";
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

SWEP.should_draw_dong=false;
SWEP.dong_text= "( . )( . )";

SWEP.dong_color=Color(255,0,0,255);
SWEP.dong_delay=10;
SWEP.dong_index=1;
SWEP.dong_font="dong_font1";

local sin=math.sin;
local curtime=CurTime;
local draw_text=draw.SimpleText;
local abs=math.abs;
local floor=math.floor;
local get_text_size=surface.GetTextSize;

if CLIENT then

	for i=1,100 do
		surface.CreateFont("dong_font"..i,
		{
			font="Arial",
			size=i,
			weight=500,
			antialias=true
		});
	end
end

function SWEP:Initialize()
	self:SetHoldType("rpg");
end

function SWEP:Deploy()
	return true;
end

function SWEP:Holster()
	return true;
end

function SWEP:DrawHUD()
	if SERVER then return; end
	local scrw,scrh=ScrW(),ScrH();
	local sz=floor(sin(curtime())*100);
	if sz<1 then sz=-sz; end
	if sz==0 then sz=1; end
	local txtw,txth=get_text_size(self.dong_text);
	local x,y=scrw/2-txtw/2,scrh/2-txth/2;
	draw_text(self.dong_text,"dong_font"..sz,x,y,self.dong_color);
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