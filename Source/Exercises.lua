local Exercises <const> = {
	{
		name = 'Boxed Breathing',
		info = '4, 4, 4, 4',
		sequence = {
			{'Breathe in',  4000},
			{'Hold on',     4000},
			{'Breathe out', 4000},
			{'Hold on',     4000}
		}
	},
	{
		name = 'Boxed Breathing+',
		info = '4, 4, 6, 4',
		sequence = {
			{'Breathe in',  4000},
			{'Hold on',     4000},
			{'Breathe out', 6000},
			{'Hold on',     4000}
		}
	},
	{
		name = 'Coherent Breathing',
		info = '5.5, 5.5',
		sequence = {
			{'Breathe in',  5500},
			{'Breathe out', 5500}
		}
	},
	{
		name = 'Coherent Breathing',
		info = '4, 7, 8',
		sequence = {
			{'Breathe in',  4000},
			{'Hold on',     7000},
			{'Breathe out', 8000}
		}
	}
}

return Exercises
