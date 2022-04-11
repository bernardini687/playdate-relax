import 'CoreLibs/sprites'

--[[
	Usage:

		bar = ProgressBar(x, y, w, h)
		bar:setWidth(w)
		playdate.graphics.sprite.update()
]]
class('ProgressBar').extends(sprite)

function ProgressBar:init(x, y, w, h)
	ProgressBar.super.init(self)

	self:setCenter(0, 0)
	self:setSize(w, h)
	self:moveTo(x, y)
	self:add()
end

function ProgressBar:setWidth(w)
	self:setSize(w, self.height) -- TODO: is this making any sense? why don't i need to call self:markDirty()?
end

function ProgressBar:draw()
	gfx.fillRoundRect(0, 0, self.width, self.height, self.height)
end
