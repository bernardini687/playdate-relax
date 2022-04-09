import 'CoreLibs/timer'

import 'dynamicText'
import 'tasks'

local sprite        <const> = playdate.graphics.sprite
local timer         <const> = playdate.timer
local minorFontName <const> = 'Roobert-11-Medium'
local majorFontName <const> = 'Roobert-24-Medium'
local taskLabel     <const> = DynamicText(0, 0, minorFontName, 'left')
local infoLabel     <const> = DynamicText(400, 0, minorFontName, 'right')
local instruction   <const> = DynamicText(200, 120, majorFontName, 'center')

App = {}

App.taskCursor        = 1
App.instructionCursor = 1
App.actualTask        = tasks[App.taskCursor]
App.timer             = nil

function App:run()
	sprite.update()
	timer.updateTimers()
	-- TODO check timer
end

function App:resetTimer()
	if self.timer then
		self.timer:remove()
	end

	local i = self.actualTask.instructions[self.instructionCursor]
	instruction:setContent(i.name)
	-- SoundManager:play(i.name)
	self.timer = timer.new(i.time, 0, instruction.width)
end

-- function App:changeInstruction()
-- 	self.instructionCursor = self.instructionCursor % #self.actualTask.instructions + 1
-- 	-- reset timer
-- end

function App:changeTask()
	self.taskCursor = self.taskCursor % #tasks + 1
	self.actualTask = tasks[self.taskCursor]
	-- rest timer
	self:refreshLabels()
end

function App:refreshLabels()
	taskLabel:setContent(self.actualTask['name'])
	infoLabel:setContent(self.actualTask['info'])
end

taskLabel:add()
infoLabel:add()
instruction:add()
