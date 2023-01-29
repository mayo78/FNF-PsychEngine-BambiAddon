function onAddSong(name, weekNum, songCharacter, color) --when a song is about to be added
  --[[ you can stop this function and prevent a song from being added
  return Function_Stop;
  ]]
end
function onExit() --when the player presses the back button
  --[[ you can stop this function
  return Function_Stop;
  ]]
  return Function_Continue
end
function onExitPost() --when the game is about to switch states
  --[[ you can stop this function to send the player to another state
  return Function_Stop;
  ]]
  return Function_Continue
end
function onSongPicked(name, difficulty, editor) --before the song is loaded, also tracks whether you're going to the editor
  --[[ you can stop this function
  return Function_Stop;
  ]]
end
function onSongLoad(name, difficulty, editor) --after the song is loaded, also tracks whether you're going to the editor
  --[[ you can stop this function to send the player to another state
  return Function_Stop;
  ]]
end
function onSongResetScore(name, difficulty, character) --called when the player is gonna reset a score
  
end

--gameplay changers stuff

function gameplayChangersCreate() --called when the GameplayChangersSubstate is opened
  
end
function gameplayChangersCreatePost() --take a wild guess
  
end
function getOptions() --called when the changers are being added
end
function onChangeOption(name, variable, type) --called when an option is changed
  
end
--callable callbacks
getSongs() --returns an array of song "objects"
--[[
song = {
  songName:String
  week:Int
  songCharacter:String
  color:Int
  folder:String
}
]]
addGameplayChanger(gameplayChanger) --adds a gameplay changer, use it like this:
addGameplayChanger{ --btw addGameplayChanger{stuff} = addGameplayChanger({stuff})
  name = 'TEST option',
  variable = 'test_option',
  type = 'bool',
  defaultValue = false
}
--[[
the typedef for that function (basiclly you can define any typdef name in the lua table and it will work):
typedef GameplayOptionLua = {
  text:String,
  type:String,
  showBoyfriend:Null<Bool>,
  scrollSpeed:Null<Float>,
  variable:String,
  defaultValue:Dynamic,
  options:Array<String>,
  changeValue:Dynamic,
  minValue:Dynamic,
  maxValue:Dynamic,
  decimals:Null<Int>,
  displayFormat:String,
  name:String
}
you can check out what each value does in source/GameplayChangersSubstate.hx
]]
getOptionValue(name:String) --gets the value of a gameplay changer
getOptionValue('TEST option')

setOptionValue(name:String, value:Dynamic) --sets the value of a gameplay changer
setOptionValue('TEST option', true)