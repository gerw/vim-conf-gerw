" Helper routine to convert bibtex-style to php-style
function! Modify() range
	let startline = getpos("'<")[1]
	let endline = getpos("'>")[1]

	for i in range(startline, endline)
		let line = getline(i)

		" Embeds the first word in brackets
		let line = substitute(line, "\\(\\w\\+\\)", "\"\\1\"", "")

		" Replace = by =>
		let line = substitute(line, "=", "=>", "")

		" Replace curly parentheses {} by '"'
		let line = substitute(line, "[{}]", "\"", "g")

		if match(line, "^\\s*\"author") != -1
			" Replace author by authors
			let line = substitute(line, "\"author\"", "\"authors\"", "g")

			" Replace and by $und
			let line = substitute(line, " and ", " $und ", "g")
		endif

		call setline(i, line)
	endfor
endfunction
