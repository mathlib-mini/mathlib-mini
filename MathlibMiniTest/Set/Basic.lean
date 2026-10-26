/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import MathlibMini

/-!
# Tests: Set.Basic

Checks the public surface of `MathlibMini.Set` from an importing module.
-/

set_option autoImplicit false

namespace MathlibMiniTest.Set.Basic

open MathlibMini

variable {α : Type} (predicate : α → Prop) (element : α)

/-- Membership in `ofPredicate` is the predicate (by the simp lemma). -/
example : element ∈ Set.ofPredicate predicate ↔ predicate element := by
  simp

/-- The definitions are exposed: membership unfolds by `Iff.rfl` in an importer. -/
example : element ∈ Set.ofPredicate predicate ↔ predicate element :=
  Iff.rfl

/-- Extensionality: sets with the same members are equal. -/
example (left right : Set α) (h : ∀ x, x ∈ left ↔ x ∈ right) : left = right :=
  Set.ext h

/-- Extensionality works through the `ext` tactic. -/
example (left right : Set α) (h : ∀ x, x ∈ left ↔ x ∈ right) : left = right := by
  ext x
  exact h x

/-- The subset relation is reflexive, transitive, and antisymmetric. -/
example (a b c : Set α) (h₁ : a ⊆ b) (h₂ : b ⊆ c) : a ⊆ c :=
  Set.subset_trans h₁ h₂

example (a : Set α) : a ⊆ a :=
  Set.subset_refl a

example (a b : Set α) (h₁ : a ⊆ b) (h₂ : b ⊆ a) : a = b :=
  Set.subset_antisymm h₁ h₂

/-- `subset_def` exposes the unfolded statement. -/
example (a b : Set α) (h : ∀ ⦃x⦄, x ∈ a → x ∈ b) : a ⊆ b :=
  Set.subset_def.mpr h

/-- Two different predicates give two different sets. -/
example : Set.ofPredicate (fun _ : Nat => True) ≠ Set.ofPredicate (fun _ : Nat => False) := by
  intro h
  have : (0 : Nat) ∈ Set.ofPredicate (fun _ : Nat => False) := by
    rw [← h]
    simp
  simp at this

end MathlibMiniTest.Set.Basic
