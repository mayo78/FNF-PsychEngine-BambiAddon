package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import FunkinLua;
import flixel.system.FlxSound;
import flixel.util.FlxSave;


#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class MusicBeatState extends FlxUIState
{
	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	public static var camBeat:FlxCamera;
	
	//lua stuff
	public static var instance:MusicBeatState;
	public var luaArray:Array<FunkinLua> = [];
	public var hscriptArray:Array<HScript> = [];
	private var luaDebugGroup:FlxTypedGroup<DebugLuaText>;
	
	#if (haxe >= "4.0.0")
	public var variables:Map<String, Dynamic> = new Map();
	public var modchartTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var modchartSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var modchartTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var modchartSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();
	#else
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var modchartTweens:Map<String, FlxTween> = new Map();
	public var modchartSprites:Map<String, ModchartSprite> = new Map();
	public var modchartTimers:Map<String, FlxTimer> = new Map();
	public var modchartSounds:Map<String, FlxSound> = new Map();
	public var modchartTexts:Map<String, ModchartText> = new Map();
	public var modchartSaves:Map<String, FlxSave> = new Map();
	#end
	
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function create() {
		camBeat = FlxG.camera;
		var skip:Bool = FlxTransitionableState.skipNextTransOut;
		super.create();

		if(!skip) {
			openSubState(new CustomFadeTransition(0.7, true));
		}
		FlxTransitionableState.skipNextTransOut = false;
	}

	override function update(elapsed:Float)
	{
		//everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if(curStep > 0)
				stepHit();

			if(PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}
		}

		if(FlxG.save.data != null) FlxG.save.data.fullscreen = FlxG.fullscreen;

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep/4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public static function switchState(nextState:FlxState) {
		// Custom made Trans in
		// callOnLuas('onSwitchState', [Std.string(nextState)]);
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		if(!FlxTransitionableState.skipNextTransIn) {
			leState.openSubState(new CustomFadeTransition(0.6, false));
			if(nextState == FlxG.state) {
				CustomFadeTransition.finishCallback = function() {
					FlxG.resetState();
				};
				//trace('resetted');
			} else {
				CustomFadeTransition.finishCallback = function() {
					FlxG.switchState(nextState);
				};
				//trace('changed state');
			}
			// callOnLuas('onSwitchStatePost', [Std.string(nextState)]);
			return;
		}
		FlxTransitionableState.skipNextTransIn = false;
		FlxG.switchState(nextState);
	}

	public static function resetState() {
		MusicBeatState.switchState(FlxG.state);
	}

	public static function getState():MusicBeatState {
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		return leState;
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
		setOnLuas('curStep', curStep);
		callOnLuas('onStepHit', []);
	}

	public function beatHit():Void
	{
		//trace('Beat: ' + curBeat);
		setOnLuas('curBeat', curBeat); //DAWGG?????
		callOnLuas('onBeatHit', []);
	}

	public function sectionHit():Void
	{
		//trace('Section: ' + curSection + ', Beat: ' + curBeat + ', Step: ' + curStep);
		setOnLuas('curSection', curSection);
		callOnLuas('onSectionHit', []);
	}

	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}
	
	public function initLua(?includeDebugGroup:Bool = true, ?pack:String = '')
	{
		trace('initing lua :) curstate', CoolUtil.curLuaState);
		#if LUA_ALLOWED
		luaDebugGroup = new FlxTypedGroup<DebugLuaText>();
		if(includeDebugGroup)
			add(luaDebugGroup);

		// STATE SPECIFIC SCRIPTS
		var idiotState:String =  pack + CoolUtil.curLuaState + '/';
		var filesPushed:Array<String> = [];
		var hscriptFilesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('scripts/'+ idiotState), Paths.mods('scripts/'+ idiotState), Paths.mods('scripts/'), Paths.getPreloadPath('scripts/')];

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						addNewLua(folder + file);
						filesPushed.push(file);
					}
					else if(file.endsWith('.hx') && !hscriptFilesPushed.contains(file))
					{
						addNewHscript(folder + file);
						hscriptFilesPushed.push(file);
					}
				}
			}
		}
		setOnLuas('curLuaStatePrefix', pack);
		callOnLuas('onInitLua', []); //maybe???
		#end
	}
	
	public function addTextToDebug(text:String, color:FlxColor) {
		#if LUA_ALLOWED
		trace('stupdiidf ids', LuaMain.conditional('DEBUG'));
		if(!LuaMain.conditional('DEBUG')) return;
		luaDebugGroup.forEachAlive(function(spr:DebugLuaText) {
			spr.y += 20;
		});

		if(luaDebugGroup.members.length > 34) {
			var blah = luaDebugGroup.members[34];
			blah.destroy();
			luaDebugGroup.remove(blah);
		}
		luaDebugGroup.insert(0, new DebugLuaText(text, luaDebugGroup, color));
		#end
	}
	
	public function getLuaObject(tag:String, text:Bool=true):FlxSprite {
		if(modchartSprites.exists(tag)) return modchartSprites.get(tag);
		if(text && modchartTexts.exists(tag)) return modchartTexts.get(tag);
		if(variables.exists(tag)) return variables.get(tag);
		return null;
	}
	var luaDestroyed:Bool = false;
	var hscriptDestroyed:Bool = false;
	public function destroyLua():Void
	{
		if(!luaDestroyed)
		{
			for (lua in luaArray) {
				lua.call('onDestroy', []);
				lua.stop();
			}
			luaArray = [];

			#if hscript
			if(FunkinLua.hscript != null) FunkinLua.hscript = null;
			#end
		}
		luaDestroyed = true;
	}
	public function destroyHScript():Void
	{
		if(!hscriptDestroyed)
		{
			for(hscript in hscriptArray)
			{
				hscript.call('onDestroy');
				hscript = null;
			}
		}
	}
	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			var ret:Dynamic = script.call(event, args);
			if(ret == FunkinLua.Function_StopLua && !ignoreStops)
				break;
			
			// had to do this because there is a bug in haxe where Stop != Continue doesnt work
			var bool:Bool = ret == FunkinLua.Function_Continue;
			if(!bool && ret != 0) {
				returnVal = cast ret;
			}
			
			script.call('onCall', [event, args]);
		}
		for(hscript in hscriptArray)
		{
			if(exclusions.contains(hscript.path))
				continue;
			
			var ret:Dynamic = hscript.call(event, args);
			if(ret == HScript.Function_StopHScript)
				break;
			
			//no idea if this would be an issue with hscript but just incase
			var bool:Bool = ret == FunkinLua.Function_Continue;
			if(!bool && ret != 0) {
				returnVal = cast ret;
			}
			
			hscript.call('onCall', [event, args]);
		}
		#end
		//trace(event, returnVal);
		return returnVal;
	}

	public function setOnLuas(variable:String, arg:Dynamic) {
		#if LUA_ALLOWED
		for (i in 0...luaArray.length) {
			luaArray[i].set(variable, arg);
		}
		#end
		for(hscript in hscriptArray)
			hscript.set(variable, arg);
	}
	
	public function addNewLua(path:String):FunkinLua
	{
		var newLua:FunkinLua = new FunkinLua(path);
		luaArray.push(newLua);
		newLua.call('onPush', []);
		return newLua;
	}
	
	public function addNewHscript(path:String):HScript
	{
		var newHScript:HScript = new HScript(path);
		hscriptArray.push(newHScript);
		newHScript.call('onPush');
		return newHScript;
	}
	
	public function setDebugTextOnTop():Void
	{
		remove(luaDebugGroup);
		add(luaDebugGroup);
	}
	
	override function destroy():Void
	{
		destroyLua();
		destroyHScript();
		super.destroy();
	}
}
