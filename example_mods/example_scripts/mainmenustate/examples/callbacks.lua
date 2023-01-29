--list of callbacks in this state
function onCreate() --this is called on every script when the file is loaded
  
end
function onCreatePost() --same as onCreate, but called after everything in the state is made
  
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
function onAccept() --called as soon as the player presses the accept button
  
end
function onSelect(choice) --called when the game is about to switch states
  --choices can be story_mode, freeplay, mods, awards, credits, options
  --[[ you can stop this function
  return Function_Stop;
  ]]
  return Function_Continue
end