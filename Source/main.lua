import 'app'

-- TODO App:setup()
App:refreshLabels()
App:resetTimer()

-- TODO invert screen
function playdate.update()
	App:run()
end

function playdate.AButtonDown()
	App:changeTask()
end

function playdate.BButtonDown()
	App:changeTask()
end
