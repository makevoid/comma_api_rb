const chartOptions = {
	type: 'line',
	options: options,
}

// html
// ---
// #gps1.gps1.gps1Chart.chart1
// #compass.compass.compassChart.chart2

const merge = (obj1, obj2) =>
	Object.assign(obj1, obj2)

const data1 = [1, 2, 3]
const data2 = [2, 3, 4]

let data

data = { data: data1 }
const gps			= new Chart( 'gps1', 		merge(cartOptions, data1) )

data = { data: data2 }
const compass	= new Chart( 'compass', merge(cartOptions, data2) )
