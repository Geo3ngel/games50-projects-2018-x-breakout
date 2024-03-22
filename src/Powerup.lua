Powerup = Class{}

function Powerup:init(x, y, skin, stateObj, effect)
    self.x = x
    self.y = y
    self.skin = skin
    self.width = 16
    self.height = 16

    -- Should have a constant speed moving downwards towards the player!
    self.dy = 5
    -- call back function to occur when colliding with Paddle
    self.stateObj = stateObj
    self.effect = effect
end

function Powerup:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- overlapping
    return true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
end

function Powerup:trigger()
    -- Triggers callback to obj ref with function specified.
    if self.stateObj == nil then
        return
    end
    self.stateObj[self.effect](self.stateObj)
    gSounds['recover']:stop()
    gSounds['recover']:play() -- TODO: Add my own Sfx for this!
    -- destroy class!
    self = nil
end

function Powerup:destroy()
    self = nil
end

function Powerup:render()
    -- Should draw the powerup with the green square in it!
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin], self.x, self.y)
end

-- TODO: Destroy if it hits the bottom of the screen!