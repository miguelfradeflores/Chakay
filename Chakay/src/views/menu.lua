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

local background
local imagePath = "src/images/"
local audioPath = "src/sounds/"
local storiesGroup


function playChakay(  )
	local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 1000,
		}
	composer.gotoScene( "src.views.portada" , options)
end

function alloudTouch(  )
	touchable=true
end




------------------------SCENES
function scene:create( event )
	local sceneGroup = self.view
	storiesGroup = display.newGroup( )
	background = display.newRect( sceneGroup, _W/2, _H/2, _W, _H )
	background:setFillColor( 0 )
	local logo = display.newImageRect( sceneGroup, imagePath.."logo.png",  _W, 300 )
	logo.x=_W/2
	logo.y = 200

	local tittle = display.newText( sceneGroup, "Historietas", _W/2, _H/2  ,"arial" ,48 )


	sceneGroup:insert(  storiesGroup )

	comicOptions = display.newRect( storiesGroup, _W/2 -50,_H/2+150 , _W/4*3, 50  )
	comicOptions:setFillColor( 0.24,0.31,0.74 )

	comicText = display.newText( storiesGroup, "Chakai", _W/3, comicOptions.y+2 ,_W/2 , 50, "arial" ,36 )
	comicText:setFillColor(1,0,0)


		function storiesGroup:touch( e )

			if e.phase=="began" then

			elseif e.phase == "moved"then

			elseif e.phase == "ended" or e.phase == "cancelled" then
				playChakay()
			end

			return true
			
		end


end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen

	elseif phase == "did" then


		storiesGroup:addEventListener( "touch", storiesGroup )

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

		storiesGroup:removeEventListener( "touch", storiesGroup )
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
