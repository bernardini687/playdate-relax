local player <const> = playdate.sound.sampleplayer

SoundManager = {}

SoundManager.kIn   = 'Breathe in'
SoundManager.kHold = 'Hold on'
SoundManager.kOut  = 'Exhale'

local sounds <const> = {}

for _, v in pairs(SoundManager) do
	sounds[v] = player.new('Sounds/'..v)
end

SoundManager.sounds = sounds

function SoundManager:play(name)
	self.sounds[name]:play(1)
end
