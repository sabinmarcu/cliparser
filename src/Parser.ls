IS = require "isf"

class Parser extends IS.Object

	@extend IS.DefineProperty.extend
	@extend IS.Modules.Overload

	@define "raw_args", (-> @_raw_args), (...args) ->
		if args.length is 1 
			if args[0].substr? then @_raw_args = args[0].split " "
			else @_raw_args = args[0]
		else @_raw_args = args

	(...args) ~> @parse.apply @, args
	parse: (...args) ~> 

		if args.length is 1 then @raw_args = args[0]
		else @raw_args = args

		@do-parse!

	do-parse: ~>
		@bare-args = []; @single-dash-args = {length: 0};  @double-dash-args = {length: 0}; @final-arg = null
		args = []; args <<< @raw_args

		# Grabbing the bare arguments 
		item = args.shift!
		while item? and (@first-letter item) isnt "-"
			@bare-args.push item
			item = args.shift!

		last-opt = null; last-opt-no = 0
		# Skimming through the rest, grabbing them as we go
		while item
			if (@first-letter item) is "-"
				if (@second-letter item) is "-" then 
					opt = item.substr 2
					@double-dash-args[opt] = @double-dash-args[@double-dash-args.length] = []
					@double-dash-args.length += 1
					last-opt = @double-dash-args[opt]
					last-opt-no = 0
				else 
					opts = (item.substr 1).split ""
					for opt in opts 
						@single-dash-args[opt] = @single-dash-args[@single-dash-args.length] = []
						@single-dash-args.length += 1
					last-opt = @single-dash-args[opt]
					last-opt-no = 0
			else 
				if last-opt-no is 0 or args.length isnt 0
					last-opt.push item
					last-opt-no = last-opt-no + 1
				else @final-arg = item

			item = args.shift!

		@

	link: (sets) ~>
		for f, t of sets
			if (@second-letter f) is "-"
				f = f.substr 2; t = t.substr 1
				if not @double-dash-args[f]? then @double-dash-args[f] = @double-dash-args[@double-dash-args.length++] = []
				if not @single-dash-args[t]? then @single-dash-args[t] = @single-dash-args[@single-dash-args.length++] = []
				for item in @double-dash-args[f] when not (item in @single-dash-args[t]) then @single-dash-args[t].push item
				for item in @single-dash-args[t] when not (item in @double-dash-args[f]) then @double-dash-args[f].push item
			else
				f = f.substr 1; t = t.substr 2
				if not @double-dash-args[t]? then @double-dash-args[t] = @double-dash-args[@double-dash-args.length++] = []
				if not @single-dash-args[f]? then @single-dash-args[f] = @single-dash-args[@single-dash-args.length++] = []
				for item in @double-dash-args[t] when not (item in @single-dash-args[f]) then @single-dash-args[f].push item
				for item in @single-dash-args[f] when not (item in @double-dash-args[t]) then @double-dash-args[t].push item
		@

	expect: (...sets) ~>
		return if not sets?
		if sets.length is 1 and sets[0].length? and sets[0].length > 0 then sets = sets[0]
		for ex in sets
			if (@second-letter ex) is "-"
				ex = ex.substr 2
				if not @double-dash-args[ex]? then @double-dash-args[ex] = null
			else
				ex = ex.substr 1
				if not @single-dash-args[ex]? then @single-dash-args[ex] = null
		@

	booleanify: ~>
		for arg, items of @single-dash-args 
			if items is null 
				if not @single-dash-args[arg]? then @single-dash-args[arg] = @single-dash-args[@single-dash-args.length++] = false
				else @single-dash-args[arg] = false
			else if items.length is 0 then @single-dash-args[arg] = true
		for arg, items of @double-dash-args 
			if items is null 
				if not @double-dash-args[arg]? then @double-dash-args[arg] = @double-dash-args[@double-dash-args.length] = false
				else @double-dash-args[arg] = false
			else if items.length is 0 then @double-dash-args[arg] = true
		@

	first-letter: (string) -> string.substr 0, 1
	second-letter: (string) -> string.substr 1, 1

module.exports = Parser