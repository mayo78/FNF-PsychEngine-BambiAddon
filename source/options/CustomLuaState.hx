package options;
//basically a state that has different names and runs lua/hscript only

class CustomLuaState extends BaseOptionsMenu
{
  public static var instance:CustomLuaState;
  public function new(?title:String = 'Custom Lua Options')
  {
    instance = this;
		OptionsState.optionInstance = this;
		CoolUtil.inOptions = true;
    this.title = title;
    super();
  }
}