chai = require "chai"
do chai.should

describe "Wether or not Mocha works", ->
	it 'should work', ->
		(-> true)().should.equal true
		(-> true)().should.not.equal false