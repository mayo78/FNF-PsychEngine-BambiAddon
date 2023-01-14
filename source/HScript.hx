import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;

import animateatlas.AtlasFrameMaker;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import flixel.addons.transition.FlxTransitionableState;
import flixel.system.FlxAssets.FlxShader;

#if (!flash && sys)
import flixel.addons.display.FlxRuntimeShader;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import Type.ValueType;
import Controls;
import DialogueBoxPsych;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

#if desktop
import Discord;
#end
import FunkinLua;
class HScript
{
	public static var parser:Parser = new Parser();
	public static var Function_StopHScript:Dynamic = 3;
	public var interp:Interp;
  
  public var path:String;
  
	public function new(?path:String, ?luaInstance:FunkinLua)
	{
    this.path = path;
		interp = new Interp();
		set('FlxG', FlxG);
		set('Math', Math);
		set('FlxSprite', FlxSprite);
		set('FlxCamera', FlxCamera);
		set('FlxTimer', FlxTimer);
		set('FlxTween', FlxTween);
		set('FlxEase', FlxEase);
		set('PlayState', PlayState);
		set('game', FunkinLua.curInstance);
		set('Paths', Paths);
		set('Conductor', Conductor);
		set('ClientPrefs', ClientPrefs);
		set('Character', Character);
		set('Alphabet', Alphabet);
		set('CustomSubstate', CustomSubstate);
		#if (!flash && sys)
		set('FlxRuntimeShader', FlxRuntimeShader);
		#end
		set('ShaderFilter', openfl.filters.ShaderFilter);
		set('StringTools', StringTools);
		set('FunkinLua', FunkinLua); //would be useful
		set('luaInstance', luaInstance);
    set('this', this);
    set('Function_Stop', FunkinLua.Function_Stop);
    set('Function_Continue', FunkinLua.Function_Continue);
		
		set('setVar', function(name:String, value:Dynamic)
		{
			FunkinLua.curInstance.variables.set(name, value);
		});
		set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if(FunkinLua.curInstance.variables.exists(name)) result = FunkinLua.curInstance.variables.get(name);
			return result;
		});
		set('removeVar', function(name:String)
		{
			if(FunkinLua.curInstance.variables.exists(name))
			{
				FunkinLua.curInstance.variables.remove(name);
				return true;
			}
			return false;
		});

		//copies all lua callbacks to hscript
		if(luaInstance == null || luaInstance.scriptName != 'assets/blank.lua')
			new FunkinLua(Paths.getPreloadPath('blank.lua')); //incase theres no lua files
		for(callback in Lua_helper.callbacks.keys()) set(callback, Lua_helper.callbacks.get(callback));
    
    //single hscript stuff
    if(path != null && luaInstance == null)
    {    
			trace('Loading stand-alone hscript!', path);
			set('runLuaCode', function(codeToRun:String) {
	      var lua:FunkinLua = new FunkinLua(Paths.getPreloadPath('blank.lua'));
	      LuaL.dostring(lua.lua, codeToRun);
				lua.stop();
	    });
      execute(File.getContent(path));
      FunkinLua.curInstance.hscriptArray.push(this);
      call('onCreate');
    }
	}
  public function call(sfunc:String, ?args:Array<Dynamic>)
  {
		var ret = null;
		if(exists(sfunc))
		{
	    var func = get(sfunc);
	    if(args == null)
	    {
	      try{
	        ret = func();
	      }catch(e:Dynamic){
	        error(e, 'Error calling on HScript (no arguments)');
				}
	    }
	    else
	    {
	      try{
	        ret = Reflect.callMethod(null, func, args);
	      }catch(e:Dynamic){
	        error(e, 'Error calling on HScript (arguments)');
				}
	    }
		}
		return ret;
  }
  public inline function get(variable:String)
    return interp.variables.get(variable);
  public inline function set(variable:String, value:Dynamic)
    interp.variables.set(variable, value);
  public inline function exists(variable)
    return interp.variables.exists(variable);
  inline function error(e:String, type:String)
	{
    FunkinLua.curInstance.addTextToDebug('${path}: ${type}: ${e}', FlxColor.RED);
		trace('$path: $e');
	}
	public function execute(codeToRun:String):Dynamic
	{
		try{
			@:privateAccess
			HScript.parser.line = 1;
			HScript.parser.allowTypes = true;
			return interp.execute(HScript.parser.parseString(codeToRun));
		}catch(e:Dynamic){
			error(e, 'Error executing');
			return null;
		}
	}
}