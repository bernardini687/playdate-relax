import "CoreLibs/graphics"

local gfx = playdate.graphics

--[[
    Lua arrays are 1-indexed but here I find it
    easier to use a 0-based cursor to cycle through
    the array elements with the modulo operator.
]]
local exerciseCursor = 0
local exercises = {
    "Boxed Breathing",
    "Boxed Breathing+",
    "Relaxed Breathing",
    "Coherent Breathing"
}

local nextInstruction = "➡️ / Ⓐ Next"
-- local infoInstruction = "⬅️ / Ⓑ Info"

local _, textHeight = gfx.getTextSize(nextInstruction)

playdate.display.setInverted(true)
gfx.setColor(gfx.kColorWhite) -- But it's black.

function playdate.update()
    -- Let's offset the cursor by 1 since Lua arrays are 1-indexed.
    local currentExercise = exercises[exerciseCursor + 1]

    gfx.fillRect(0, 0, 400, textHeight)
    gfx.drawText(currentExercise, 0, 0)
    gfx.drawTextAligned(nextInstruction, 400, 0, kTextAlignment.right)

    if playdate.buttonJustPressed("a") then
        exerciseCursor += 1
        exerciseCursor %= #exercises
    end
end
