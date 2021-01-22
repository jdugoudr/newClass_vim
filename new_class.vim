function s:skip_to_function(list)
	let i = 0
	while i < len(a:list) - 1
		if (matchstr(a:list[i], '^\([ \t]*\)//') == "")
			let l:str = matchstr(a:list[i], '^[ \t]\([a-zA-Z1-9]*\).*(.*)[;\( const;\)]')
			if l:str == ""
				call remove(a:list, i)
				let i = i - 1
			else
				let l:str = matchstr(a:list[i], '.*0;$')
				if l:str != ""
					call remove(a:list, i)
					let i = i - 1
				endif
			endif
		else
			call remove(a:list, i)
			let i = i - 1
		endif
		let i = i + 1
	endwhile
	return a:list
endfunction

function s:break_header_in_list()
	let l:list = readfile(s:className.".hpp")
	if len(l:list) == 1
		echo "I think you use a Mac"
		let l:list = split (l:list[0], '<CR>')
	endif
	return s:skip_to_function(l:list)
endfunction

function s:format_cpp_functions(str)
	let l:str = substitute(a:str, "virtual ", "", "g")
	let l:str = substitute(l:str, ";", "{}", "g")
	let l:str = substitute(l:str, "^[ \t]", "", "g")
	let i = match(l:str, 'operator.*(')
	if i != -1
		let l:str = printf("%s%s::%s", strcharpart(l:str, 0, i), s:className, strcharpart(l:str, i))
	else
		let i =  match(l:str, '[~]*[a-zA-Z1-9]*(')
		if i != -1
			let l:str = printf("%s%s::%s", strcharpart(l:str, 0, i), s:className, strcharpart(l:str, i))
		endif
	endif
	return l:str
endfunction

function s:is_not_canonic(str)
	let l:list = [s:className."()",s:className."(".s:className." const &other)","~".s:className."()","operator=(".s:className." const &other)"]

	for i in range(0, len(l:list) - 1)
		if stridx(a:str, l:list[i]) != -1
			return 0
		endif
	endfor
	return 1
endfunction

function s:write_proto(i, str)
	if s:is_not_canonic(a:str) == 1
		call append(a:i, a:str)
		return a:i + 1
	endif
	return a:i
endfunction

function s:format_each_line(list)
	let i = search("<+FUNCTIONS+>")	
	normal dd
	let i = i - 1
	for l in range(0, len(a:list) - 1)
		let l:str = s:format_cpp_functions(a:list[l])
		let i = s:write_proto(i, l:str)
	endfor
endfunction

function s:find_header_file()
	if (filereadable(s:className.".hpp"))
		let l:list = s:break_header_in_list()
		call s:format_each_line(l:list)
	else
		echo "is not readable"
	endif
endfunction

function s:Get_ClassName()
	return expand('%:t:r')
endfunction

function s:find_replace(find, replace)
	let l = 1
	for line in getline(1,"$")
		call setline(l, substitute(line, '<+'.a:find.'+>', a:replace, "g"))
		let l = l + 1
	endfor
endfunction

function s:Create_Functions()
	let l:ext = expand('%:e')
	let s:className = s:Get_ClassName()
	if l:ext == "hpp"
		execute "0r ~/.vim/templates/skelton.hpp"
		execute "Stdheader"
		call s:find_replace('CLASS', s:className)
		let	l:tmp = toupper(expand('%t'))
		call s:find_replace('DINCLUSION', substitute(l:tmp, "[.]", "_", ""))
	elseif l:ext == "cpp"
		execute "0r ~/.vim/templates/skelton.cpp"
		execute "Stdheader"
		call s:find_replace('CLASS', s:className)
		call s:find_header_file()
	endif
endfunction

command NewClass call s:Create_Functions ()
nmap <F4> :NewClass<CR>
