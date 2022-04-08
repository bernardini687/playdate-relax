import 'app'

App:refreshLabels()

-- TODO invert screen
function playdate.update()
	playdate.graphics.sprite.update()
	-- App:checkTimer()
end

function playdate.AButtonDown()
	App:changeTask()
end

function playdate.BButtonDown()
	App:changeTask()
end
