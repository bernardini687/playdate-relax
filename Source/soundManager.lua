local snd <const> = playdate.sound

SoundManager = {}

SoundManager.kBreatheIn  = 'Breathe in'
SoundManager.kHoldOn     = 'Hold on'
SoundManager.kBreatheOut = 'Breathe out'

local sounds = {}

for _, v in pairs(SoundManager) do
	sounds[v] = snd.sampleplayer.new('Sounds/' .. v)
end

SoundManager.sounds = sounds

function SoundManager:playSound(name)
	self.sounds[name]:play(1)
end
