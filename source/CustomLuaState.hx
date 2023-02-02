package;

// basically a state that has different names and runs lua/hscript only
import flixel.FlxG;
import flixel.FlxCamera;
import MusicBeatState;

class CustomLuaState extends MusicBeatState
{
	public static var instance:CustomLuaState;
	public static var curState:String = '';
	private var debugCam:FlxCamera; //dont mess with these, just make your own cameras!
	public var camGame:FlxCamera;

	override function create()
	{
		camGame = new FlxCamera();
		debugCam = new FlxCamera();
		debugCam.bgColor.alpha = 0;
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(debugCam, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);
		instance = this;
		CoolUtil.inCustomState = true;
		initLua(false, CustomLuaState.curState);
		super.create();
		callOnLuas('onCreatePost', []);
		add(luaDebugGroup);
	}

	override function destroy()
	{
		CoolUtil.inCustomState = false;
		super.destroy();
	}

	override function update(elapsed:Float)
	{
		callOnLuas('onUpdate', [elapsed]);
		super.update(elapsed);
		callOnLuas('onUpdatePost', [elapsed]);
	}
}
