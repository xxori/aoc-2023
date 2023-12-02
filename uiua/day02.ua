# You aren't gonna like this one...

# Takes an input of boxed strings starting with space ie [box" 3 green" box" 5 red"]
# For each colour that isnt present, this function adds it with a count of 0
# RestoreZeroColors ← ⊂▽:[□" 0 red" □" 0 green" □" 0 blue"][≍≠..∵(≍□"blue"□↘+1⊢⊚⌕@ .↘1⊔):⊙:≍≠..∵(≍□"green"□↘+1⊢⊚⌕@ .↘1⊔):≍≠..∵(≍□"red"□↘+1⊢⊚⌕@ .↘1⊔)]...⊜□≠,@,⊔
RestoreZeroColors ← ⊂▽:[□" 0 red" □" 0 green" □" 0 blue"][≍≠..∵(≍□"red"□↘+1⊢⊚⌕@ .↘1⊔):⊙:≍≠..∵(≍□"green"□↘+1⊢⊚⌕@ .↘1⊔):≍≠..∵(≍□"blue"□↘+1⊢⊚⌕@ .↘1⊔)]...⊜□≠,@,⊔

# Process one game string, returning its ID if it is valid and 0 otherwise
ProcOne ← × × ×≤12;↘1:⊢.:≤13:↘1:⊢.:≤14:↘1:⊢.≡(/↥)⍉≡(∵(parse↙ ⊢ ⊚ ⌕@ .↘1⊔)⊏⍏∵(□↘+1⊢⊚ ⌕@ .↘1⊔)).∵(RestoreZeroColors)⊜□≠,@;:⊙(↘+6):⊙(parse↙).⊢⊚⌕@:.↘5.⊔
PartOne ← /+∵ProcOne⊜□≠, @\n
PartOne &fras "../day02/data.txt"
$"Part 1: _"

# Much the same, but we can ignore the logic to store the game id,
# and ignore the logic for bounds checking, instead just doing a mult reduction
ProcTwo ← /×≡(/↥)⍉≡(∵(parse↙ ⊢ ⊚ ⌕@ .↘1⊔)⊏⍏∵(□↘+1⊢⊚ ⌕@ .↘1⊔)).∵(RestoreZeroColors)⊜□≠,@;↘+1⊢⊚⌕@:.⊔
PartTwo ← /+∵ProcTwo⊜□≠, @\n
PartTwo &fras "../day02/data.txt"
$"Part 2: _"
