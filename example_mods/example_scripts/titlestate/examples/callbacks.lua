--list of callbacks in this state
function onCreateTitle() --called when the sprites for this state are about to be made
  --[[ you can stop this function
  return Function_Stop;
  ]]
end
function onIntroStart() --called when the intro starts (when the intro text appearing and stuff)
  
end
function sickBeatHit(sickBeat) --called every beat, specifically for the intro text
  
end
function onSkipIntro() --when the main title screen starts (with gf and stuff)
  
end
--callable callbacks
createCoolText(text:Array<String>, ?offset:Float = 0) --makes new text in the intro
createCoolText({'my cool text', 'mod by this guy'}, 15)

addMoreText(text:String, ?offset:Float = 0) --adds on to existing text
addMoreText('and this guy', 15)

--how to delete coolText
callMethod 'deleteCoolText'
