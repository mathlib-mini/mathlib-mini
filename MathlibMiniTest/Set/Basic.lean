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

/-- `subset_refl` is tagged `@[refl]`, so `rfl` closes `a ⊆ a`. -/
example (a : Set α) : a ⊆ a := by
  rfl

/-- `rw` closes a goal of the form `a ⊆ a` by `rfl` after rewriting. -/
example (a b : Set α) (h : a = b) : a ⊆ b := by
  rw [h]

/-- `ssubset_def` exposes the unfolded statement. -/
example (a b : Set α) : a ⊂ b ↔ a ⊆ b ∧ ¬ b ⊆ a :=
  Set.ssubset_def

/-- A strict subset is a subset. -/
example (a b : Set α) (h : a ⊂ b) : a ⊆ b :=
  h.1

/-- `constructor` splits a strict subset into its two parts. -/
example (a b : Set α) (h₁ : a ⊆ b) (h₂ : ¬ b ⊆ a) : a ⊂ b := by
  constructor
  · exact h₁
  · exact h₂

/-- No set is a strict subset of itself. -/
example (a : Set α) : ¬ a ⊂ a :=
  fun h => h.2 (Set.subset_refl a)

end MathlibMiniTest.Set.Basic
