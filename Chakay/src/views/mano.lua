-----------------------------------------------------------------------------------------
--
-- composer.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local _W = display.contentWidth
local _H = display.contentHeight
local engine = audio.loadSound("src/sounds/dedos.mp3")
local riff = audio.loadSound("src/sounds/reef.mp3")
local instrucciones = audio.loadSound("src/sounds/fn9.mp3")


local mainDot

local background,leftPage,rightPage,rightPage2 ,touch, touchable,touchable2,polygon,message
local imagePath = "src/images/"
local lineGroup,handGroup,dotGroup
--setting circles position and table for holding
local totalCircles = 8
local pointsX={_W/2,_W/3, _W/3-90,_W/2-80,_W/3+90, _W/2+45,_W/4*3-60,_W/2+88}
local pointsY= {_H/8*7,_H/4*3,_H/4 +80,_H/2 +45,  _H/4+60,  _H/2 +45,_H/4+65,_H/4*3 -35}
local dots={}
local radiusConst = 10
local currentDot = 2
local nextObject,newX,newY

--
local restartButton

function chancgePage( e)
--	if e.phase=="ended" then
		local options =
		{
			effect = "fade", --"zoomOutInFade"
			time = 1000,
		}
		composer.gotoScene( "src.views.page1", options)
--	end
	return true
end


function alloudTouch2(  )
	touchable=true
end
-----------------------------------------------------------sprites-----------------
local f1,f2,f3,thumb,metal,star,failHand

local finger1 = graphics.newImageSheet( imagePath.. "leftFinger.png", { width=200,height=226,numFrames=3   })
local finger2 = graphics.newImageSheet( imagePath.."middleFinger.png", { width=200,height=226,numFrames=3   })
local finger3 = graphics.newImageSheet( imagePath.."rightFinger.png", { width=200,height=226,numFrames=3   })
local finger4 = graphics.newImageSheet( imagePath.."thumb.png", { width=200,height=226,numFrames=3   })


local sequence={
	{name="flex",sheet=finger1, frames={1,2,3,3,2,1}, time=500,  loopCount = 2},
}
local sequence2={
	{name="flex",sheet=finger2, frames={1,2,3,3,2,1}, time=500,  loopCount = 2},
}

local sequence3={
	{name="flex",sheet=finger3, frames={1,2,3,3,2,1}, time=500,  loopCount = 2},
}

local sequence4={
	{name="flex",sheet=finger4, frames={1,2,3,3,2,1}, time=500,  loopCount = 2},
}

function moveRightFinger ( )
 	f3:play()
 	transition.to(thumb,{onComplete=win,time=3000} )

 end 

function moveMiddleFinger( )
	f2:play()
	transition.to(f3,{time=125,onComplete=moveRightFinger})

end

----------
function validCircle( poxX,posY )
		print(poxX  .. " Y:"  .. posY )
	for i=2,totalCircles,1 do
		if( posX >pointsX[i]-radiusConst and posX<pointsX[i]+radiusConst and  posY>pointsY[i]-radiusConst and posY<pointsY[i]+radiusConst ) then
		if dots[i].checked == false then
				dots[i].checked=true
				dots[i].alpha=1
				dots[i]:setFillColor(0,1,0)
				print("dots " .. i .."changed to checked status")
				return true
			end
		end	
	end
	return false
end


function blink2( )
	transition.to(nextObject,{time=200,tag="blink",onComplete=blink} )
end

function blink( )
	nextObject.alpha=1
	transition.to(nextObject,{alpha=0.3,time=1000, tag="blink",  onComplete=blink2 } )
end

function drawLines( p1x,p1y,p2x,p2y )
	local line = display.newLine(lineGroup, p1x,p1y,p2x,p2y)
	line:setFillColor(0,0,1)
	line.strokeWidth=3
end

