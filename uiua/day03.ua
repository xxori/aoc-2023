# Experimental!
FindNumbers ← ≡(∊:"1234567890")
FindSymbolsOne ← ¬≡(∊:"1234567890.")
GetCheckMask ← ¬⌕0⍥(⍉+⬚0↻¯1.+⬚0↻1.)2 FindSymbolsOne

Propagate ← +⊃∘(∵(≠NaN⍣parse(NaN;;)⊔⊡:⊂□"NaN":)⬚0↻:):
PropagateInts ← ↬((|3 ↫:⊙;|;:;):⊙(:⊃∘(≍⊃∘(.≠0+⊃(Propagate ¯1)(Propagate 1)))):⊙.)
PartOne ← /+≡(/+⊜parse≠,@N/⊂)∵(↙1$"_")×∵(⍣parse(NaN;;)):≡PropagateInts⊙.×FindNumbers:GetCheckMask..⊜∘≠,@\n
PartOne &fras "../day03/data.txt"
$"Part 1: _"

# This really isn't good...
# Takes like a minute to run
FindSymbolsTwo ← ≡(⬚0+⊔:⍘⊚¤)⊚≡(=@*):□≠..
GetCheckMaskTwo ← ≡(⍥(⍉+↻¯1:+↻1..)2) FindSymbolsTwo
PartTwo ← /+≡((0|/×)=2⧻.▽≠0.∵(parse ⊔)⊐/⊂≡(□⊜□≠,@N/⊂)∵(↙1$"_")×∵(⍣parse(NaN;;)):≡PropagateInts⊙.×FindNumbers ⊙:.⊔:)GetCheckMaskTwo:□.⊜∘≠,@\n
PartTwo &fras "../day03/data.txt"
$"Part 2: _"
