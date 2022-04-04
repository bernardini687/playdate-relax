import 'CoreLibs/graphics'
import 'CoreLibs/timer'
import 'soundManager'

local gfx           <const> = playdate.graphics
local Exercises     <const> = import 'exercises' -- TODO: Figure out how to use imports properly.
local mainFont      <const> = gfx.font.new('Fonts/Roobert-20-Medium')
local secondaryFont <const> = gfx.font.new('Fonts/Asheville-Sans-14-Light')

local instruction, instructionTextW, patternTextW, timer
local exercisesCursor, sequenceCursor = 1, 1
local currentExercise                 = Exercises[exercisesCursor]

local function resetTimer()
    if timer then
        timer:remove()
    end
    instruction    = currentExercise.sequence[sequenceCursor]['instruction']
    local duration = currentExercise.sequence[sequenceCursor]['duration']

    SoundManager:playSound(instruction)

    patternTextW     = secondaryFont:getTextWidth(currentExercise['pattern'])
    instructionTextW = mainFont:getTextWidth(instruction)
    timer            = playdate.timer.new(duration, 0, instructionTextW)
end

-- Setup:
-- Set colours.
gfx.setBackgroundColor(gfx.kColorBlack)
gfx.setImageDrawMode(gfx.kDrawModeFillWhite) -- Draw white on black text.
gfx.setColor(gfx.kColorWhite)
resetTimer()

function playdate.update()
    gfx.clear()

    gfx.setFont(secondaryFont)
    gfx.drawText(currentExercise['name'], 0, 0)
    gfx.drawText(currentExercise['pattern'], 400 - patternTextW, 0)

    gfx.setFont(mainFont)
    gfx.drawTextAligned(instruction, 200, 104, kTextAlignment.center) -- 120 - 16 (half font height)
    gfx.drawRect(200 - (instructionTextW / 2), 132, timer.value, 2)

    if playdate.buttonJustPressed('a') or playdate.buttonJustPressed('b') then
        exercisesCursor = exercisesCursor % #Exercises + 1
        currentExercise = Exercises[exercisesCursor]
        sequenceCursor = 1
        resetTimer()
    end

    if timer.timeLeft == 0 then
        sequenceCursor = sequenceCursor % #currentExercise.sequence + 1
        resetTimer()
    end

    playdate.timer.updateTimers()
end
