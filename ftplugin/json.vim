" Helper routine to convert bibtex-style to php-style
function! BibtexToJson() range
	let startline = getpos("'<")[1]
	let endline = getpos("'>")[1]

	let eprint = ""
	let eprinttype = ""

	let i = startline

	while i <= endline

		let line = getline(i)

		" Special case: empty line: Do not touch.
		" if line == ""
		" 	continue
		" end

		" Special cases: First/last line of entry
		let pattern_first_line = '^@\w*{\([[:alnum:]:]*\),$'
		if match(line, pattern_first_line) != -1
			let line = substitute(line, pattern_first_line, "\t\"\\1\": {", "")
		elseif match(line, "^}$") != -1
			let line = "\t},"
		else

			" Replace leading white space with tab
			let line = substitute(line, "^\\s*", "\t\t", "")

			" Embeds the first word in double quotes
			let line = substitute(line, "\\(\\w\\+\\)", "\"\\L\\1\"", "")

			" Replace = by :
			let line = substitute(line, " *= *", ": ", "")

			" Replace curly parentheses {} by '"'
			let line = substitute(line, "[{}]", "\"", "g")

			" Remove quotes around numbers
			let line = substitute(line, "\"\\(\\d\\+\\)\"", "\\1", "g")

			if match(line, "^\\s*\"author") != -1
				" Replace author by authors
				let line = substitute(line, "\"author\"", "\"authors\"", "g")

				" Replace and by , and und
				let line = substitute(line, " and ", ", ", "g")
				let line = substitute(line, ", \\ze[^,]*,$", " und ", "")
			endif

			if match(line, "^\\s*\"eprint\\>") != -1
				let eprint = matchlist(line, ": \"\\(.*\\)\",")[1]
				let line = ""
			endif
			if match(line, "^\\s*\"eprinttype\\>") != -1
				let eprinttype = matchlist(line, ": \"\\(.*\\)\",\\?")[1]
				let line = ""
			endif

			if eprint != "" && eprinttype ==? "arxiv"
				" Extract month

				let month = matchlist(eprint, '^\d\d\(\d\d\)\.')[1]
				let month = substitute(month, "^0", "", "")
				call append(i-1, "\t\t\"month\": " . month . ",")
				let i += 1
				let endline += 1

				let line = "\t\t\"arXiv\": \"" . eprint . "\","
				let eprint = ""
				let eprinttype = ""
			endif

		endif

		if line !~ '^\s*$'
			call setline(i, line)
			let i += 1
		else
			silent! exec i . "d"
			let endline -= 1
		end

	endwhile

	" Finally, we (try to) fix the json globally
	" Add some commas
	%s/}\zs\ze\n\t"/,/g

	" Remove some commas
	%s/\zs,\ze\n\t*}//g

endfunction
