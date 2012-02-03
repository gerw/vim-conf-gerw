" A plugin to swap words.
" Written by Gerd Wachsmuth


" You need to call two times <Plug>SwapWords in order to swap two words.
" The first word is memorized by the first call and can be reset by calling
" <Plug>ResetSwapWords

" Mapping: use the selection
vmap <silent> <Plug>SwapWords <esc>:call SwapWords("visual")<CR>

" Mapping: use a text object and reset the cursor (the cursor should not move)
nmap <silent> <Plug>SwapWords :call SavePosition()<CR>:set operatorfunc=SwapWords<CR>g@

" Mapping: Clear the memory.
map <silent> <Plug>ResetSwapWords :call ResetSwapWords()<CR>




" Helper Function:
" Saves the current Position
function SavePosition()
	let b:currentPosition = getpos(".")
endfunction

" Helper Function:
" Restores the current Position
function RestorePosition()
	call setpos(".", b:currentPosition)
	unlet b:currentPosition
endfunction

" Helper Function:
" Return the first "length" from the string.
function GetStartString( string, length )
	if a:length < 0
		" This situation must be handled different, because a:string[:(a:length)] is
		" the whole string!
		return ""
	else
		return a:string[:(a:length)]
	end
endfunction

" The main function.
function SwapWords( mode )
	if a:mode == "visual"
		let startpos = getpos("'<")
		let endpos = getpos("'>")
	elseif a:mode == "char"
		let startpos = getpos("'[")
		let endpos = getpos("']")
	else
		exit
	end

	" Only work within one line
	if startpos[1] == endpos[1]
		if exists("b:SwapWordStartpos")
			" This is the second call of the function.
			if startpos[1] == b:SwapWordStartpos[1]
				" Both words are within the same line
				let line = getline(startpos[1])

				let firstWordStart = b:SwapWordStartpos[2]-1
				let firstWordEnd = b:SwapWordEndpos[2]-1
				let secondWordStart = startpos[2]-1
				let secondWordEnd = endpos[2]-1

				let firstWord = line[(firstWordStart):(firstWordEnd)]
				let secondWord = line[(secondWordStart):(secondWordEnd)]

				if firstWordEnd < secondWordStart
					" firstWord appears first in the line
					let new_line = GetStartString( line, firstWordStart-1 ) . secondWord . line[firstWordEnd+1:secondWordStart-1] . firstWord . line[secondWordEnd+1:]
					call setline(startpos[1], new_line)
				elseif secondWordEnd < firstWordStart
					" secondWord appears first in the line
					let new_line = GetStartString( line, secondWordStart-1 ) . firstWord . line[secondWordEnd+1:firstWordStart-1] . secondWord . line[firstWordEnd+1:]
					call setline(startpos[1], new_line)
				else
					" Both words collide
				end
			else
				" Both words appear on different lines.
				let firstLine = getline(b:SwapWordStartpos[1])
				let secondLine = getline(startpos[1])

				let firstWordStart = b:SwapWordStartpos[2]-1
				let firstWordEnd = b:SwapWordEndpos[2]-1
				let secondWordStart = startpos[2]-1
				let secondWordEnd = endpos[2]-1

				let firstWord = firstLine[(firstWordStart):(firstWordEnd)]
				let secondWord = secondLine[(secondWordStart):(secondWordEnd)]

				let newFirstLine = GetStartString(firstLine,firstWordStart-1) . secondWord . firstLine[firstWordEnd+1:]
				let newSecondLine = GetStartString(secondLine,secondWordStart-1) . firstWord . secondLine[secondWordEnd+1:]

				call setline(b:SwapWordStartpos[1], newFirstLine )
				call setline(startpos[1], newSecondLine )
			endif
			call ResetSwapWords()
		else
			" This is the first call of the function.
			let b:SwapWordStartpos = startpos
			let b:SwapWordEndpos = endpos
		endif
	endif

	" Reset the cursor if the function was called by a text object motion.
	if a:mode == "char"
		call RestorePosition()
	endif
endfunction

function ResetSwapWords()
	unlet b:SwapWordStartpos
	unlet b:SwapWordEndpos
endfunction
