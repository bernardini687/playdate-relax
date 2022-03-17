import 'CoreLibs/graphics'
import 'CoreLibs/timer'

local gfx           <const> = playdate.graphics
local Exercises     <const> = import 'Exercises' -- TODO: Figure out how to use imports properly.
local ExerciseProps <const> = import 'ExerciseProps'
local headerFont    <const> = gfx.font.new('Fonts/Roobert-11-Medium')
local mainFont      <const> = gfx.font.new('Fonts/Roobert-20-Medium')
local howToTextFont <const> = gfx.font.new('Fonts/Roobert-11-Medium-Halved')
local nextText      <const> = 'Ⓐ next'
local infoText      <const> = 'Ⓑ info'

local howToTextWidth, howToTextHeight, targetTime, timer, width
local exercisesCursor, exercisePropsCursor, sequenceCursor = 1, 1, 1
local currentExercise     = Exercises[exercisesCursor]
local currentExerciseProp = ExerciseProps[exercisePropsCursor]

local function resetTimer()
    if timer then
        timer:remove()
    end
    targetTime = currentExercise.sequence[sequenceCursor][2]
    timer      = playdate.timer.new(targetTime, 0, targetTime)
    width      = 1
end

local function setup()
    -- Set colours.
    gfx.setBackgroundColor(gfx.kColorBlack)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite) -- Draw white on black text.
    gfx.setColor(gfx.kColorWhite)

    -- Populate text utility variables.
    gfx.setFont(howToTextFont)
    howToTextWidth, howToTextHeight = gfx.getTextSize(nextText)

    resetTimer()
end

setup()

function playdate.update()
    local instruction <const> = currentExercise.sequence[sequenceCursor][1]

    gfx.clear()
    gfx.setFont(headerFont)
    gfx.drawTextAligned(currentExercise[currentExerciseProp], 200, 0, kTextAlignment.center)

    -- TODO: The content of main text only changes every time we rest the timer, handle all this logic inside `resetTimer`
    gfx.setFont(mainFont)
    local mainTextW, mainTextH <const> = gfx.getTextSize(instruction)
    local halfTextH            <const> = mainTextH / 2
    local chunk                <const> = mainTextW / (timer.duration / 33.33333) -- 30 FPS are 33.33333 ms

    gfx.drawRect(200 - (mainTextW / 2), 120 + halfTextH, width, 2)
    gfx.drawTextAligned(instruction, 200, 120 - halfTextH, kTextAlignment.center)

    gfx.setFont(howToTextFont)
    gfx.drawText(nextText, 400 - howToTextWidth, 240 - howToTextHeight)
    gfx.drawText(infoText, 0, 240 - howToTextHeight)

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

    if width < mainTextW then
        width += chunk
    end

    if timer.value == targetTime then
        sequenceCursor = sequenceCursor % #currentExercise.sequence + 1
        resetTimer()
    end

    playdate.timer.updateTimers()
end
