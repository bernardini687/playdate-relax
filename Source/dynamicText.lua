import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics

--[[
	Usage:

		txt = DynamicText(x, y, 'font_name', alignment)
		txt:setContent('hello world')
		playdate.graphics.sprite.update()
]]
class('DynamicText').extends(gfx.sprite)

-- @aligment can be 'left', 'center' or 'right'
function DynamicText:init(x, y, font, alignment)
	DynamicText.super.init(self)

	self.initX     = x
	self.font      = gfx.font.new('Fonts/'..font)
	self.alignment = alignment

	self:moveTo(self.initX, y)
	self:setContent()
	self:add()
end

function DynamicText:setContent(content)
	self.content = content or 'test'

	self:markDirty()
	self:setSize(self.font:getTextWidth(self.content), self.font:getHeight())

	if self.alignment ~= 'center' then
		-- set to upper left corner of the sprite
		-- else leave default which is the center (0.5, 0.5)
		self:setCenter(0, 0)
	end

	if self.alignment == 'right' then
		-- reposition the sprite according to the x value initially given
		self:moveTo(self.initX - self.width, 0)
	end
end

function DynamicText:draw()
	gfx.pushContext()
		gfx.setFont(self.font)
		gfx.drawText(self.content, 0, 0)
	gfx.popContext()
end
