import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics


class('TextManager').extends(gfx.sprite)

TextManager.fonts    = fonts

function TextManager:init(x, y, w, font)
	TextManager.super.init(self)

	-- sefl:setScale only affects sprites with images, should i set an image here?

	self.font = gfx.font.new('Fonts/'..font)

	self:setSize(w, self.font:getHeight())
	self:setCenter(0, 0) -- upper left corner of the sprite, default is at the center (0.5, 0.5)
	self:moveTo(x, y)
end

function TextManager:setContent(content)
	self.content = content
	self:markDirty()
end

function TextManager:draw()
	gfx.pushContext() -- gfx.pushContext(self.image)
		gfx.setFont(self.font)
		gfx.drawText(self.content, 0, 0)
	gfx.popContext()
end

-- Usage:
-- div = TextManager(x, y, w, 'Roobert-20-Medium')
-- div:setContent('hello world')
-- div:add()
