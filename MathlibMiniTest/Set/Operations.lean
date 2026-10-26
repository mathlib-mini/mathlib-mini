/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import MathlibMini

/-!
# Tests: Set.Operations

Checks membership lemmas, order lemmas, and algebraic laws of
`MathlibMini.Set` from an importing module.
-/

set_option autoImplicit false

namespace MathlibMiniTest.Set.Operations

open MathlibMini

variable {α : Type} (a b c : Set α) (x y : α)

/-! ### Membership -/

example : x ∈ a ∪ b ↔ x ∈ a ∨ x ∈ b := by simp
example : x ∈ a ∩ b ↔ x ∈ a ∧ x ∈ b := by simp
example : x ∈ ({y} : Set α) ↔ x = y := by simp
example : x ∈ insert y a ↔ x = y ∨ x ∈ a := by simp
example : ¬ x ∈ (∅ : Set α) := by simp
example : x ∈ (Set.univ : Set α) := by simp

/-! ### Order -/

example : (∅ : Set α) ⊆ a := Set.empty_subset a
example : a ⊆ Set.univ := Set.subset_univ a
example : a ⊆ a ∪ b := Set.subset_union_left a b
example : b ⊆ a ∪ b := Set.subset_union_right a b
example (h₁ : a ⊆ c) (h₂ : b ⊆ c) : a ∪ b ⊆ c := Set.union_subset h₁ h₂
example : a ∩ b ⊆ a := Set.inter_subset_left a b
example : a ∩ b ⊆ b := Set.inter_subset_right a b
example (h₁ : c ⊆ a) (h₂ : c ⊆ b) : c ⊆ a ∩ b := Set.subset_inter h₁ h₂

/-! ### Laws -/

example : a ∪ b = b ∪ a := Set.union_comm a b
example : a ∪ b ∪ c = a ∪ (b ∪ c) := Set.union_assoc a b c
example : a ∪ a = a := by simp
example : a ∪ ∅ = a := by simp
example : ∅ ∪ a = a := by simp
example : a ∩ b = b ∩ a := Set.inter_comm a b
example : a ∩ a = a := by simp

/-! ### Non-vacuity -/

/-- Insertion into the empty set is the singleton. -/
example : (insert x ∅ : Set α) = {x} := by
  ext z
  simp

/-- A concrete set has the expected members and non-members. -/
example : (1 : Nat) ∈ ({1, 2} : Set Nat) := by simp
example : ¬ (3 : Nat) ∈ ({1, 2} : Set Nat) := by simp

end MathlibMiniTest.Set.Operations
