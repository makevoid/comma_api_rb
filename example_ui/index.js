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
	label: 'speed',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(255, 99, 132, 0.2)' ],
  borderColor: 			[ 'rgba(255, 99, 132, 1)' ],
}

const chartDataset2 = {
	label: 'steeringTorque',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(54, 162, 235, 0.2)' ],
	borderColor: 			[ 'rgba(54, 162, 235, 1)' ],
}

const chartDataset3 = {
	label: 'steeringAngle',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(153, 102, 255, 0.2)' ],
	borderColor: 			[ 'rgba(153, 102, 255, 1)' ],
}

const chartDataset4 = {
	label: 'brake',
	data: [ 1 ],
	backgroundColor: 	[ 'rgba(75, 192, 192, 0.2)' ],
	borderColor: 			[ 'rgba(75, 192, 192, 1)' ],
}

const data1 = {
	data: {
		labels: 	['0'],
    datasets: [chartDataset1],
	},
}

const data2 = {
	data: {
		labels: 	['0'],
    datasets: [chartDataset2],
	},
}

const data3 = {
	data: {
		labels: 	['0'],
    datasets: [chartDataset3],
	},
}

const data4 = {
	data: {
		labels: 	['0'],
    datasets: [chartDataset4],
	},
}

// chart helpers

const addData = (label, data, chart) => {
  const maxSize = 34
  if (chart.data.labels.length > maxSize) chart.data.labels.shift()
	chart.data.labels.push(label)
	chart.data.datasets.forEach((dataset) => {
    if (dataset.data.length > maxSize) dataset.data.shift()
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
	const carState = data.carState

	// get carState bits we're interested to graph out
  const wheelSpeed1 		= carState.wheelSpeeds.rl // this can be improved by taking the avg or by charting in the same chart all 4
  const steeringTorque 	= carState.steeringTorque
  const steeringAngle 	= carState.steeringAngle
  const brake 					= carState.brake

  // console.log(data)
  console.log(data.carState)
	// const msgId = `${index}`
	const msgId = new Date()
  addData(msgId, wheelSpeed1, speedChart)
  addData(msgId, steeringTorque, steeringTorqueChart)
  addData(msgId, steeringAngle, steeringAngleChart)
	addData(msgId, brake, brakeChart)
	index++

}, false)
