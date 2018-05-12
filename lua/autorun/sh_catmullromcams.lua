
local function AddLua(filename)
	local tmp = string.Explode("/", string.lower(filename))
	local parts = string.Explode("_", tmp[#tmp])
	
	if SERVER then
		if (parts[1] == "sh") or (parts[1] == "shared.lua") then
			include(filename)
			return AddCSLuaFile(filename)
		elseif parts[1] == "cl" then
			return AddCSLuaFile(filename)
		elseif (parts[1] == "sv") or (parts[1] == "init.lua") then
			return include(filename)
		end
		
		ErrorNoHalt("Unknown file: ",filename,"\n")
		PrintTable(tmp)
		PrintTable(parts)
		Error("Unable to determine if shared, serverside, or clientside.\n")
	elseif CLIENT then
		if (parts[1] == "sh") or (parts[1] == "cl") or (parts[1] == "shared.lua") then
			return include(filename)
		elseif (parts[1] == "sv") or (parts[1] == "init.lua") then //others, just to keep the system happy
			return
		end
		
		ErrorNoHalt("Unknown file: ",filename,"\n")
		PrintTable(tmp)
		PrintTable(parts)
		Error("Unable to determine if shared, serverside, or clientside.\n")
	else
		return Error("Apparently we're God as we're not the client or the server.\n")
	end
end

if SERVER then AddCSLuaFile("sh_catmullromcams.lua") end

CatmullRomCams = CatmullRomCams or {}

CatmullRomCams.AddLua   = AddLua
CatmullRomCams.FilePath = "catmullromcameratracks/"

CatmullRomCams.SV = CatmullRomCams.SV or {}
CatmullRomCams.SH = CatmullRomCams.SH or {}
CatmullRomCams.CL = CatmullRomCams.CL or {}

CatmullRomCams.SToolMethods = {}

function CatmullRomCams.SH.UnitsToMeters(dist)
	return (dist * 0.0254)
end

function CatmullRomCams.SH.MetersToUnits(dist)
	return (dist * 39.3700787)
end

function CatmullRomCams.SToolMethods.ValidTrace(trace)
	return (trace and trace.Entity and trace.Entity.GetClass and trace.Entity.IsValid and trace.Entity:IsValid() and (trace.Entity:GetClass() == "sent_catmullrom_camera"))
end

CatmullRomCams.Tracks = CatmullRomCams.Tracks or {}

local files = file.FindInLua("catmullromcams/*.lua")

for _, v in pairs(files) do
	AddLua("catmullromcams/" .. v)
end

local files_stools = file.FindInLua("catmullromcams/stools/*.lua")

for _, v in pairs(files_stools) do
	AddLua("catmullromcams/stools/" .. v)
end
---FREEZEBUG: You forgot client tool data.
local files_stools_client = file.Find("weapons/gmod_tool/stools/*.lua", "LUA")
for _, v in pairs(files_stools_client) do
	AddCSLuaFile("weapons/gmod_tool/stools/" .. v)
end