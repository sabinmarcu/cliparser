# Testing the Parser 
#

Package = require "../lib/parser.js"

_count = (json) ->
	nr = 0
	nr++ for key, value of json
	return nr

describe "Parser", ->

	it "Should be contained in the package", ->
		(expect typeof Package.Parser).toBe "function"

	it "Should throw error when encountering lack of args", ->
		e = null
		failed = false
		Parser = new Package.Parser

		try
			Parser.parse()			
			failed = false
		catch error
			e = error
			failed = true

		(expect failed).toBe true
		(expect e).not.toBe null
		(expect e.errno).toBe 1
		(expect e.msg).toBe "Application did not receive arguments!"
			

	it "Should parse properly", ->
		Parser = new Package.Parser

		results = Parser.parse([
			"node"
			"run"
			"-o"
			"./lib/parse"
			"--watch"
			"for"
			"files"
			"--and"
			"search"
			"for"	
			"--some"
			"crap"
			"-a"
			"good"
		])

		(expect results.single.length).toBe 2
		(expect results.single).toContain "node"
		(expect results.single).toContain "run"
		
		(expect _count results.dash).toBe 2
		(expect results.dash["o"]).toContain "./lib/parse"
		(expect results.dash["a"]).toContain "good"

		(expect _count results.doubledash).toBe 3
		(expect results.doubledash["watch"]).toContain "for"
		(expect results.doubledash["watch"]).toContain "files"
		(expect results.doubledash["and"]).toContain "search"
		(expect results.doubledash["and"]).toContain "for"
		(expect results.doubledash["some"]).toContain "crap"

