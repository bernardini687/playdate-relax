import 'CoreLibs/graphics'
import 'CoreLibs/timer'

local gfx <const> = playdate.graphics
local Exercises <const> = import 'Exercises' -- TODO: Figure out how to use imports properly.
local ExerciseProps <const> = import 'ExerciseProps'
local mainFont <const> = gfx.font.new('Fonts/Roobert-11-Medium')
local howToTextFont <const> = gfx.font.new('Fonts/Roobert-11-Medium-Halved')
local nextText <const> = 'Ⓐ next'
local infoText <const> = 'Ⓑ info'

local howToTextWidth, howToTextHeight, timer, targetTime
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
    gfx.setFont(howToTextFont)
    howToTextWidth, howToTextHeight = gfx.getTextSize(nextText)
    gfx.setFont(mainFont)

    resetTimer()
end

setup()

function playdate.update()
    -- TODO: make texts into images.
    gfx.clear()
    gfx.setFont(howToTextFont)
    gfx.drawText(nextText, 400 - howToTextWidth, 240 - howToTextHeight)
    gfx.drawText(infoText, 0, 240 - howToTextHeight)
    gfx.setFont(mainFont)
    gfx.drawTextAligned(currentExercise[currentExerciseProp], 200, 0, kTextAlignment.center)
    gfx.drawText(math.floor(timer.value / 1000) + 1, 0, 0) -- For debugging.

    -- Handle `next` action.
    if playdate.buttonJustPressed('a') or playdate.buttonJustPressed('right') then
        exercisesCursor = exercisesCursor % #Exercises + 1
        currentExercise = Exercises[exercisesCursor]
        sequenceCursor = 1
        resetTimer()
    end
    -- Handle `info` action.
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
