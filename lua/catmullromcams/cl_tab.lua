
function CatmullRomCams.CL.Tab()
	return spawnmenu.AddToolTab("CRCCams", "CRCCams", "gui/silkicons/camera")
end
hook.Add("AddToolMenuTabs", "CatmullRomCams.CL.Tab", CatmullRomCams.CL.Tab)
