local Exercises <const> = {
	{
		name     = 'Boxed breathing',
		pattern  = '4, 4, 4, 4',
		sequence = {
			{
				instruction = 'Breathe in',
				duration    = 4000
			},
			{
				instruction = 'Hold on',
				duration    = 4000
			},
			{
				instruction = 'Breathe out',
				duration    = 4000
			},
			{
				instruction = 'Hold on',
				duration    = 4000
			}
		}
	},
	{
		name     = 'Boxed breathing+',
		pattern  = '4, 4, 6, 4',
		sequence = {
			{
				instruction = 'Breathe in',
				duration    = 4000
			},
			{
				instruction = 'Hold on',
				duration    = 4000
			},
			{
				instruction = 'Breathe out',
				duration    = 6000
			},
			{
				instruction = 'Hold on',
				duration    = 4000
			}
		}
	},
	{
		name     = 'Coherent breathing',
		pattern  = '5.5, 5.5',
		sequence = {
			{
				instruction = 'Breathe in',
				duration    = 5500
			},
			{
				instruction = 'Breathe out',
				duration    = 5500
			}
		}
	},
	{
		name    = 'Relaxed breathing',
		pattern = '4, 7, 8',
		sequence = {
			{
				instruction = 'Breathe in',
				duration    = 4000
			},
			{
				instruction = 'Hold on',
				duration    = 7000
			},
			{
				instruction = 'Breathe out',
				duration    = 8000
			}
		}
	}
}

return Exercises
