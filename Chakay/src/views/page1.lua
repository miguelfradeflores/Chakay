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

local audio1 = audio.loadSound( "src/sounds/fn3.mp3")
local audio2 = audio.loadSound( "/src/sounds/page2a.mp3")



function alloudTouch(  )
	touchable=true
	rightPage.isVisible=true
	rightPage.alpha=0
--	blackPanelRight.isVisible=false
	transition.to(rightPage, {alpha=1,time=2000 ,onComplete=moveFrame2 })
end

function alloudTouch2( ... )
	touchable2=true
end

function alloudTouch3( ... )
--	polygon.isVisible=false
	rightPage2.isVisible=true
	rightPage2.alpha=0
	-- transition.to(polygon,{alpha=0,time=2000} )
	transition.to(rightPage2,{alpha=1,time=2000,onComplete=alloudTouch2})
end


local fondos = {"portada","page1","page2","page3","page4"}
local images={}
local currentPage=1


function moveFrame1()

	if touch1 then
		audio.play(audio1)
		touch1 = false
		print("start")
		transition.to(leftPage,{xScale=1,yScale=1,x=_W/2,y=_H/2,time=4200,onComplete=alloudTouch2 } )
	end
end

function moveFrame2( ... )
	if touchable then
		touchable=false
		transition.to(rightPage,{y=0,time=3000,onComplete=moveFrame2a})
	--	music:stop("audio1")
		audio.play(audio2)
	end
end

function moveFrame2a(  )
	transition.to(rightPage,{xScale=1,yScale=1,y=_H/4+60,time=3000,onComplete=alloudTouch3 })

end



--Main Page Handler
function changePage(  )

	if(touchable2) then
		local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 1000,
		}
		touchable2=false
		composer.gotoScene( "src.views.menu", options)
		return true
	end

end


function scene:create( event )
	local sceneGroup = self.view


	rightPage = display.newImageRect(sceneGroup,"src/images/2a.png",_W/2 -20,_H/8*6)
	rightPage.x=_W/4*3


	leftPage = display.newImageRect(sceneGroup,"src/images/page1.png",_W,_H)
	



--	blackPanelRight = display.newRect(sceneGroup,_W/4*3,_H/2,_W/2,_H )
--	blackPanelRight:setFillColor(0)


	rightPage2 = display.newImageRect(sceneGroup,"src/images/2b.png",_W/2 -20,_H/8*2)
	rightPage2.x=_W/4*3
	rightPage2.y=_H/4*3 +60

	-- polygon = display.newPolygon(sceneGroup,_W/4*3,_H/4*3 +50,{ 0,100,0,-_H/8-50,_W/2 , -_H/8 -140,_W/2,100 }  )
	-- polygon:setFillColor(0)

end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	-- leftPage.isVisible=false
	-- rightPage.isVisible=false
	-- background.isVisible=true

	leftPage.x=_W/6
	leftPage.y=_H*4/3
	leftPage.xScale=2.4
	leftPage.yScale=2.4

	rightPage.isVisible=false
	rightPage.y=_H/4 +180
	rightPage.xScale=3
	rightPage.yScale=3
--	blackPanelRight.isVisible=true
	rightPage2.isVisible=false
	-- polygon.isVisible=true
	-- polygon.alpha=1

	elseif phase == "did" then
		touch1=true
		touchable2=false
		touchable=false


	Runtime:addEventListener("touch",changePage)

		moveFrame1()
		audio.play(audio1)
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


		Runtime:removeEventListener("touch",changePage)

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
