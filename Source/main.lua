-- import "CoreLibs/graphics"

local gfx = playdate.graphics

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
local exercisesCursor = 1
local currentExercise = exercises[exercisesCursor]

local exerciseProps = {
    "name",
    "info",
}
local exercisePropsCursor = 1
local currentExerciseProp = exerciseProps[exercisePropsCursor]

local howToText = "➡️ / Ⓐ Next\n⬅️ / Ⓑ Info"
local howToTextWidth, howToTextHeight = gfx.getTextSize(howToText)
local _, exerciseTextHeigth = gfx.getTextSize("Breathing") -- Covers both ascendants and descendants.

playdate.display.setInverted(true)
gfx.setColor(gfx.kColorWhite) -- Fill with black.

-- How-to text is fixed.
gfx.drawText(howToText, 400 - howToTextWidth, 240 - howToTextHeight)

function playdate.update()
    -- Draw enough black background across the exercise information area,
    -- then draw the current selected information on top of it.
    gfx.fillRect(0, 240 - exerciseTextHeigth, 400 - howToTextWidth, howToTextHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 240 - exerciseTextHeigth)

    -- Handle Next action.
    if playdate.buttonJustPressed("a") or playdate.buttonJustPressed("right") then
        exercisesCursor = exercisesCursor % #exercises + 1
        currentExercise = exercises[exercisesCursor]
    end

    -- Handle Info action.
    if playdate.buttonJustPressed("b") or playdate.buttonJustPressed("left") then
        exercisePropsCursor = exercisePropsCursor % #exerciseProps + 1
        currentExerciseProp = exerciseProps[exercisePropsCursor]
    end
end
