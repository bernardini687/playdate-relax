import 'CoreLibs/sprites'

class('BackgroundBar').extends(sprite)

--[[
	Usage:

		bar = BackgroundBar(x, y, w, h)
		playdate.graphics.sprite.update()
]]
function BackgroundBar:init(x, y, w, h)
	BackgroundBar.super.init(self)

	local image = gfx.image.new(w, h)

	gfx.pushContext(image)
		gfx.fillRoundRect(0, 0, w, h, h)
	gfx.popContext()

	self:setImage(image:fadedImage(0.5, gfx.image.kDitherTypeBayer2x2))

	self:setCenter(0, 0)
	self:setSize(w, h)
	self:moveTo(x, y)
	self:add()
end
