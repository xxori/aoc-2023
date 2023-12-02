# Process one string by grabbing first and last int-parseable string and
# simulating string concatenation through +×10
ProcOne ← +×10⊢:⊢ ⇌.▽.∵⍣parse (0;;)⊔

# Splits the input by newline, maps ProcOne, and sums
PartOne ← /+∵ProcOne⊜□≠, @\n

# Load input from text file
PartOne &fras "../day01/data.txt"
$"Part 1: _"

# Returns the first arg if third arg starts with the second arg, 
# otherwise returns third arg
StartsWith ← ⊔⊡:⇌⊂□⊙(⊙(≍⍣↙([];;;)⊙:⧻.)□,)

# Chain Startswith for all numbers (string form and num form)
StartsAll ← StartsWith "9" "nine" StartsWith "9" "9" StartsWith "8" "eight" StartsWith "8" "8" StartsWith "7" "seven" StartsWith "7" "7" StartsWith "6" "six" StartsWith "6" "6" StartsWith "5" "five" StartsWith "5" "5" StartsWith "4" "four" StartsWith "4" "4" StartsWith "3" "three" StartsWith "3" "3" StartsWith "2" "two" StartsWith "2" "2" StartsWith "1" "one" StartsWith "1" "1"

# Same as before, but accounting for string versions of the integers
ProcTwo ← +× 10 ⊢:⊢ ⇌.▽.∵(⍣parse(0;;)StartsAll ⊔)≡(□↘⊔⊡0:⊔⊡1.)⍉⊟⊙(↯:□:)⇡.⧻.⊔
PartTwo ← /+∵ProcTwo ⊜□≠, @\n

PartTwo &fras "../day01/data.txt"
$"Part 2: _"
