function onOptionsAdded(name) --called when an option thing is opened
  --[[
  if name == 'Modchart Settings' then
    --add options
  end
  ]]
end

addState(name:String) --adds an option menu listing for a custom options substate
--NOTE: THIS DOESNT OPEN CUSTOM LUA STATES!!! IT OPENS ITS OWN THING TO BE USED IN onOptionsAdded
addState 'Modchart settings'

addOption(optionStuff:OptionsData) 
addOption{ --btw addOption{stuff} = addOption({stuff})
  name = 'TEST option',
  variable = 'test_option',
  type = 'bool',
  defaultValue = false
}
--[[
the typedef for that function (basiclly you can define any typdef name in the lua table and it will work):
typedef OptionsData = {
	name:String,
	description:String,
	variable:String,
	type:String,
	defaultValue:Dynamic,
	options:Array<String>,
	text:String,
	showBoyfriend:Null<Bool>,
	scrollSpeed:Null<Float>,
	changeValue:Dynamic,
	minValue:Dynamic,
	maxValue:Dynamic,
	decimals:Null<Int>,
	displayFormat:String
}
you can check out what each value does in source/options/Option.hx
]]