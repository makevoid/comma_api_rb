// config

// at the moment the only configuration is the API host, the API host has the token so the calls don"t require it (but then people need to run docker, and build and run containers atm)

// DEFAULT host - use this when running it locally
//
// const host = "localhost:3000"

// configure

// docker-compose / docker-swarm host:
// const host = "api:3000"

// const host = "mkvd.local:3000"   // main
const host = "mkvmbp3.local:3000"  // laptop

// const hostLaptop1  = "mkvmbp3.local:3000"
// const hostLaptop2  = "mkvmsi.local:3000"
// const hostDesktop1 = "mkvd.eu.ngrok.io:3000" # https available
// const host = hostLaptop1


// boilerplate code - todo: extract

const lineChartOptions = {
  //...
}
const chartOptions = {
  type: "line",
  options: lineChartOptions,
}

const chartOptions2 = Object.assign({}, chartOptions)
const chartOptions3 = Object.assign({}, chartOptions)
const chartOptions4 = Object.assign({}, chartOptions)

const chartOptions5 = Object.assign({}, chartOptions)
const chartOptions6 = Object.assign({}, chartOptions)


// merge helpers - utils

const merge2 = (obj1, obj2) => {
  Object.assign(obj1, obj2)
  return obj1
}

const merge = (obj1, obj2, obj3) => {
  if (obj3) {
    return merge2(merge2(obj1, obj2), obj3)
  } else {
    return merge2(obj1, obj2)
  }
}

// chart configs - sorry, this is long - todo: extract to a separate file

const colors = {
  red: {
    backgroundColor: 	"rgba(255, 99, 132, 0.2)",
    borderColor: 			"rgba(255, 99, 132, 1)",
  },
  blue: {
    backgroundColor: 	"rgba(54, 162, 235, 0.2)",
    borderColor: 			"rgba(54, 162, 235, 1)",
  },
  purple: {
    backgroundColor: 	"rgba(153, 102, 255, 0.2)",
    borderColor: 			"rgba(153, 102, 255, 1)",
  },
  green: {
    backgroundColor: 	"rgba(75, 192, 192, 0.2)",
    borderColor: 			"rgba(75, 192, 192, 1)",
  }
}

// initial form of the chart dataset array
const defaultData = () => { data: [0] } // note: a function always returns a copy

const speedData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["speed"] },
        defaultData(),
        colors.red,
      )
    ],
  },
}

const steerAngleData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["steerAngle"] },
        defaultData(),
        colors.blue,
      )
    ],
  },
}

const steerTorqueData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["steerTorque"] },
        defaultData(),
        colors.purple,
      )
    ],
  },
}

const accelData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["accel"] },
        defaultData(),
        colors.green,
      )
    ],
  },
}

const batteryData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["battery"] },
        defaultData(),
        colors.green,
      )
    ],
  },
}

const fanRPMData = {
  data: {
  labels: ["0"],
    datasets: [
      merge(
        { label: ["fanrpm"] },
        defaultData(),
        colors.green,
      )
    ],
  },
}

// config/setup ends

// chart helpers

const addData = (label, data, chart) => {
  const maxSize = 34
  if (chart.data.labels.length > maxSize) chart.data.labels.shift()
  chart.data.labels.push(label)
  const datasets = chart.data.datasets
  datasets.forEach((dataset) => {
    if (dataset.data.length > maxSize) dataset.data.shift()
    dataset.data.push(data)
  })
  chart.update()
}

// chart-js charts

const clock = () => {
  const now = new Date().toUTCString()
  return now
}

const queryCarState = (data) => { // select only the elements we care about atm from carstate
  const carState = data.carState

  // get carState bits we're interested to graph out *note1*
  const wheelSpeed1  = carState.wheelSpeeds && carState.wheelSpeeds.rl // this can be improved by taking the avg or by charting in the same chart all 4
  const steerTorque  = carState.steeringTorque // Steering Torque
  const steerAngle   = carState.steeringAngle  // Steering Angle
  const accel        = carState.aEgo

  console.log(accel)

  return { wheelSpeed1, steerTorque, steerAngle, accel }
}

// a clock is useful to know at which second we are (charts print the current second they're at - X axis)

const updateClock = () => {
  const clockElem = document.querySelector(".clock")
  clockElem.innerHTML = clock()
}

// renderChartTicks() - the most important method around here, calls `addData()` (add a point to a chart), renderChartTicks() runs for each "tick" (SSE message received)

const renderChartTicks = (event) => {
  const data = JSON.parse(event.data)
  const carState = queryCarState(data)
  const { wheelSpeed1, steerTorque, steerAngle, accel } = carState
  // uncomment to see all available data in carstate:
  // console.log("carstate:", ata.carState)

  const msgId = new Date().getSeconds()


  addData(msgId, wheelSpeed1, speedChart)
  addData(msgId, steerTorque, steerTorqueChart)
  addData(msgId, steerAngle,  steerAngleChart)
  addData(msgId, accel,       accelChart)
}

const renderChartTicksEON = (event) => {
  const data = JSON.parse(event.data)
  const carState = queryCarState(data)
  const { battery, fanRPM } = queryCarState(data)

  const msgId = new Date().getSeconds()

  addData(msgId, battery, speedChart)
  addData(msgId, fanRPM,  steerTorqueChart)
}



let speedChart
let accelChart
let steerTorqueChart
let steerAngleChart
let batteryChartElem
let fanRPMChartElem

// main function
const renderChart = () => {
  const speedChartElem       = document.querySelector(".speedChart")
  const accelChartElem       = document.querySelector(".accelChart")
  const steerTorqueChartElem = document.querySelector(".steeringTorqueChart")
  const steerAngleChartElem  = document.querySelector(".steeringAngleChart")
  const batteryChartElem     = document.querySelector(".batteryChart")
  const fanRPMChartElem      = document.querySelector(".fanRPMChart")

  speedChart        = new Chart( speedChartElem,        merge(chartOptions, speedData)  )
  accelChart        = new Chart( accelChartElem,        merge(chartOptions4, accelData) )
  steerTorqueChart  = new Chart( steerTorqueChartElem,  merge(chartOptions2, steerAngleData) )
  steerAngleChart   = new Chart( steerAngleChartElem,   merge(chartOptions3, steerTorqueData) )
  batteryChart      = new Chart( batteryChartElem,      merge(chartOptions5, batteryData) )
  fanRPMChart       = new Chart( fanRPMChartElem,       merge(chartOptions6, fanRPMData) )

  const source    = new EventSource(`http://${host}/data`) // car ("carState")
  // const sourceEon = new EventSource(`http://${host}/data/eon`)

  // processes new message
  source.addEventListener("message", renderChartTicks,    false)
  // source.addEventListener("message", renderChartTicksEon, false)

  // sophisticated clock lol
  setInterval(updateClock, 200)
}


// notes:
//
// // *note1* - feel free to edit with wathever elements you prefer in `queryCarState`
// my suggestion is to keep consistency in the js names, css classes, etc so you can call `addData` with the correct args, edit the js correctly and have the right class for the <canvas /> element
//
// todo: remove these notes because really?


window.addEventListener('DOMContentLoaded', renderChart)
