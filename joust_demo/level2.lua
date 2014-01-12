local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
physics.start(); 
physics.pause();

local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:createScene( event )
	local group = self.view

	local background = display.newRect( 0, 0, screenW, screenH )
	background:setFillColor( 128 )
	local sheetData = { width=23, height=30, numFrames=8, sheetContentWidth=320, sheetContentHeight=200 }
    local ostrich_opts = require "ostrich_opts"
    local mySheet = graphics.newImageSheet( "joust.gif", sheetData )
    local sequenceData = {
        { name = "walk", start=2, count=4, time=500 },
        { name = "fly", start=7, count=2, time=800 },
        { name = "run", frames={ 2,3,4,5 }, time=250 }
    }
 
    local animation = display.newSprite( mySheet, sequenceData )
    animation.x = display.contentWidth/2  --center the sprite horizontally
    animation.y = display.contentHeight/2  --center the sprite vertically
    animation:setSequence("walk")
 
    animation:play()
 
	
	group:insert( background )
end

function scene:enterScene( event )
	local group = self.view
	
	physics.start()
end

function scene:exitScene( event )
	local group = self.view
	
	physics.stop()
end

function scene:destroyScene( event )
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene