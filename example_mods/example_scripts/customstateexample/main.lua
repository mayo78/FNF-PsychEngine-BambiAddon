--[[you can get in a custom state like this
switchState('your custom state')
-- or this cause lua
switchState 'your custom state'
]]
function onCreate()
  makeMenuBG 'bg'
  addLuaSprite 'bg'
  
  makeLuaText('enterthegame', 'press it ONE MORE TIME')
  setTextSize('enterthegame', 32)
  screenCenter 'enterthegame'
  addLuaText 'enterthegame'
end
function onUpdate()
  if keyboardJustPressed 'ENTER' then
    playSound('confirmMenu', 0.7)
    runTimer('enter', 0.5)
  end
end
function onTimerCompleted(tag)
  if tag == 'enter' then
    switchState 'MainMenuState'
  end
end