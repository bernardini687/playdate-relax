import 'CoreLibs/graphics'
import 'CoreLibs/timer'

local gfx           <const> = playdate.graphics
local Exercises     <const> = import 'exercises' -- TODO: Figure out how to use imports properly.
local ExerciseProps <const> = import 'exerciseProps'
local headerFont    <const> = gfx.font.new('Fonts/Roobert-11-Medium')
local mainFont      <const> = gfx.font.new('Fonts/Roobert-20-Medium')
local howToTextFont <const> = gfx.font.new('Fonts/Roobert-11-Medium-Halved')
local nextText      <const> = 'Ⓐ next'
local infoText      <const> = 'Ⓑ info'

local howToTextW, howToTextH, timer, instruction, instructionTextW
local exercisesCursor, exercisePropsCursor, sequenceCursor = 1, 1, 1
local currentExercise     = Exercises[exercisesCursor]
local currentExerciseProp = ExerciseProps[exercisePropsCursor]

local function resetTimer()
    if timer then
        timer:remove()
    end
    instruction       = currentExercise.sequence[sequenceCursor][1]
    local targetTime  = currentExercise.sequence[sequenceCursor][2]

    gfx.setFont(mainFont)
    instructionTextW, _ = gfx.getTextSize(instruction)
    timer               = playdate.timer.new(targetTime, 0, instructionTextW)
end

local function setup()
    -- Set colours.
    gfx.setBackgroundColor(gfx.kColorBlack)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite) -- Draw white on black text.
    gfx.setColor(gfx.kColorWhite)

    -- Populate text utility variables.
    gfx.setFont(howToTextFont)
    howToTextW, howToTextH = gfx.getTextSize(nextText)

    resetTimer()
end

setup()

function playdate.update()
    gfx.clear()
    gfx.setFont(headerFont)
    gfx.drawTextAligned(currentExercise[currentExerciseProp], 200, 0, kTextAlignment.center)

    gfx.setFont(mainFont)
    gfx.drawTextAligned(instruction, 200, 120 - 16, kTextAlignment.center)
    gfx.drawRect(200 - (instructionTextW / 2), 120 + 16, timer.value, 2)

    gfx.setFont(howToTextFont)
    gfx.drawText(nextText, 400 - howToTextW, 240 - howToTextH)
    gfx.drawText(infoText, 0, 240 - howToTextH)

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

    if timer.timeLeft == 0 then
        sequenceCursor = sequenceCursor % #currentExercise.sequence + 1
        resetTimer()
    end

    playdate.timer.updateTimers()
end
