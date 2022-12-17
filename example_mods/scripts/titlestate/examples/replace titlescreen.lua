function onCreate()
  if not getGlobalProperty 'initializedTitle' then --start the music if we haven't been here yet
    callMethod 'startMusic'
  end

  
  makeMenuBG('bg') --makes a bg
  addLuaSprite('bg')

  makeLuaText('enterthegame', 'PRESS ENTER TO ENTER MY GAME!') --makes text like a normal script
  setTextSize('enterthegame', 32)
  screenCenter 'enterthegame'
  addLuaText 'enterthegame' --BTW if you didnt know this line = `addLuaText('enterthegame')`
  setGlobalProperty('initializedTitle', true) --set a global property that can be accessed by any script that tells everyone that we've been here
end
function onUpdate()
  if keyboardJustPressed 'ENTER' then --check if you pressed enter
    playSound ('confirmMenu', 0.7)
    runTimer('enter', 0.5) --run timer for sfx
  end
end
function onTimerCompleted(tag)
  if tag == 'enter' then --go to the mainmenustate
    switchState 'mainmenustate'
  end
end
function onCreateTitle() --called when the game is about to create the title screen, you can return Function_Stop for a custom title state
  return Function_Stop;
end