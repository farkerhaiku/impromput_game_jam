local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
physics.start();
physics.pause();
physics.setGravity(0, 9.8);
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
local playerScore = 0
local ostrich_opts = require "ostrich_opts"
local ground_opts = require "ground_opts"
local enemy_opts = require "enemy_opts"
local animationGroup, mySheet
local playerLives = 3
local eggCollisionFilter = { categoryBits = 1, maskBits = 18 }
local wallCollisionFilter = { categoryBits = 2, maskBits = 13 }
local alienCollisionFilter = { categoryBits = 4, maskBits = 26 }
local playerCollisionFilter = { categoryBits = 8, maskBits = 23 }
local floorCollisionFilter = { categoryBits = 16, maskBits = 15 }


local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5
local leftLedge, rightLedge, middleLedge, bottomMiddleLedge, bottomLeftLedge, bottomRightLedgeWithSpawn, bottomRightLedgeNoSpawn
local basePlatformRight, basePlatformLeft, basePlatformMid
local leftWall, rightWall, floor, ceiling
local velocity, flying = 0, 0
local animation
local badGuyList = {}

local correctAnimationState = function()
    local vx, vy = animation:getLinearVelocity()
    if (flying == 0) then
        if (math.abs(vx) > 10) then
            if (animation.sequence ~= "run") then
                animation:setSequence("run")
            end
        elseif math.abs(vx) > 0.1 then
            if (animation.sequence ~= "walk") then
                animation:setSequence("walk")
            end
        else
            animation:setSequence("stand")
            return
        end
    end

    animation:play()
end

local badGuyCollision = function(self, event)
    if(event.phase == "began" and event.other.myName == "playerOne") then
        local difference = self.y - event.other.y
        print("self.y:" .. self.y, "other.y:" .. event.other.y, difference)
        if difference > 1 then -- destroy the bad guy
            badGuyList[self.arrayRef] = nil
            self:removeSelf()
            playerScore = playerScore + 400
        elseif difference < -1 then --kill the player

        end
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
    badGuy.arrayRef = #badGuyList + 1
    
    badGuy.x = halfW
    badGuy.y = halfH
end

local floorCollision = function(self, event)
    if (animation.sequence == "fly" and event.phase == "began") then
        if not (event.other.y > self.y) then -- colliding from above
            flying = 0
        end
    end
end

local wallCollision = function(self, event)
--    print("this is where i would put the thingie on the other side")
end

local scaleAndPhysics = function(platform)
    physics.addBody( platform, "static", { density=1.0, friction=.2, filter=floorCollisionFilter } )
    platform.collision = floorCollision
    platform:addEventListener( "collision", platform )
    platform.anchorX = 0
    platform.anchorY = 0
end

local gameLoop = function()
    correctAnimationState()
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
    if direction == "left" then
        animation:applyLinearImpulse(-2, 0, animation.x, animation.y)
        animation.xScale = -1
    else
        animation:applyLinearImpulse(3, 0, animation.x, animation.y)
        animation.xScale = 1
    end
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
            flying = 1
            animation:applyLinearImpulse(0, -1.5, animation.x, animation.y)
            if (animation.sequence ~= "fly") then
                animation:setSequence("fly")
                animation:play()
            end
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
    background:setFillColor( 0 )
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