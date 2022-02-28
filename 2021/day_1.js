

const compute = (datas) => {
	let result = []

	datas.forEach((data, index) => {
		if (index !== 0) {
			const previousIndex = datas.indexOf(datas[index - 1], index - 1)
			if(data > datas[previousIndex])
			result.push(data)
		}
		return result
	})

	console.log(result.length)
}

const fs = require('fs')
const datas = fs.readFileSync("day_1_data.txt").toString().split("\n").map((data) => parseInt(data)).filter(data => !isNaN(data))

console.log("Part 1")
compute(datas)

console.log("Part 2")
let startingIndex = 0


const summedDatas = datas.map((data, index) => {
	let valuesToSum = []

	if (index + 3 <= datas.length) {
		for (let step = 0; step < 3; step++) {
	  		valuesToSum.push(datas[index + step])
		}
		return valuesToSum.reduce((previousValue, currentValue) => previousValue + currentValue)
	}
})

compute(summedDatas)