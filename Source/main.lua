import "CoreLibs/graphics"

local gfx = playdate.graphics

--[[
    Lua arrays are 1-indexed but here I find it
    easier to use a 0-based cursor to cycle through
    the array elements with the modulo operator.
]]
local exerciseCursor = 0
local exercises = {
    {
        name = "Boxed Breathing",
        info = "4, 4, 4, 4",
    },
    {
        name = "Boxed Breathing+",
        info = "4, x, x, x",
    },
    {
        name = "Relaxed Breathing",
        info = "x, x, x, x",
    },
    {
        name = "Coherent Breathing",
        info = "y, y, y, y",
    },
}

local exercisePropsCursor = 0
local exerciseProps = {
    "name",
    "info",
}

local nextDisplayText = "➡️ / Ⓐ Next"
-- local infoDisplayText = "⬅️ / Ⓑ Info"

local _, textHeight = gfx.getTextSize(nextDisplayText)

playdate.display.setInverted(true)
gfx.setColor(gfx.kColorWhite) -- But it's black.

function playdate.update()
    -- Let's offset the cursors by 1 since Lua arrays are 1-indexed.
    local currentExercise = exercises[exerciseCursor + 1]
    local currentExerciseProp = exerciseProps[exercisePropsCursor + 1]

    gfx.fillRect(0, 0, 400, textHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 0)
    gfx.drawTextAligned(nextDisplayText, 400, 0, kTextAlignment.right)

    -- The cycling-cursor logic could be abstracted.
    -- Does it only need an array and the cursor state?
    if playdate.buttonJustPressed("a") then
        exerciseCursor += 1
        exerciseCursor %= #exercises
    end

    if playdate.buttonJustPressed("b") then
        exercisePropsCursor += 1
        exercisePropsCursor %= #exerciseProps
    end
end
