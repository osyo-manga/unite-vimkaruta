scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#vimkaruta#define()
	return s:source
endfunction


let s:source = {
\	"name" : "vimkaruta",
\}


function! s:source.gather_candidates(args, context)
	if !exists("s:karuta_cache")
		let s:karuta_cache = webapi#json#decode(webapi#http#get("http://mattn.tonic-water.com/vim-karuta/json").content)
	endif
	return map(sort(items(deepcopy(s:karuta_cache))), '{
\		"word" : v:val[0] . ":" . v:val[1],
\	}')
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
