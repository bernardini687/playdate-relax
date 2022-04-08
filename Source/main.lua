import 'textManager'
import 'exercises'

local secondaryFontName <const> = 'Asheville-Sans-14-Light'

local exercisesCursor = 1
local currentExercise = Exercises[exercisesCursor]

local function refreshLabels()
	exerciseLabel:setContent(currentExercise['name'])
	patternLabel:setContent(currentExercise['pattern'])
end

exerciseLabel = TextManager(0, 0, 200, secondaryFontName)
patternLabel  = TextManager(200, 0, 200, secondaryFontName)
exerciseLabel:add()
patternLabel:add()
refreshLabels()

-- invert screen
function playdate.update()
	playdate.graphics.sprite.update()
end

local function handleAction()
	exercisesCursor = exercisesCursor % #Exercises + 1
	currentExercise = Exercises[exercisesCursor]
	refreshLabels()
end

function playdate.AButtonDown()
	handleAction()
end

function playdate.BButtonDown()
	handleAction()
end
