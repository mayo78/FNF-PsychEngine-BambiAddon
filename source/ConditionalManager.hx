package;

import sys.io.File;
import sys.FileSystem;

using StringTools;

class ConditionalManager
{
  public static var CHECK_FOR_UPDATES:Bool = true;
  public static var MODS_ALLOWED:Bool = true;
  public static var PSYCH_WATERMARKS:Bool = false;
  
  public static function init():Void
  {
    var path:String = 'mods/conditionals.txt';
		if(FileSystem.exists(path))
		{
			var conditionals:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...conditionals.length)
			{
				if(conditionals.length > 1 && conditionals[0].length > 0) {
					var splitGuy:Array<String> = conditionals[i].split(': ');
          Reflect.setProperty(null, splitGuy[0].trim(), splitGuy[1].trim() == 'true');
          trace('setting conditional: ' + splitGuy[0], splitGuy[1], splitGuy[1].trim() == 'true');
				}
			}
		}
  }
}