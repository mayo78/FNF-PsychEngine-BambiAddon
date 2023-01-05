//for the main.lua file, will probably add more things here soon
package;

typedef LuaData = {
  iconBop:Bool,
  saveFile:String,
  modName:String,
  modVersion:String,
  iconsPath:String,
  windowTitle:String,
  flashingStateText:String
}
class LuaMain
{
  public static var data:LuaData;
  public static function init():Void
  {
    var lua:FunkinLua = new FunkinLua(Paths.mods('main.lua'));
    data = lua.call('getMainStuff', []);
    lua.stop();
    
  }
}