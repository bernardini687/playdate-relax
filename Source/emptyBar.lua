import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics

class('EmptyBar').extends(gfx.sprite)

function EmptyBar:init(x, y, w, h)
	EmptyBar.super.init(self)

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
