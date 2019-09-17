// config
const host = "localhost:3000"

const lineChartOptions = {
  //...
}
const chartOptions = {
	type: 'line',
	options: lineChartOptions,
}

const chartOptions2 = Object.assign({}, chartOptions)
const chartOptions3 = Object.assign({}, chartOptions)
const chartOptions4 = Object.assign({}, chartOptions)

const merge = (obj1, obj2) =>
	Object.assign(obj1, obj2)

const chartDataset1 = {
	label: 't0-label',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(255, 99, 132, 0.2)' ],
  borderColor: 			[ 'rgba(255, 99, 132, 1)' ],
}

const chartDataset2 = {
	label: 't1-label',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(54, 162, 235, 0.2)' ],
	borderColor: 			[ 'rgba(54, 162, 235, 1)' ],
}

const chartDataset3 = {
	label: 't2-label',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(153, 102, 255, 0.2)' ],
	borderColor: 			[ 'rgba(153, 102, 255, 1)' ],
}

const chartDataset4 = {
	label: 't3-label',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(75, 192, 192, 0.2)' ],
	borderColor: 			[ 'rgba(75, 192, 192, 1)' ],
}

const data1 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset1],
	},
}

const data2 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset2],
	},
}

const data3 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset3],
	},
}

const data4 = {
	data: {
		labels: 	['t0'],
    datasets: [chartDataset4],
	},
}

// chart helpers

const addData = (label, data, chart) => {
	chart.data.labels.push(label)
  if (chart.data.datasets.length > 29) dataset.data.pop()
	chart.data.datasets.forEach((dataset) => {
	  dataset.data.push(data)
	})
	chart.update()
}

// chart

const speedChartElem = document.querySelector(".speedChart")
const steeringTorqueChartElem = document.querySelector(".steeringTorqueChart")
const steeringAngleChartElem = document.querySelector(".steeringAngleChart")
const brakeChartElem = document.querySelector(".brakeChart")

const speedChart = new Chart( speedChartElem, merge(chartOptions, data1) )
const steeringTorqueChart = new Chart( steeringTorqueChartElem, merge(chartOptions2, data2) )
const steeringAngleChart = new Chart( steeringAngleChartElem, merge(chartOptions3, data3) )
const brakeChart = new Chart( brakeChartElem, merge(chartOptions4, data4) )

const source = new EventSource(`http://${host}/data`)

let index = 1

source.addEventListener('message', (event) => {

	const data = JSON.parse(event.data)
  const wheelSpeed1 = data.carState.wheelSpeeds.rl
  const steeringTorque = data.carState.steeringTorque
  const steeringAngle = data.carState.steeringAngle
  const brake = data.carState.brake
  // console.log(data)
  console.log(data.carState)
  addData(`t${index}`, wheelSpeed1, speedChart)
  addData(`t${index}`, steeringTorque, steeringTorqueChart)
  addData(`t${index}`, steeringAngle, steeringAngleChart)
	addData(`t${index}`, brake, brakeChart)
	index++

}, false)
