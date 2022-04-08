import 'textManager'
import 'tasks'

local minorFontName <const> = 'Asheville-Sans-14-Light'
local taskLabel     <const> = TextManager(0, 0, 200, minorFontName)
local infoLabel     <const> = TextManager(200, 0, 200, minorFontName, 'right')

App = {}

App.taskCursor = 1
App.actualTask = tasks[App.taskCursor]

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

-- Usage:
-- App:refreshLabels()
