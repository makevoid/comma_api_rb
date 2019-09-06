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

const data1 = { data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    }, }

let data

const gps1Elem = document.querySelector(".gps1")
const compassElem = document.querySelector(".compass")

data = { data: data1 }
const gps			= new Chart( gps1Elem, 		merge(chartOptions, data1) )

data = { data: data2 }
const compass	= new Chart( compassElem, merge(chartOptions, data2) )

const host = "localhost:3000"

const source = new EventSource(`http://${host}/data`)
source.addEventListener('message', (event) => {
  console.log(event.data)
}, false)


// function addData(chart, label, data) {
//     chart.data.labels.push(label);
//     chart.data.datasets.forEach((dataset) => {
//         dataset.data.push(data);
//     });
//     chart.update();
// }
