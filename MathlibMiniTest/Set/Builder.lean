/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import MathlibMini

/-!
# Tests: Set.Builder

Checks the set-builder notation of `MathlibMini.Set` from an
importing module.
-/

set_option autoImplicit false

namespace MathlibMiniTest.Set.Builder

open MathlibMini

variable {α : Type} (predicate : α → Prop) (a b : Set α) (element : α)

/-- `{ x | p x }` is `ofPredicate` applied to the predicate. -/
example : ({ x | predicate x } : Set α) = Set.ofPredicate predicate :=
  rfl

/-- The typed form `{ x : α | p x }` is the same set. -/
example : ({ x : α | predicate x } : Set α) = ({ x | predicate x } : Set α) :=
  rfl

/-- Membership in a set-builder set is the predicate (by the simp lemma). -/
example : element ∈ ({ x | predicate x } : Set α) ↔ predicate element := by
  simp

/-- The membership lemma states the equality directly. -/
example : (element ∈ ({ x | predicate x } : Set α)) = predicate element :=
  Set.mem_setOf_eq

/-- Membership unfolds by `Iff.rfl` in an importer. -/
example : element ∈ ({ x | predicate x } : Set α) ↔ predicate element :=
  Iff.rfl

/-- A set-builder set with a compound condition. -/
example : ({ x | x ∈ a ∧ x ∈ b } : Set α) = a ∩ b := by
  ext x
  simp

/-- A set-builder set over a concrete type. -/
example : (3 : Nat) ∈ ({ n : Nat | n > 2 } : Set Nat) := by
  simp

example : (1 : Nat) ∉ ({ n : Nat | n > 2 } : Set Nat) := by
  simp

end MathlibMiniTest.Set.Builder
