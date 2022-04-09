import 'CoreLibs/timer'

import 'dynamicText'
import 'soundManager'
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

local function refreshLabels()
	taskLabel:setContent(App.actualTask['name'])
	infoLabel:setContent(App.actualTask['info'])
end

local function resetTimer()
	if App.timer then
		App.timer:remove()
	end

	local i = App.actualTask.instructions[App.instructionCursor]
	instruction:setContent(i.name)
	SoundManager:play(i.name)
	App.timer = timer.new(i.time, 0, instruction.width)
end

local function changeInstruction()
	App.instructionCursor = App.instructionCursor % #App.actualTask.instructions + 1
end

function App:setup()
	refreshLabels()
	resetTimer()
end

function App:run()
	sprite.update()
	timer.updateTimers()

	if self.timer.timeLeft == 0 then
		changeInstruction()
		resetTimer()
	end
end

function App:changeTask()
	self.taskCursor = self.taskCursor % #tasks + 1
	self.actualTask = tasks[self.taskCursor]

	refreshLabels()
	resetTimer()
end

taskLabel:add()
infoLabel:add()
instruction:add()
