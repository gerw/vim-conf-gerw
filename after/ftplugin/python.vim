" Restore my favorite settings.
" These are overwritten by the system-wide python.vim...
setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2


if ( getcwd() =~ "python-luxtronik" )
	setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
endif
