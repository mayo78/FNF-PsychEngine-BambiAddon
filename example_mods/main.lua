--settings and stuff DONT DELETE ANYTHING!!!!!!!
function getMainStuff()
  local data = {
    windowTitle = 'Psych Engine: Bambi Addon!', --title of the window
    iconsPath = 'icons/', --path of the app icons
    modName = 'Your Mod Name That You Can Change In "mods/main.lua"',
    modVersion = '0.0.1',
    iconBop = true, --set to false for custom icon bops,
    saveFile = 'PsychEngineBambiAddon', --name of the save file for your mod
    flashingStateText = [[
Hey! This mod contains flashing lights!
To disable them, go to the settings and disable them there!
    ]] --i beg you to not change this to some stupid idiot message that doesnt warn the user about flashing lights
  }
  return data
end