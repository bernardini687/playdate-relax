local snd <const> = playdate.sound

SoundManager = {}

SoundManager.kIn   = 'Breathe in'
SoundManager.kHold = 'Hold on'
SoundManager.kOut  = 'Breathe out'

local sounds = {}

for _, v in pairs(SoundManager) do
	sounds[v] = snd.sampleplayer.new('Sounds/'..v)
end

SoundManager.sounds = sounds

function SoundManager:play(name)
	self.sounds[name]:play(1)
end
