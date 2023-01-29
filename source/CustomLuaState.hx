package;

// basically a state that has different names and runs lua/hscript only
import MusicBeatState;

class CustomLuaState extends MusicBeatState
{
	public static var instance:CustomLuaState;
	public static var curState:String = '';

	override function create()
	{
		instance = this;
		// FunkinLua.curInstance = this;
		CoolUtil.inCustomState = true;
		initLua(false, CustomLuaState.curState);
		super.create();
		callOnLuas('onCreatePost', []);
		// add(luaDebugGroup);
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
