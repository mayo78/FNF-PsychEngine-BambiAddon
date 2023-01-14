//for the main.lua file, will probably add more things here soon
package;

typedef LuaData = {
  iconBop:Bool,
  saveFile:String,
  modName:String,
  modVersion:String,
  iconsPath:String,
  windowTitle:String,
  flashingStateText:String,
  initialState:Null<String>,
  updateLink:String,
  updateTxtLink:String,
  outdatedText:String
}
class LuaMain
{
  public static var data:LuaData;
  public static var conditionals:Array<String>;
  public static function init():Void
  {
    var lua:FunkinLua = new FunkinLua(Paths.mods('main.lua'));
    data = lua.call('getMainStuff', []);
    conditionals = lua.call('conditionals', []);
    lua.stop();
  }
  public static inline function conditional(conditional:String):Bool
    return conditionals.contains(conditional);
}