-----------------------------------------------------------------------------------------
--
-- composer.lua
--
-----------------------------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local composer = require( "composer" )
local scene = composer.newScene()


local video ,background

local valid = false


local story = audio.loadSound("src/sounds/chakay.mp3")
function changeScene()
	if valid then

				print("cahnging page1 to page2")
		local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 500,
		}
		composer.gotoScene( "src.views.mano", options)
		return true
	else print("not ready")

	end	
end

function alloud( )
	valid=true
end

function scene:create( event )
	local sceneGroup = self.view

	background = display.newRect(sceneGroup, 0,0,_W,_H)
	background:setFillColor(0)

	video = native.newVideo(_W/2,_H/2,_W-8,_H-8)
	video:load("src/videos/chakay.m4v")

	sceneGroup:insert(video)



end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
	valid=false


	local function videoListener( event )
	    print( "Event phase: " .. event.phase )
	  
	    if event.errorCode then
	        native.showAlert( "Error!", event.errorMessage, { "OK" } )
	    end
	end


	video:addEventListener( "video", videoListener )
	 
	-- Play video
	video:play()

	transition.to(background,{time=1000,onComplete =alloud })
	Runtime:addEventListener("touch",  changeScene )

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
		
	video:pause()	
	video:removeSelf()
	video = nil


	Runtime:removeEventListener("touch",changeScene)
	elseif phase == "did" then
		-- Called when the scene is now off screen
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
