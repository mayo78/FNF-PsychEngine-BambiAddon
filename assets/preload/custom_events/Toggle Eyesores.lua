--i know this is like the bad way of applying cameras to shaders but who cares
isEnabled = false
function onCreatePost()
  if buildTarget == 'windows' then
    setGlobalProperty('hasPulseShader', true)
  	initLuaShader 'PulseShader'

  	makeLuaSprite('camShader')

  	setSpriteShader('camShader', 'PulseShader')
    setShaderFloat('camShader', 'uSpeed', 1)
    setShaderFloat('camShader', 'uFrequency', 2)
    setShaderFloat('camShader', 'uWaveAmplitude', 1)
    setShaderFloat('camShader', 'uTime', getRandomFloat(-100, 100))
  	
  	if flashingLights then
  		addHaxeLibrary('ShaderFilter', 'openfl.filters')
  		runHaxeCode([[
  			game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
  		]])
  	end
  end
end
function onEvent(n)
  if n == 'Toggle Eyesores' then
    isEnabled = not isEnabled
    if buildTarget == 'windows' then
      setShaderBool('camShader', 'uEnabled', isEnabled)
    end
  end
end
function onUpdate(e)
	setShaderFloat('camShader', 'uTime', getShaderFloat('camShader', 'uTime') + e)

  if isEnabled then
    setShaderFloat('camShader', 'uampmul', 0.5)
		runHaxeCode('FlxG.camera.shake(0.010, 0.010);')
		playAnim('gf', 'scared', false)
  else
    setShaderFloat('camShader', 'uampmul', getShaderFloat('camShader', 'uampmul') - 0.01)
  end
end
