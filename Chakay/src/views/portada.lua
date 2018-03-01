-----------------------------------------------------------------------------------------
--
-- composer.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local _W = display.contentWidth
local _H = display.contentHeight

local picturesButton

local background,leftPage,rightPage,rightPage2 ,touch1, touchable,touchable2,polygon
local imagePath = "src/images/"

function chancgePage( e)
--	if e.phase=="ended" then
		local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 500,
		}
		composer.gotoScene( "src.views.page1", options)
--	end
	return true
end

function alloudTouch(  )
	touchable=true
	rightPage.isVisible=true
	rightPage.alpha=0
	blackPanelRight.isVisible=false
	transition.to(rightPage, {alpha=1,time=2000 ,onComplete=moveFrame2 })
end

function alloudTouch2( ... )
	touchable2=true
end

function alloudTouch3( ... )
--	polygon.isVisible=false
	rightPage2.isVisible=true
	rightPage2.alpha=0
	transition.to(polygon,{alpha=0,time=2000} )
	transition.to(rightPage2,{alpha=1,time=2000})
end


function moveFrame1()

	if touch1 then
		touch1 = false
		print("start")
		transition.to(leftPage,{xScale=1,yScale=1,x=_W/2,y=_H/2,time=4000,onComplete=alloudTouch } )
	end
end

function moveFrame2( ... )
	if touchable then
		touchable=false
		transition.to(rightPage,{y=0,time=5000,onComplete=moveFrame2a})
	end
end

function moveFrame2a(  )
	transition.to(rightPage,{xScale=1,yScale=1,y=_H/4+60,time=2000,onComplete=alloudTouch3 })

end


function scene:create( event )
	local sceneGroup = self.view

	background = display.newImageRect(sceneGroup,imagePath.."portada.png",_W,_H)
	background.x=_W/2
	background.y=_H/2

end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


		background.touch=chancgePage	
		background:addEventListener("touch",background)
	elseif phase == "did" then

		

	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		
	elseif phase == "did" then
		-- Called when the scene is now off screen


	background:removeEventListener("touch",background)

	end		

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
