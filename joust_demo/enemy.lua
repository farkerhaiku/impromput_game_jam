local enemy_opts = require "enemy_opts"
local ostrich_opts = require "ostrich_opts"
local ground_opts = require "ground_opts"
local badGuysList = {}

local animationGroup, mySheet
local enemyCollisionFilter = { categoryBits = 4, maskBits = 26 }

local velocity, flying = 0, false


local badGuyCollision = function(event)
    if(event.phase == "began" and event.other.myName == "playerOne") then
        
    end
end

local createBadGuy = function(mySheet)
    local badGuy = display.newSprite( mySheet, enemy_opts.sequenceData)
    badGuy.anchorX = 0.5
    badGuy.anchorY = 0.5
    badGuy.myName = "enemy"
    
    physics.addBody( badGuy, { density=0.5, friction=.2, bounce=.1, filter=alienCollisionFilter } )
    badGuy.isFixedRotation = true
    badGuy.collision = badGuyCollision
    badGuy:addEventListener("collision", badGuy)
    
    badGuy.x = halfW
    badGuy.y = halfH
end

local floorCollision = function(self, event)
    if (animation.sequence == "fly" and event.phase == "began") then
        print("floor collision", self.y, event.other.y)
        if not (event.other.y > self.y) then -- colliding from above
            correctAnimationState()
        end
    end
end

local wallCollision = function(self, event)
    print("this is where i would put the thingie on the other side")
end

local scaleAndPhysics = function(platform)
    physics.addBody( platform, "static", { density=1.0, filter=floorCollisionFilter } )
    platform.collision = floorCollision
    platform:addEventListener( "collision", platform )
    platform.anchorX = 0
    platform.anchorY = 0
end

local gameLoop = function() 
end

local setupPlatforms = function(mySheet, opts)
    leftLedge = display.newImage(mySheet, opts.leftLedge)
    scaleAndPhysics(leftLedge)
    leftLedge.x = 0
    leftLedge.y = 100
    
    rightLedge = display.newImage(mySheet, opts.rightLedge)
    scaleAndPhysics(rightLedge)
    rightLedge.x = screenW - rightLedge.width
    rightLedge.y = 100
    
    middleLedge = display.newImage(mySheet, opts.middleLedge)
    scaleAndPhysics(middleLedge)
    middleLedge.x = 180
    middleLedge.y = 120
    
    bottomMiddleLedge = display.newImage(mySheet, opts.bottomMiddleLedge)
    scaleAndPhysics(bottomMiddleLedge)
    bottomMiddleLedge.x = halfW - bottomMiddleLedge.width*.5 - 10
    bottomMiddleLedge.y = 220
    
    bottomLeftLedge = display.newImage(mySheet, opts.bottomLeftLedge)
    scaleAndPhysics(bottomLeftLedge)
    bottomLeftLedge.x = 0
    bottomLeftLedge.y = 196
    
    bottomRightLedgeNoSpawn = display.newImage(mySheet, opts.bottomRightLedgeNoSpawn)
    scaleAndPhysics(bottomRightLedgeNoSpawn)
    bottomRightLedgeNoSpawn.x = screenW - bottomRightLedgeNoSpawn.width
    bottomRightLedgeNoSpawn.y = 196
    
    bottomRightLedgeWithSpawn = display.newImage(mySheet, opts.bottomRightLedgeWithSpawn)
    scaleAndPhysics(bottomRightLedgeWithSpawn)
    bottomRightLedgeWithSpawn.x = screenW - bottomRightLedgeWithSpawn.width *1.5
    bottomRightLedgeWithSpawn.y = 182

    basePlatformMid = display.newImage(mySheet, opts.basePlatformMid)
    scaleAndPhysics(basePlatformMid)
    
    basePlatformRight = display.newImage(mySheet, opts.basePlatformRight)
    scaleAndPhysics(basePlatformRight)
    basePlatformRight.y = screenH - basePlatformRight.height
    basePlatformRight.x = 105
    
    basePlatformLeft = display.newImage(mySheet, opts.basePlatformLeft)
    scaleAndPhysics(basePlatformLeft)
    basePlatformLeft.y = screenH - basePlatformLeft.height
    basePlatformLeft.x = 435
    
    basePlatformMid.y = screenH - basePlatformLeft.height
    basePlatformMid.x = 105
end

local buildStaticBorders = function( )
    leftWall = display.newRect(0, 0, 1, screenH)
    physics.addBody( leftWall, "static", { isSensor = true, filter=wallCollisionFilter } )
    leftWall.collision = wallCollision
    leftWall:addEventListener("collision", leftWall)

    rightWall = display.newRect(screenW, 0, 1, screenH)
    physics.addBody( rightWall,"static", { isSensor = true, filter=wallCollisionFilter } )
    rightWall.collision = wallCollision
    rightWall:addEventListener("collision", rightWall)
    
    ceiling = display.newRect(0, 0, screenW, 1)
    scaleAndPhysics(ceiling)
    
    floor = display.newRect(0, screenH, screenW, 1)
    scaleAndPhysics(floor)
end

local stop = function()
    animation:setSequence("stand")
end

local animate = function( direction )
    correctAnimationState()
    
    if direction == "left" then
        animation:applyLinearImpulse(-2, 0, animation.x, animation.y)
        animation.xScale = -1 
    else
        animation:applyLinearImpulse(3, 0, animation.x, animation.y)
        animation.xScale = 1
    end
    
    animation:play()
end
local onKeyEvent = function( event )
    if (event.phase == "down") then
        if (event.keyName == "down" or event.nativeKeyCode == 125) then
            stop()
        end
        
        if (event.keyName == "left" or event.nativeKeyCode == 123) then
            animate("left")
        end
        
        if (event.keyName == "right" or event.nativeKeyCode == 124) then
            animate("right")
        end
        
        if (event.keyName == "up" or event.nativeKeyCode == 126) then
            animation:applyLinearImpulse(0, -1.5, animation.x, animation.y)
            if (animation.sequence ~= "fly") then
                animation:setSequence("fly")
                animation:play()
            end
        end
    else 
        if (event.keyName == "up" or event.nativeKeyCode == 126) then
            flying = false
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
	background:setFillColor( 188 )
	local sheetData = { sheetContentWidth=560, sheetContentHeight=472 }
    
    mySheet = graphics.newImageSheet( "joust2.jpg", ostrich_opts.options )
    
    animation = display.newSprite( mySheet, ostrich_opts.sequenceData )
    animation.anchorX = 0.5
    animation.anchorY = 0.5
    animation.myName = "playerOne"
    animation.x = halfW - 20
    animation.y = halfH + 120
    
    physics.addBody( animation, { density=0.5, friction=.2, bounce=.1, filter=playerCollisionFilter } )
    animation.isFixedRotation = true
    
    setupPlatforms(mySheet, ground_opts)
    buildStaticBorders()
    
    createBadGuy(mySheet)
 
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

Runtime:addEventListener("enterFrame", gameLoop)

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene