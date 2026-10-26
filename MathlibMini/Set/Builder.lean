/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import MathlibMini.Set.Basic

/-!
# Sets: Set-builder notation

The notation `{ element | predicate element }` for the set of exactly
those elements that satisfy a predicate, and the typed form
`{ element : α | predicate element }`.

Both forms mean `MathlibMini.Set.ofPredicate fun element => ...`.
The pretty printer shows `ofPredicate` applied to a function in
set-builder form.

Inspired by Mathlib's `Set`. This is an independent, unofficial library.
-/

set_option autoImplicit false

/-- `{ element | predicate }` is the set of elements satisfying `predicate`. -/
syntax "{" ident " | " term "}" : term

/-- `{ element : α | predicate }` is the set of `α` satisfying `predicate`. -/
syntax "{" ident " : " term " | " term "}" : term

macro_rules
  | `({ $element:ident | $predicate }) =>
      `(MathlibMini.Set.ofPredicate fun $element:ident => $predicate)
  | `({ $element:ident : $type | $predicate }) =>
      `(MathlibMini.Set.ofPredicate fun ($element:ident : $type) => $predicate)

namespace MathlibMini

universe u

@[expose] public section

namespace Set

variable {α : Type u}

/--
Print `ofPredicate fun element => predicate` as `{ element | predicate }`.
-/
@[app_unexpander ofPredicate]
meta def unexpandOfPredicate : Lean.PrettyPrinter.Unexpander
  | `($_ fun $element:ident => $predicate) => `({ $element:ident | $predicate })
  | _ => throw ()

/--
Membership in a set-builder set is the predicate applied to the element.
The simp lemma `mem_ofPredicate_iff` already covers this in `simp`.
-/
theorem mem_setOf_eq {predicate : α → Prop} {element : α} :
    (element ∈ { x | predicate x }) = predicate element :=
  rfl

end Set

end -- public section

end MathlibMini