function clearLines(  )
	print(#lineGroup)
	for i= lineGroup.numChildren, 1,-1 do
		lineGroup[i]:removeSelf()
		lineGroup[i]=nil
	end

	for i=2,totalCircles do
		dots[i].checked=false
		dots[i].alpha=0.4
		dots[i]:setFillColor(0,0,1)
	end

end


function restart(  )
	failHand.isVisible=false
	metal.isVisible=false
	star.isVisible=false
	handGroup.isVisible=true
	dotGroup.isVisible=true
	restartButton.isVisible=false

	return true
end

function win( )
	metal.isVisible=true
	star.isVisible=true
	handGroup.isVisible=false
	dotGroup.isVisible=false
	audio.play(riff)
	transition.to(star,  {rotation=72600,time=5000} )
	transition.to( metal, { xScale =2,yScale=2,onComplete=rock,time =1000  } )
end

function rock( )
	transition.to(metal,{ xScale=1,yScale=1,time=500,onComplete=rock2 }   )
end

function rock2( )
	transition.to(metal,{ xScale=1.8,yScale=1.8,time=700 ,onComplete=rock3}   )
end

function rock3( )
	transition.to(metal,{ xScale=1,yScale=1,time=800 }   )
end


function showMessage( txt,color )
	 message.alpha=0
	 message.isVisible = false
	 message.text= txt

	 restartButton.isVisible=true
	 failHand.isVisible=true
	 handGroup.isVisible=false
	 lineGroup.isVisible=false

	 if color == "green" then
	 	message:setTextColor(0,1,0)
	else
		message:setTextColor(1,0,0)
	end
	 touch=false
	 transition.to(message,{ time = 2000 ,alpha=0.6 ,onComplete=hideMessage})
end

function hideMessage(  )
	message.isVisible=false
	touch =true
	clearLines()
end

-------------------scnes
function scene:create( event )
	local sceneGroup = self.view
	lineGroup = display.newGroup()
	handGroup = display.newGroup()
	dotGroup = display.newGroup()
	--background = display.newImageRect(sceneGroup,imagePath.."mano.jpg",_W,_H)
	background = display.newRect(sceneGroup,  0,0,_W,_H)
	background.x=_W/2
	background.y=_H/2
	background:setFillColor(239/255,248/255,110/255)

	restartButton = display.newImageRect(sceneGroup, imagePath.."palm.png",80,80)
	restartButton.x=100
	restartButton.y=100
	restartButton.isVisible=false

	sceneGroup:insert(handGroup)
	sceneGroup:insert(dotGroup)
	sceneGroup:insert(lineGroup)

	f1   = display.newSprite( finger1, sequence )
	f1.x = _W/3 +16
	f1.y = _H/4 +22

	f2   = display.newSprite(finger2,sequence2)
	f2.x = _W/2 -8
	f2.y = _H/4+4

	f3 = display.newSprite(finger3 , sequence3 )
	f3.x = _W/2 + 65
	f3.y = _H/4 + 10

	thumb = display.newSprite(finger4, sequence4 )
	thumb.x = _W/8*5 +40
	thumb.y = _H/2 -70


	local palm = display.newImageRect(handGroup, imagePath.."palm.png",415,416)
	palm.x=_W/2
	palm.y=_H/2 -25

	star = display.newImageRect(sceneGroup,imagePath.."estrella.png" ,_W/4*3,_W/4*3 )
	star.x=_W/2
	star.y=_H/2
	star.isVisible=false

	failHand = display.newImageRect(sceneGroup,imagePath.."palm.png",_W/2,_H/2)
	failHand.x+_W/2
	failHand.y=_H/2
	failHand.isVisible=false

	metal = display.newImageRect(sceneGroup, imagePath.."metal.png",_W/4*3 *0.73 ,_W/4*3 )
	metal.x=_W/2 
	metal.y=_H/2
	metal.isVisible=false

	handGroup:insert(f1)
	handGroup:insert(f2)
	handGroup:insert(f3)
	handGroup:insert(thumb)

	for i=1,totalCircles  ,1 do
		dots[i]= display.newCircle( dotGroup, pointsX[i],pointsY[i],12)
		dots[i]:setFillColor(0,0,1)
		dots[i].alpha=0.4
		dots[i].checked=false
	end

	message=display.newText(sceneGroup, "FALLASTE!!",_W/4,_H/8*7,400,100,"arial",48  )
	message.isVisible=false
	message:setTextColor(1,0,0)

end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		dots[1].alpha=1
	handGroup.y = 60
	handGroup.x = -150
	handGroup.xScale=1.4
	handGroup.yScale=1.4


	elseif phase == "did" then

	audio.play(instrucciones)
	touch=true
	mainDot = dots[1]
	mainDot.xScale=1.5
	mainDot.yScale=1.5

		function mainDot:touch( e )
			if(touch) then
				local t =e.target
				if(e.phase=="began") then
					display.getCurrentStage():setFocus( t )
					self.isFocus = true
					myLine = nil
					newX =dots[1].x
					newY =   dots[1].y
					currentDot=2
					nextObject=dots[2]
					blink()
				elseif (self.isFocus) then
					if (e.phase=="moved") then
						
						if(myLine) then
							myLine.parent:remove(myLine)
						end
						myLine = display.newLine(  newX,newY,e.x,e.y)
						myLine.strokeWidth = 5
						myLine:setStrokeColor(180/255,244/255,255/255  )
						for i=2,totalCircles,1 do
							if(e.x>pointsX[i]-radiusConst and e.x<pointsX[i]+radiusConst and  e.y>pointsY[i]-radiusConst and e.y<pointsY[i]+radiusConst  )  then
								if(dots[i].checked==false) then
									dots[i].alpha=1
									dots[i]:setFillColor(1,0,0)
									print( "the dot number " ..i.." was reached, looking for" .. currentDot   )
									dots[i].checked=true
								
									if(i==currentDot  ) then
										transition.cancel("blink")
										dots[i]:setFillColor(0,1,0)
											local completeLine = display.newLine( lineGroup, newX,newY,dots[currentDot].x,dots[currentDot].y )
											completeLine:setStrokeColor(1,1,0)
											completeLine.strokeWidth=4
											newX=dots[i].x
											newY=dots[i].y
										if(currentDot<totalCircles) then
											currentDot=currentDot+1
											print(currentDot .." increased")
											nextObject=dots[currentDot]
											blink()
										else 
											display.getCurrentStage():setFocus( nil )
											self.isFocus = false
											if(myLine) then
												myLine.parent:remove(myLine)
											end
											showMessage("GANASTE", "green" )
										end

										if i==4 then
											f1:play()
											audio.play(engine)
										end

										if i==6 then
											f2:play()
											audio.play(engine)
										end

										if i ==totalCircles then
											audio.play(engine)
											f1:play()
											thumb:play()
											transition.to(f2,{time=100,onComplete=moveMiddleFinger})
										end

									else
										dots[i]:setFillColor(1,0,0)
										transition.cancel("blink")
										display.getCurrentStage():setFocus( nil )
										self.isFocus = false
										if(myLine) then
											myLine.parent:remove(myLine)
										end
										showMessage("FALLASTE","red")

									end
							

								end

							end
						end



					elseif(e.phase=="ended" or e.phase =="cancelled") then
						display.getCurrentStage():setFocus( nil )
						self.isFocus = false
						showMessage("FALLASTE","red")
						transition.cancel("blink")
						if(myLine) then
							myLine.parent:remove(myLine)
						end
					end
				end	


			else
				print("not ready to touch") 
			end
		end
		restartButton.touch=restart
		restartButton:addEventListener("touch",restartButton)

		mainDot:addEventListener("touch",mainDot)

	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		
		
	elseif phase == "did" then
		-- Called when the scene is now off screen


	end		

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- f (n) =186 + 2^n + 45n^3 + 1024n + 1675 + 2n^9 +1e^n
	-- g(n) = 26n^4 + 5n + 16^n + 26n^2 + 9n^7
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
