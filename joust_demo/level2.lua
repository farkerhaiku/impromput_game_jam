local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
physics.start(); 
physics.pause();

local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5
local leftLedge, rightLedge, middleLedge, bottomMiddleLedge, bottomLeftLedge, bottomRightLedgeWithSpawn, bottomRightLedgeNoSpawn
local basePlatformRight, basePlatformLeft, basePlatformMid
local scaleAndPhysics = function(platform)
    physics.addBody( platform, "static", { density=1.0 } )
    platform.xScale = 2
    platform.yScale = 2
end
local setupPlatforms = function(mySheet, opts)
    leftLedge = display.newImage(mySheet, opts.leftLedge)
    leftLedge.x = leftLedge.width
    leftLedge.y = 100
    scaleAndPhysics(leftLedge)
    
    rightLedge = display.newImage(mySheet, opts.rightLedge)
    rightLedge.x = screenW - rightLedge.width
    rightLedge.y = 100
    scaleAndPhysics(rightLedge)
    
    middleLedge = display.newImage(mySheet, opts.middleLedge)
    middleLedge.x = halfW
    middleLedge.y = 120
    scaleAndPhysics(middleLedge)
    
    bottomMiddleLedge = display.newImage(mySheet, opts.bottomMiddleLedge)
    bottomMiddleLedge.x = halfW
    bottomMiddleLedge.y = 220
    scaleAndPhysics(bottomMiddleLedge)
    
    bottomLeftLedge = display.newImage(mySheet, opts.bottomLeftLedge)
    bottomLeftLedge.x = bottomLeftLedge.width
    bottomLeftLedge.y = 196
    scaleAndPhysics(bottomLeftLedge)
    
    bottomRightLedgeNoSpawn = display.newImage(mySheet, opts.bottomRightLedgeNoSpawn)
    bottomRightLedgeNoSpawn.x = screenW - bottomRightLedgeNoSpawn.width
    bottomRightLedgeNoSpawn.y = 196
    scaleAndPhysics(bottomRightLedgeNoSpawn)
    
    bottomRightLedgeWithSpawn = display.newImage(mySheet, opts.bottomRightLedgeWithSpawn)
    bottomRightLedgeWithSpawn.x = screenW - bottomRightLedgeWithSpawn.width *1.5
    bottomRightLedgeWithSpawn.y = 180
    scaleAndPhysics(bottomRightLedgeWithSpawn)

    basePlatformMid = display.newImage(mySheet, opts.basePlatformMid)
    scaleAndPhysics(basePlatformMid)
    
    basePlatformRight = display.newImage(mySheet, opts.basePlatformRight)
    basePlatformRight.y = screenH - basePlatformRight.height
    basePlatformRight.x = 135
    scaleAndPhysics(basePlatformRight)
    
    basePlatformLeft = display.newImage(mySheet, opts.basePlatformLeft)
    basePlatformLeft.y = screenH - basePlatformLeft.height
    basePlatformLeft.x = 465
    scaleAndPhysics(basePlatformLeft)
    
    basePlatformMid.y = screenH - basePlatformLeft.height * 2 + basePlatformMid.height
    basePlatformMid.x = 300
    
end

function scene:createScene( event )
	local group = self.view

	local background = display.newRect( 0, 0, screenW, screenH )
	background:setFillColor( 128 )
	local sheetData = { width=23, height=30, numFrames=8, sheetContentWidth=320, sheetContentHeight=200 }
    local ostrich_opts = require "ostrich_opts"
    local ground_opts = require "ground_opts"
    local mySheet = graphics.newImageSheet( "joust.gif", ostrich_opts.options )
 
    local animation = display.newSprite( mySheet, ostrich_opts.sequenceData )
    animation.x = halfW
    animation.y = halfH
    physics.addBody( animation, { bounce=.1 } )
    animation:setSequence("walk")
    
    setupPlatforms(mySheet, ground_opts)
 
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