//for the main.lua file, will probably add more things here soon
package;

typedef LuaData = {
  iconBop:Bool,
  saveFolder1:String,
  saveFolder2:String,
  modName:String,
  modVersion:String
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