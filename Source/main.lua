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

local howToText = "➡️ / Ⓐ Next\n⬅️ / Ⓑ Info"
local howToTextWidth, howToTextHeight = gfx.getTextSize(howToText)
local _, exerciseTextHeigth = gfx.getTextSize("Breathing") -- Should cover ascendants and descendants.

playdate.display.setInverted(true)
gfx.setColor(gfx.kColorWhite) -- But it's black.

function playdate.update()
    -- Let's offset the cursors by 1 since Lua arrays are 1-indexed.
    local currentExercise = exercises[exerciseCursor + 1]
    local currentExerciseProp = exerciseProps[exercisePropsCursor + 1]

    gfx.fillRect(0, 240 - exerciseTextHeigth, 400 - howToTextWidth, howToTextHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 240 - exerciseTextHeigth)
    gfx.drawText(howToText, 400 - howToTextWidth, 240 - howToTextHeight)

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
