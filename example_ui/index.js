const chartOptions = {
	type: 'line',
	data: data,
	options: options,
}

const gps = new Chart('lat-lng', cartOptions)
const compass = new Chart('lat-lng', cartOptions)
