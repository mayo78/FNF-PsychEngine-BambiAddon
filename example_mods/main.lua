--settings and stuff DONT DELETE ANYTHING!!!!!!!
function getMainStuff()
  local data = {
    modName = 'Your Mod Name That You Can Change In "mods/main.lua"',
    modVersion = '0.0.1',
    iconBop = true, --set to false for custom icon bops,
    saveFolder1 = 'PsychEngineBambiAddon', --general save stuff
    saveFolder2 = nil --used for some other stuff, automatically is the same as saveFolder1
  }
  
  data.saveFolder2 = data.saveFolder2 or data.saveFolder1
  return data
end