--i know this is like the bad way of applying cameras to shaders but who cares
--this also kinda makes it hard to add your own shaders if you also want eyesores and stuff, feel free to modify this to your needs i guess
isEnabled = false
function onCreatePost()
	luaDebugMode = true
	initLuaShader 'BlockedGlitchShader'
	makeLuaSprite 'camBlockedShader'
	setSpriteShader('camBlockedShader', 'BlockedGlitchShader')
  setShaderFloat('camBlockedShader', 'time', getRandomFloat(-100, 100))
	addHaxeLibrary('ShaderFilter', 'openfl.filters')
end
function onEvent(n)
  if n == 'Toggle Blocked Shader' then
    isEnabled = not isEnabled
    runHaxeCode('game.camHUD.setFilters(['..(isEnabled and "new ShaderFilter(game.getLuaObject('camBlockedShader').shader)" or '')..']);')
  end
end
function onUpdate(e)
	setShaderFloat('camBlockedShader', 'time', getShaderFloat('camBlockedShader', 'time') + e)
end
