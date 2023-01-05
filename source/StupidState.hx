//hopefully fixes save issues :))))))
package;

import flixel.FlxState;
import flixel.FlxG;
import lime.app.Application;


class StupidState extends FlxState
{
  override function create():Void
  {
    ConditionalManager.init();
    LuaMain.init();
    FlxG.save.bind(LuaMain.data.saveFile, 'funkin');
    ClientPrefs.loadDefaultKeys();
    ClientPrefs.saveSettings();
    Application.current.window.title = LuaMain.data.windowTitle;
    super.create();
  }
}