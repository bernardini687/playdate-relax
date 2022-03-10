import 'CoreLibs/timer'

local gfx <const> = playdate.graphics
local Exercises <const> = import 'Exercises' -- TODO: Figure out how to use imports properly.
local ExerciseProps <const> = import 'ExerciseProps'
local howToText <const> = 'Ⓐ *NEXT*\nⒷ *INFO*'

local howToTextWidth, howToTextHeight, exerciseInfoAreaHeight, timer, targetTime
local exercisesCursor, exercisePropsCursor, sequenceCursor = 1, 1, 1
local currentExercise = Exercises[exercisesCursor]
local currentExerciseProp = ExerciseProps[exercisePropsCursor]

local function resetTimer()
    if timer then
        timer:remove()
    end

    targetTime = currentExercise.sequence[sequenceCursor]
    timer = playdate.timer.new(targetTime, 0, targetTime)
end

local function setup()
    -- Set colours.
    gfx.setBackgroundColor(gfx.kColorBlack)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite) -- Draw white on black text.

    -- Populate text utility variables.
    howToTextWidth, howToTextHeight = gfx.getTextSize(howToText)
    _, exerciseInfoAreaHeight = gfx.getTextSize('Breathing') -- Covers both ascendants and descendants.

    resetTimer()
end

setup()

function playdate.update()
    gfx.clear()
    gfx.drawText(howToText, 400 - howToTextWidth, 240 - howToTextHeight)
    gfx.drawText(currentExercise[currentExerciseProp], 0, 240 - exerciseInfoAreaHeight)
    gfx.drawText((timer.value / 1000) + 1, 0, 0) -- For debugging.

    -- Handle NEXT action.
    if playdate.buttonJustPressed('a') or playdate.buttonJustPressed('right') then
        exercisesCursor = exercisesCursor % #Exercises + 1
        currentExercise = Exercises[exercisesCursor]
        sequenceCursor = 1
        resetTimer()
    end
    -- Handle INFO action.
    if playdate.buttonJustPressed('b') or playdate.buttonJustPressed('left') then
        exercisePropsCursor = exercisePropsCursor % #ExerciseProps + 1
        currentExerciseProp = ExerciseProps[exercisePropsCursor]
    end

    if timer.value == targetTime then
        sequenceCursor = sequenceCursor % #currentExercise.sequence + 1
        resetTimer()
    end

    playdate.timer.updateTimers()
end
