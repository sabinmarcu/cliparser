# Some regular tests, just to make sure Jasmine is running right
#

describe "Regular tests", ->

	it "Should add right", ->
		(expect 3 + 4).toBe 7
		(expect 1.3 + 1.4).toBe 2.7

	it "Should substract right", ->
		(expect 5 - 2).toBe 3
		(expect 3.2 - 1.1).toBe 2.1

	it "Should multiply right", ->
		(expect 2 * 3).toBe 6

	it "Should divide right", ->
		(expect 4 / 2).toBe 2


