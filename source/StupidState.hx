//hopefully fixes save issues :))))))
package;

import flixel.FlxState;
import flixel.FlxG;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;


class StupidState extends FlxState
{
  override function create():Void
  {
    LuaMain.init();
    FlxG.save.bind(LuaMain.data.saveFile, 'funkin/${LuaMain.data.saveFile}');
    if(FlxG.save.data != null && FlxG.save.data.fullscreen)
    {
      FlxG.fullscreen = FlxG.save.data.fullscreen;
      //trace('LOADED FULLSCREEN SETTING!!');
    }
		PlayerSettings.init();
    ClientPrefs.loadDefaultKeys();
    ClientPrefs.loadPrefs();
    Application.current.window.title = LuaMain.data.windowTitle;
    if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
    }
    else
    {
      if(LuaMain.data.initialState == null)
        FlxG.switchState(new TitleState());
      else
      {
        CustomLuaState.curState = LuaMain.data.initialState;
        FlxG.switchState(new CustomLuaState());
      }
    }
    super.create();
  }
}