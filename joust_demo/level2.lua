local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
physics.start(); 
physics.pause();

local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5

function scene:createScene( event )
	local group = self.view

	local background = display.newRect( 0, 0, screenW, screenH )
	background:setFillColor( 128 )
	local sheetData = { width=23, height=30, numFrames=8, sheetContentWidth=320, sheetContentHeight=200 }
    local ostrich_opts = require "ostrich_opts"
    local ground_opts = require "ground_opts"
    local mySheet = graphics.newImageSheet( "joust.gif", ostrich_opts.options )
 
    local animation = display.newSprite( mySheet, ostrich_opts.sequenceData )
    animation.xScale = 2
    animation.yScale = 2 
    animation.x = halfW
    animation.y = halfH
    animation:setSequence("walk")
    
    local leftLedge = display.newImage(mySheet, ground_opts.leftLedge)
    leftLedge.x = leftLedge.width
    leftLedge.xScale = 2
    leftLedge.yScale = 2 
    leftLedge.y = 100
    
    local rightLedge = display.newImage(mySheet, ground_opts.rightLedge)
    rightLedge.x = screenW - rightLedge.width
    rightLedge.xScale = 2
    rightLedge.yScale = 2 
    rightLedge.y = 100
    
    local middleLedge = display.newImage(mySheet, ground_opts.middleLedge)
    middleLedge.x = halfW
    middleLedge.xScale = 2
    middleLedge.yScale = 2 
    middleLedge.y = 120
    
    local bottomMiddleLedge = display.newImage(mySheet, ground_opts.bottomMiddleLedge)
    bottomMiddleLedge.xScale = 2
    bottomMiddleLedge.yScale = 2 
    bottomMiddleLedge.x = halfW
    bottomMiddleLedge.y = 220
    
    local bottomLeftLedge = display.newImage(mySheet, ground_opts.bottomLeftLedge)
    bottomLeftLedge.x = bottomLeftLedge.width
    bottomLeftLedge.xScale = 2
    bottomLeftLedge.yScale = 2 
    bottomLeftLedge.y = 195
    
    local bottomRightLedgeWithSpawn = display.newImage(mySheet, ground_opts.bottomRightLedgeWithSpawn)
    bottomRightLedgeWithSpawn.x = screenW - bottomRightLedgeWithSpawn.width *1.5
    bottomRightLedgeWithSpawn.xScale = 2
    bottomRightLedgeWithSpawn.yScale = 2 
    bottomRightLedgeWithSpawn.y = 180
    
    local bottomRightLedgeNoSpawn = display.newImage(mySheet, ground_opts.bottomRightLedgeNoSpawn)
    bottomRightLedgeNoSpawn.xScale = 2
    bottomRightLedgeNoSpawn.yScale = 2 
    bottomRightLedgeNoSpawn.x = screenW - bottomRightLedgeNoSpawn.width
    bottomRightLedgeNoSpawn.y = 195
 
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