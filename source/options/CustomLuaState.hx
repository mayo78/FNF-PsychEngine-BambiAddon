package options;
//basically a state that has different names and runs lua/hscript only

class CustomLuaState extends BaseOptionsMenu
{
  public static var instance:CustomLuaState;
  public static var curState:String = '';
  public function new(?state:String)
  {
    curState = state;
    instance = this;
		OptionsState.optionInstance = this;
		CoolUtil.inOptions = true;
    super();
    callOnLuas('onCreatePost', []);
  }
  override function update(elapsed:Float)
  {
    callOnLuas('onUpdate', [elapsed]);
    super.update(elapsed);
    callOnLuas('onUpdatePost', [elapsed]);
  }
}