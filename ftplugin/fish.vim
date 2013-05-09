setlocal commentstring=#%s
setlocal iskeyword=@,48-57,-,_,.,/

let b:endwise_addition = 'end'
let b:endwise_words = 'begin,function,if,switch,while,for'
let b:endwise_syngroups = 'fishKeyword,fishConditional,fishRepeat'
