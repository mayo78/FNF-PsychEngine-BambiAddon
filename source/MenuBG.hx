package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.FlxG;

class MenuBG extends FlxSprite
{
	private var idleAnim:String;
  public var isFlickering:Bool = false;
  var daColor:Int; //for flickering
	
	public var daBG:Array<Dynamic>;

  public static var bgs:Array<Array<Dynamic>> = [
    ['menuDesat', true]
  ]; //image name, antialiasing
  
  public static var MAIN_COLOR:Int = 0xFFFDE871; //NOTE: ADJUST COLORS SO THEY LOOK LIKE THE ORIGINALS!!!
  public static var SELECTED_COLOR:Int = 0xFFFD719B;
  public static var SECONDARY_COLOR:Int = 0xFF9271FD;
	
	public var wasAdded:Bool = false;

	public function new(x:Float = 0, y:Float = 0, ?color:Int = null, ?image:String = null) {
		super(x, y);
    
    if(color != null)
    {
      this.color = color;
      daColor = color;
    }
    else
    {
      this.color = MenuBG.MAIN_COLOR;
      daColor = this.color;
    }
    
    daBG = bgs[((image == null) ? FlxG.random.int(0, MenuBG.bgs.length-1) : findTheShit(image))];

    loadGraphic(Paths.image(daBG[0]));
		daBG[1] = daBG[1] ? ClientPrefs.globalAntialiasing : false;
    antialiasing = daBG[1];
	}
	
	private function findTheShit(what:String)
	{
		for(i in 0...bgs.length-1)
		{
			if(bgs[i][0] == what)
      {
				return i;
        break;
      }
		}
		return 0;
	}
}
