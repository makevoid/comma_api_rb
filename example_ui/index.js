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

// chart configs - sorry, this is long - todo: extract to a separate file

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

// config/setup ends

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

const speedChartElem = document.querySelector(".speedChart")
const brakeChartElem = document.querySelector(".brakeChart")
const steeringTorqueChartElem = document.querySelector(".steeringTorqueChart")
const steeringAngleChartElem  = document.querySelector(".steeringAngleChart")

// chart-js charts

const speedChart          = new Chart( speedChartElem, merge(chartOptions, data1) )
const brakeChart          = new Chart( brakeChartElem, merge(chartOptions4, data4) )
const steeringTorqueChart = new Chart( steeringTorqueChartElem, merge(chartOptions2, data2) )
const steeringAngleChart  = new Chart( steeringAngleChartElem, merge(chartOptions3, data3) )

const source = new EventSource(`http://${host}/data`)

let index = 1

const clock = () => {
  const now = new Date().toUTCString()
  return now
}

const selectCarState = (data) => { // select only the elements we care about atm from carstate
  const carState = data.carState

  // get carState bits we're interested to graph out *note1*
  const wheelSpeed1 		= carState.wheelSpeeds && carState.wheelSpeeds.rl // this can be improved by taking the avg or by charting in the same chart all 4
  const steeringTorque 	= carState.steeringTorque
  const steeringAngle 	= carState.steeringAngle
  const brake 					= carState.brake

  return { wheelSpeed1, steeringTorque, steeringAngle, brake }
}

const updateClock = () => {
  const clockElem = document.querySelector(".clock")
  clockElem.innerHTML = clock()
}

// renderChartTicks - the most important method around here

const renderChartTicks = (event) => {

  const data = JSON.parse(event.data)
  const carState = selectCarState(data)
  const { wheelSpeed1, steeringTorque, steeringAngle, brake } = selectCarState(data)

  // console.log(data)
  console.log(data.carState)
  // const msgId = `${index}`

  const msgId = new Date().getSeconds()

  addData(msgId, wheelSpeed1, speedChart)
  addData(msgId, steeringTorque, steeringTorqueChart)
  addData(msgId, steeringAngle, steeringAngleChart)
  addData(msgId, brake, brakeChart)

  index++
}

// processes new message
source.addEventListener('message', renderChartTicks, false)

// sophisticated clock lol
setInterval(updateClock, 200)

// notes:
//
// 	// *note1* - feel free to edit with wathever elements you prefer in `selectCarState`
// my suggestion is to keep consistency in the js names, css classes, etc so you can call `addData` with the correct args, edit the js correctly and have the right class for the <canvas /> element
