# Experimental!
ProcOne ← (ⁿ:2-1|0)=0./+∵(⊐∊)⊔⊢↘1:⊢.⊜(□⊜parse≠,@ )≠,@|↘+1⊢⊚⌕@:.
PartOne ← /+⊜ProcOne≠,@\n
PartOne &fras "../day04/data.txt"
$"Part 1: _"

ProcTwo ← /+∵(⊐∊)⊔⊢↘1:⊢.⊜(□⊜parse≠,@ )≠,@|↘+1⊢⊚⌕@:.
GetAddMat ← ∵⊂0⊂↯:0:↯:1⊙(+1)
Recurse ← ↬((|2 ↫ +1⊙(⬚0+×GetAddMat⊙(:⊢ ⇌)⊢.⊡,,).|;)=,-1⧻,)
PartTwo ← /+≡(⊢ ⇌)Recurse0∵⊂:+1≠..⊜ProcTwo≠,@\n
PartTwo &fras "../day04/data.txt"
$"Part 2: _"
