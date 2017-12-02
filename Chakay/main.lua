display.setStatusBar(display.HiddenStatusBar)
system.activate('multitouch')




local composer      = require "composer"
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

local function main(  )
	local options =
	{
		effect = "fade", --"zoomOutInFade"
		time = 1000,
	}
	--composer.gotoScene( "src.app.scenes.game", options)
	composer.gotoScene( "src.views.portada", options)
	return true
end

main()


