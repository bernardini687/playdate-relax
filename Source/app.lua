import 'CoreLibs/timer'

import 'backgroundBar'
import 'dynamicText'
import 'progressBar'
import 'soundManager'
import 'tasks'

local barMaxWidth, barRadius <const> = 170, 4

local timer         <const> = playdate.timer
local minorFontName <const> = 'Roobert-11-Medium'
local majorFontName <const> = 'Roobert-24-Medium'
local taskLabel     <const> = DynamicText(0, 0, minorFontName, 'left')
local infoLabel     <const> = DynamicText(400, 0, minorFontName, 'right')
local instruction   <const> = DynamicText(200, 120, majorFontName, 'center')
local backgroundBar <const> = BackgroundBar(115, 120 + 22, barMaxWidth, barRadius)
local progressBar   <const> = ProgressBar(115, 120 + 22, 0, barRadius)

App = {}

App.taskCursor        = 1
App.instructionCursor = 1
App.actualTask        = tasks[App.taskCursor]
App.timer             = nil

-- private functions:

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
	App.timer = timer.new(i.time, 0, barMaxWidth)
end

local function changeInstruction()
	App.instructionCursor = App.instructionCursor % #App.actualTask.instructions + 1
end

-- public methods:

function App:setup()
	refreshLabels()
	resetTimer()
	playdate.display.setInverted(true)
end

function App:run()
	progressBar:setWidth(self.timer.value)

	if self.timer.timeLeft == 0 then
		changeInstruction()
		resetTimer()
	end

	sprite.update()
	timer.updateTimers()
end

function App:changeTask()
	self.instructionCursor = 1
	self.taskCursor        = self.taskCursor % #tasks + 1
	self.actualTask        = tasks[self.taskCursor]

	refreshLabels()
	resetTimer()
end
