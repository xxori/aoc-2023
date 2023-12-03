# Process one string by grabbing first and last int-parseable string and
# simulating string concatenation through +×10
ProcOne ← +×10⊢:⊢ ⇌.▽.∵⍣parse (0;;)⊔

# Splits the input by newline, maps ProcOne, and sums
PartOne ← /+∵ProcOne⊜□≠, @\n

# Load input from text file
PartOne &fras "../day01/data.txt"
$"Part 1: _"

# Returns the first arg if third arg starts with the second arg, 
# otherwise returns third arg unchanged
SW ← ⊔⊡:⇌⊂□⊙(⊙(≍⍣↙([];;;)⊙:⧻.)□,)

# Chain SW for all numbers (string form and num form)
StartsAll ← SW "9" "nine" SW "9" "9" SW "8" "eight" SW "8" "8" SW "7" "seven" SW "7" "7" SW "6" "six" SW "6" "6" SW "5" "five" SW "5" "5" SW "4" "four" SW "4" "4" SW "3" "three" SW "3" "3" SW "2" "two" SW "2" "2" SW "1" "one" SW "1" "1"

# Same as before, but accounting for string versions of the integers
ProcTwo ← +×10⊢:⊢⇌.▽.∵(⍣parse(0;;)StartsAll ⊔)≡(□↘⊔⊡0:⊔⊡1.)⍉⊟⊙(↯:□:)⇡.⧻.⊔
PartTwo ← /+∵ProcTwo ⊜□≠, @\n

PartTwo &fras "../day01/data.txt"
$"Part 2: _"
