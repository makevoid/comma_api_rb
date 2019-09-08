let data

const lineChartOptions = {

}

const chartOptions = {
	type: 'line',
	options: lineChartOptions,
}

// html
// ---
// #gps1.gps1.gps1Chart.chart1
// #compass.compass.compassChart.chart2

const merge = (obj1, obj2) =>
	Object.assign(obj1, obj2)

// const data1 = [1, 2, 3]
const data2 = {}

const chartDataset1 = {
	// data
	label: 't0-label',
	data: [ 2100 ],
	// visual
	borderWidth: 1,
	backgroundColor: 	[ 'rgba(255, 99, 132, 0.2)' ],
	borderColor: 			[ 'rgba(255, 99, 132, 1)' ],
}

const chartDataset2 = {
	// data
	label: 't1-label',
	data: [ 2400 ],
}

const data1 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset],
	},
}

const data2 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset],
	},
}


const gps1Elem = document.querySelector(".gps1")
const compassElem = document.querySelector(".compass")

data = { data: data1 }
const gpsChart = new Chart( gps1Elem, merge(chartOptions, data1) )

// data = { data: data2 }
// const compassChart = new Chart( compassElem, merge(chartOptions, data2) )

const host = "localhost:3000"


const addData = (label, data) => {
	gpsChart.data.labels.push(label)
	gpsChart.data.datasets.forEach((dataset) => {
	  dataset.data.push(data)
	})
	gpsChart.update()
}

// setTimeout(() => {
//
// 		addData("test", 9)
// 		addData("test", 8)
//
// }, 1500)

const source = new EventSource(`http://${host}/data`)

let index = 1

source.addEventListener('message', (event) => {

	const data = JSON.parse(event.data)
	console.log(data)
  console.log(data.minutes)
	addData(`t${index}`, data.minutes)
	index++

}, false)



// default colors
//
// backgroundColor: [
// 		'rgba(255, 99, 132, 0.2)',
// 		'rgba(54, 162, 235, 0.2)',
// 		'rgba(255, 206, 86, 0.2)',
// 		'rgba(75, 192, 192, 0.2)',
// 		'rgba(153, 102, 255, 0.2)',
// 		'rgba(255, 159, 64, 0.2)'
// ],
// borderColor: [
// 		'rgba(255, 99, 132, 1)',
// 		'rgba(54, 162, 235, 1)',
// 		'rgba(255, 206, 86, 1)',
// 		'rgba(75, 192, 192, 1)',
// 		'rgba(153, 102, 255, 1)',
// 		'rgba(255, 159, 64, 1)'
// ],
