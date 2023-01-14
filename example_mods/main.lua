--settings and stuff DONT DELETE ANYTHING!!!!!!!
function getMainStuff()
  local data = {
    windowTitle = 'Psych Engine: Bambi Addon!', --title of the window
    iconsPath = 'icons/', --path of the app icons
    modName = 'Your Mod Name That You Can Change In "mods/main.lua"',
    modVersion = '0.0.1',
    iconBop = true, --set to false for custom icon bops,
    saveFile = 'PsychEngineBambiAddon', --name of the save file for your mod
    flashingStateText = '', --this gets added on to the normal flashing state text, use it if you're mod has like super flashing lights or something
    initialState = nil, --set this to skip to a custom state on startup
    updateTxtLink = 'https://raw.githubusercontent.com/mayo78/FNF-PsychEngine-BambiAddon/main/gitVersion.txt', --this is a link to an online file with the current mod's vesrion on it
    updateLink = 'https://github.com/mayo78/FNF-PsychEngine-BambiAddon/releases', --where to send the user for the latest release
    outdatedText = [[
    Sup bro, looks like you're running an
    outdated version of Psych Engine (_VERSION),
    please update to _CURRENT_VERSION!
    Press ESCAPE to proceed anyway.
    
    Thank you for using the Engine!
    ]] --text for the OutdatedState, _VERSION will be replaced with the current version, _CURRENT_VERSION will be replaced with the version found at updateTxtLink
  }
  return data
end
function conditionals()
  local conditionals = {
    'CHECK_FOR_UPDATES',
    'DEBUG'
  }
  return conditionals
end