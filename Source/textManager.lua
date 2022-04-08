import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics

class('TextManager').extends(gfx.sprite)

-- @aligment can be 'left' or 'right', defaults to 'left'
function TextManager:init(x, y, w, font, alignment)
	TextManager.super.init(self)

	self.font      = gfx.font.new('Fonts/'..font)
	self.alignment = alignment or 'left'

	self:setSize(w, self.font:getHeight())
	self:setCenter(0, 0) -- upper left corner of the sprite, default is at the center (0.5, 0.5)
	self:moveTo(x, y)
end

function TextManager:setContent(content)
	self.content = content
	self:markDirty()
end

function TextManager:draw()
	local x, y = 0, 0

	if self.alignment == 'right' then
		x = self.width - self.font:getTextWidth(self.content)
	end

	gfx.pushContext()
		gfx.setFont(self.font)
		gfx.drawText(self.content, x, y)
	gfx.popContext()
end

-- Usage:
-- txt = TextManager(x, y, w, 'font_name', [alignment])
-- txt:setContent('hello world')
-- txt:add()
