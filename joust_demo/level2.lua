local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
physics.start(); 
physics.pause();
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5
local leftLedge, rightLedge, middleLedge, bottomMiddleLedge, bottomLeftLedge, bottomRightLedgeWithSpawn, bottomRightLedgeNoSpawn
local basePlatformRight, basePlatformLeft, basePlatformMid

local scaleAndPhysics = function(platform)
    physics.addBody( platform, "static", { density=1.0 } )
    platform.anchorX = 0.5
    platform.anchorY = 0.5
    platform.xScale = 2
    platform.yScale = 2
end

local setupPlatforms = function(mySheet, opts)
    leftLedge = display.newImage(mySheet, opts.leftLedge)
    scaleAndPhysics(leftLedge)
    leftLedge.x = leftLedge.width
    leftLedge.y = 100
    
    rightLedge = display.newImage(mySheet, opts.rightLedge)
    scaleAndPhysics(rightLedge)
    rightLedge.x = screenW - rightLedge.width
    rightLedge.y = 100
    
    middleLedge = display.newImage(mySheet, opts.middleLedge)
    scaleAndPhysics(middleLedge)
    middleLedge.x = halfW
    middleLedge.y = 120
    
    bottomMiddleLedge = display.newImage(mySheet, opts.bottomMiddleLedge)
    scaleAndPhysics(bottomMiddleLedge)
    bottomMiddleLedge.x = halfW
    bottomMiddleLedge.y = 220
    
    bottomLeftLedge = display.newImage(mySheet, opts.bottomLeftLedge)
    scaleAndPhysics(bottomLeftLedge)
    bottomLeftLedge.x = bottomLeftLedge.width
    bottomLeftLedge.y = 196
    
    bottomRightLedgeNoSpawn = display.newImage(mySheet, opts.bottomRightLedgeNoSpawn)
    scaleAndPhysics(bottomRightLedgeNoSpawn)
    bottomRightLedgeNoSpawn.x = screenW - bottomRightLedgeNoSpawn.width
    bottomRightLedgeNoSpawn.y = 196
    
    bottomRightLedgeWithSpawn = display.newImage(mySheet, opts.bottomRightLedgeWithSpawn)
    scaleAndPhysics(bottomRightLedgeWithSpawn)
    bottomRightLedgeWithSpawn.x = screenW - bottomRightLedgeWithSpawn.width *1.5
    bottomRightLedgeWithSpawn.y = 180

    basePlatformMid = display.newImage(mySheet, opts.basePlatformMid)
    scaleAndPhysics(basePlatformMid)
    
    basePlatformRight = display.newImage(mySheet, opts.basePlatformRight)
    scaleAndPhysics(basePlatformRight)
    basePlatformRight.y = screenH - basePlatformRight.height
    basePlatformRight.x = 135
    
    basePlatformLeft = display.newImage(mySheet, opts.basePlatformLeft)
    scaleAndPhysics(basePlatformLeft)
    basePlatformLeft.y = screenH - basePlatformLeft.height
    basePlatformLeft.x = 465
    
    basePlatformMid.y = screenH - basePlatformLeft.height * 2 + basePlatformMid.height
    basePlatformMid.x = 300
    
end
local onKeyEvent = function( event )
    if (event.phase == "down") then
        if (event.keyName == "down" or event.nativeKeyCode == 125) then
            print("firing down")
        end
        
        if (event.keyName == "left" or event.nativeKeyCode == 123) then
            print("firing left")
        end
        
        if (event.keyName == "right" or event.nativeKeyCode == 124) then
            print("firing right")
        end
        
        if (event.keyName == "up" or event.nativeKeyCode == 126) then
            print("firing up")
        end
    end

    -- If the "back" key was pressed on Android, then prevent it from backing out of your app.
    if (event.keyName == "back") and (system.getInfo("platformName") == "Android") then
        return true
    end
    
    return false
end
function scene:createScene( event )
    Runtime:addEventListener( "key", onKeyEvent )
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
    
    setupPlatforms(mySheet, ground_opts)
 
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