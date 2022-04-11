gfx    = playdate.graphics
sprite = gfx.sprite

import 'app'

App:setup()

function playdate.update()
	App:run()
end

function playdate.AButtonDown()
	App:changeTask()
end

function playdate.BButtonDown()
	App:changeTask()
end
