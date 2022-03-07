-- import "CoreLibs/graphics"

local gfx = playdate.graphics

local exerciseCursor = 1
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

local exercisePropsCursor = 1
local exerciseProps = {
    "name",
    "info",
}

local howToText = "➡️ / Ⓐ Next\n⬅️ / Ⓑ Info"
local howToTextWidth, howToTextHeight = gfx.getTextSize(howToText)
local _, exerciseTextHeigth = gfx.getTextSize("Breathing") -- Covers both ascendants and descendants.

playdate.display.setInverted(true)
gfx.setColor(gfx.kColorWhite) -- Fill with black.

-- How-to text is fixed.
gfx.drawText(howToText, 400 - howToTextWidth, 240 - howToTextHeight)

function playdate.update()
    local currentExercise = exercises[exerciseCursor]
    local currentExerciseProp = exerciseProps[exercisePropsCursor]

    -- Draw enough black background across the exercise information area,
    -- then draw the current selected information on top of it.
    gfx.fillRect(0, 240 - exerciseTextHeigth, 400 - howToTextWidth, howToTextHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 240 - exerciseTextHeigth)

    if playdate.buttonJustPressed("a") then
        exerciseCursor = exerciseCursor % #exercises + 1
    end

    if playdate.buttonJustPressed("b") then
        exercisePropsCursor = exercisePropsCursor % #exerciseProps + 1
    end
end

-- from 43019 to 42987
