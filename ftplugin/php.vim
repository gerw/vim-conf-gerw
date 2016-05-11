" Helper routine to convert bibtex-style to php-style
function! BibtexToPhp() range
	let startline = getpos("'<")[1]
	let endline = getpos("'>")[1]

	for i in range(startline, endline)

		let line = getline(i)

		" Special case: empty line: Do not touch.
		if line == ""
			continue
		end

		" Special cases: First/last line of entry
		let pattern_first_line = '^@\w*{\([[:alnum:]:]*\),$'
		if match(line, pattern_first_line) != -1
			let line = substitute(line, pattern_first_line, "$bibliography[\"\\1\"] = array(", "")
		elseif match(line, "^}$") != -1
			let line = ");"
		else

			" Replace leading white space with tab
			let line = substitute(line, "^\\s*", "	", "")

			" Embeds the first word in brackets
			let line = substitute(line, "\\(\\w\\+\\)", "\"\\L\\1\"", "")

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

		endif

		call setline(i, line)
	endfor
endfunction
