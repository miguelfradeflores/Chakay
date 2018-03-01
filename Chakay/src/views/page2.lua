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

local background,leftPage,rightPage ,touchable
local imagePath = "src/images/"
local audioPath = "src/sounds/"

local audio4a = audio.loadSound(audioPath.."fn4a.mp3"  )
local audio4b = audio.loadSound(audioPath.."fn4b.mp3"  )
local audio5 = audio.loadSound(audioPath.."fn5.mp3"  )
local audio6 = audio.loadSound(audioPath.."fn6.mp3"  )
local audio7 = audio.loadSound(audioPath.."fn7.mp3"  )
local audio8 = audio.loadSound(audioPath.."fn8.mp3"  )


function alloudTouch(  )
	touchable=true
end



function hideBackground(  )
	background.isVisible=false
	leftPage.alpha=0
	leftPage.isVisible=true
	transition.to(leftPage,{time = 1500,alpha=1,onComplete=alloudTouch})
end

function hidePage(  )
	leftPage.isVisible=false
	rightPage.alpha=0
	rightPage.isVisible=true
	transition.to(rightPage,{alpha=1,time=1500,onComplete=alloudTouch})


end

local fondos = {"2a","2b","page6","page5","page7","page8","page8b","page9" }
local images={}
local currentPage=1

function swap(  )
	images[currentPage].isVisible=false
	images[currentPage+1].isVisible=true
	images[currentPage+1].alpha=0.6
	transition.to(images[currentPage+1],{ alpha=1,time=5500,onComplete=swap2}   )
	currentPage=currentPage+1
end

function swap2(  )
	images[currentPage].isVisible=false
	images[currentPage+1].isVisible=true
	images[currentPage+1].alpha=1
	transition.to(images[7],{ alpha=1,time=8000,onComplete=alloudTouch} )
	currentPage=currentPage+1
end


function changePage( )
	print(currentPage)
	if(currentPage<8 and touchable) then
		touchable=false
	images[currentPage].isVisible=false
	images[currentPage+1].isVisible=true
	images[currentPage+1].alpha=0

	ATime=1500
	if(currentPage==1)then
		audio.play(audio4b)
		ATime=6000
	elseif currentPage==2 then
		audio.play(audio5)
		ATime=2000
	elseif currentPage==3 then
		audio.play(audio6)
		ATime=5000
	elseif currentPage==4 then
		audio.play(audio7)
		ATime=19000

	elseif currentPage==7 then
		audio.play(audio8)
		ATime=7000
	-- elseif currentPage ==6 then
	-- 	audio.play(audio8)
	-- 	ATime=7000
	end

	if(currentPage~=4) then
		transition.to(images[currentPage+1],{ alpha=1,time=ATime,onComplete=alloudTouch}   )
	else
		transition.to(images[currentPage+1],{ alpha=1,time=5500,onComplete=swap}   )
	end

	currentPage=currentPage+1
		if(currentPage==8) then
			images[8].x=_W/3
			transition.to(images[8],{x=_W/2,time=5000})	
		end


	elseif(currentPage==8 and touchable) then
			local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 1000,
		}
		touchable2=false
		composer.gotoScene( "src.views.mano", options)

	end
end

function moveFrame2(  )
	transition.to(images[1],{y=_H/2,xScale=1,yScale=1,time=1300 })
end

------------------------SCENES
function scene:create( event )
	local sceneGroup = self.view

	for i=1, 8 do
	 	local wid=_W
	 
		images[i]   = display.newImageRect(sceneGroup,  "src/images/"..fondos[i]..  ".png",wid,_H )
		images[i].x = _W/2
		images[i].y = _H/2
		images[i].isVisible=false

		images[i].touch = changePage
		images[i]:addEventListener("touch",images[i])

	end


end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	-- leftPage.isVisible=false
	-- rightPage.isVisible=false
	-- background.isVisible=true

	images[1].isVisible=true
	images[1].xScale=3
	images[1].yScale=3
	images[1].y= _H*1.5
	currentPage=1
	elseif phase == "did" then
		touchable=false
		audio.play(audio4a)
		transition.to(images[1],{y=_H/2,time=4500,onComplete=moveFrame2 }   )
		transition.to(images[1],{time=6000,onComplete=alloudTouch})

	--	background:addEventListener("touch",background)

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
