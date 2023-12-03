# Experimental!
FindNumbers ← ≡(∊:"1234567890")
FindSymbolsOne ← ¬≡(∊:"1234567890.")
GetCheckMask ← ¬⌕0⍥(⍉+↻¯1.+↻1.)2 FindSymbolsOne

Propagate ← +⊃∘(∵(≠NaN⍣parse(NaN;;)⊔⊡:⊂□"NaN":)↻:):
PropagateInts ← ↬((|3 ↫:⊙;|;:;):⊙(:⊃∘(≍⊃∘(.≠0+⊃(Propagate ¯1)(Propagate 1)))):⊙.)
PartOne ← /+≡(/+⊜parse≠,@N/⊂)∵(↙1$"_")×∵(⍣parse(NaN;;)):≡PropagateInts⊙.×FindNumbers:GetCheckMask..≡(⇌⊂@.⇌⊂@.)⊜∘≠,@\n
PartOne &fras "../day03/data.txt"
$"Part 1: _"

# FindSymbolsTwo ← ≡(=@*)
# GetCheckMaskTwo ← ¬⌕0⍥(⍉+↻¯1.+↻1.)2 FindSymbolsTwo
# GetCheckMaskTwo ≡(⇌⊂@.⇌⊂@.)⊜∘≠,@\n &fras "./test.txt"
