-- import 'CoreLibs/timer'

import 'dynamicText'
import 'tasks'

local minorFontName <const> = 'Asheville-Sans-14-Light'
local majorFontName <const> = 'Roobert-20-Medium'
local taskLabel     <const> = DynamicText(0, 0, minorFontName, 'left')
local infoLabel     <const> = DynamicText(400, 0, minorFontName, 'right')
-- local instruction   <const> = DynamicText(200, 120, majorFontName, 'center')

App = {}

App.taskCursor        = 1
-- App.instructionCursor = 1
App.actualTask        = tasks[App.taskCursor]

function App:changeTask()
	self.taskCursor = self.taskCursor % #tasks + 1
	self.actualTask = tasks[self.taskCursor]

	self:refreshLabels()
end

function App:refreshLabels()
	taskLabel:setContent(self.actualTask['name'])
	infoLabel:setContent(self.actualTask['info'])
end

taskLabel:add()
infoLabel:add()
-- instruction:add()

-- local i = App.actualTask.instructions[App.instructionCursor].name
-- instruction:setContent(i)

-- Usage:
-- App:refreshLabels()
