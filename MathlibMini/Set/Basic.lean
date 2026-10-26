/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

/-!
# Sets: Basic

The type of sets over a type `α`, represented by membership predicates.

A set of elements of `α` is a function `α → Prop`. No finiteness,
enumeration, or decidable membership is assumed.

This module provides the type, construction from a predicate,
membership, the subset relation, and extensionality.
It depends only on Lean core.

Inspired by Mathlib's `Set`. This is an independent, unofficial library.
-/

set_option autoImplicit false

namespace MathlibMini

universe u

@[expose] public section

/--
A set of elements of `α`, represented by its membership predicate.
-/
def Set (α : Type u) : Type u :=
  α → Prop

namespace Set

variable {α : Type u}

/--
The set of exactly those elements that satisfy a predicate.
-/
def ofPredicate (predicate : α → Prop) : Set α :=
  predicate

instance : Membership α (Set α) :=
  ⟨fun set element => set element⟩

instance : HasSubset (Set α) :=
  ⟨fun left right => ∀ ⦃element⦄, element ∈ left → element ∈ right⟩

/--
An element is a member of `ofPredicate predicate` exactly when it
satisfies `predicate`.
-/
@[simp]
theorem mem_ofPredicate_iff {predicate : α → Prop} {element : α} :
    element ∈ ofPredicate predicate ↔ predicate element :=
  Iff.rfl

/--
`left ⊆ right` unfolds to: every member of `left` is a member of `right`.
-/
theorem subset_def {left right : Set α} :
    left ⊆ right ↔ ∀ ⦃element⦄, element ∈ left → element ∈ right :=
  Iff.rfl

/--
Two sets are equal when they have the same members.
-/
@[ext]
theorem ext {left right : Set α}
    (h : ∀ element, element ∈ left ↔ element ∈ right) :
    left = right :=
  funext fun element => propext (h element)

/--
Every set is a subset of itself.
-/
theorem subset_refl (set : Set α) : set ⊆ set :=
  fun _ h => h

/--
The subset relation is transitive.
-/
theorem subset_trans {first second third : Set α}
    (h₁ : first ⊆ second) (h₂ : second ⊆ third) : first ⊆ third :=
  fun _ h => h₂ (h₁ h)

/--
Sets that are subsets of each other are equal.
-/
theorem subset_antisymm {left right : Set α}
    (h₁ : left ⊆ right) (h₂ : right ⊆ left) : left = right :=
  ext fun _ => ⟨fun h => h₁ h, fun h => h₂ h⟩

end Set

end -- public section

end MathlibMini
