# CLI Parser

Have you ever heard of a language named [Typescript]("http://typescriptlang.com/")?
It's a cool new programming language created by [ Microsoft ]("http://microsoft.com/") that extends Javascript and adds cool new functionality like classes, with private, public scopes, constructors, ... it basically makes Javascript a lot less chaotic.

This particular project has the point of helping me do some cool stuff with Typescript (or learn to do it :P)

#### Example : 

	Package = require("./parser")
	Parser = new Package.Parser

	Parser.parse(process.argv)
	console.log(Parser)

> Results :   
>      
> {    
> "single": ["node", "file"]  
> "dash": { "o": ["./file.js"] }    
> "doubledash": { "--watch": ["all"] }    
> }    
>        
>        
> Called for : "node file -o ./file.js --watch all"


##

## I hope that one day it might help people to do some stuff with it, apart from helping me understand it.

<table>
	<tr>
		<th>Project</th>
		<th>CLI Parser</th>
	</tr>
	<tr>
		<td>Homepage</td>
		<td>NILL</td>
	</tr>
	<tr>
		<td>Author</td>
		<td>Sabin Marcu</td>
	</tr>
</table>
