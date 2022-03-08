-- import "CoreLibs/graphics"

local gfx <const> = playdate.graphics
local Exercises <const> = import "Exercises" -- TODO: Figure out how to handle imports.
local ExerciseProps <const> = import "ExerciseProps"
local exercisesCursor = 1
local exercisePropsCursor = 1
local currentExercise = Exercises[exercisesCursor]
local currentExerciseProp = ExerciseProps[exercisePropsCursor]
local howToTextWidth, howToTextHeight, exerciseInfoAreaHeight

local function setup()
    -- Set colours.
    playdate.display.setInverted(true)
    gfx.setColor(gfx.kColorWhite) -- Fill with black.

    -- Set texts.
    local howToText <const> = "Ⓐ *NEXT*\nⒷ *INFO*"
    howToTextWidth, howToTextHeight = gfx.getTextSize(howToText)
    _, exerciseInfoAreaHeight = gfx.getTextSize("Breathing") -- Covers both ascendants and descendants.

    gfx.drawText(howToText, 400 - howToTextWidth, 240 - howToTextHeight) -- How-to text is fixed.
end

setup()

function playdate.update()
    -- Draw enough black background across the exercise information area,
    -- then draw the current selected information on top of it.
    gfx.fillRect(0, 240 - exerciseInfoAreaHeight, 400 - howToTextWidth, exerciseInfoAreaHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 240 - exerciseInfoAreaHeight)

    -- Handle Next action.
    if playdate.buttonJustPressed("a") or playdate.buttonJustPressed("right") then
        exercisesCursor = exercisesCursor % #Exercises + 1
        currentExercise = Exercises[exercisesCursor]
    end
    -- Handle Info action.
    if playdate.buttonJustPressed("b") or playdate.buttonJustPressed("left") then
        exercisePropsCursor = exercisePropsCursor % #ExerciseProps + 1
        currentExerciseProp = ExerciseProps[exercisePropsCursor]
    end
end
