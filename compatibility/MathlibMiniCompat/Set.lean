/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import MathlibMini
import Mathlib.Data.Set.Basic

/-!
# Compatibility: Set

Relates `MathlibMini.Set` to Mathlib's `Set`.

The two types are different types with the same representation.
This module proves that conversion in both directions is lossless,
and that conversion preserves membership, the subset relation, and
each operation `MathlibMini.Set` provides.

If a Mathlib change breaks one of these theorems, this package fails
to build, which is the signal that the two have drifted apart.
-/

set_option autoImplicit false

namespace MathlibMiniCompat

universe u

variable {α : Type u}

/--
Convert a `MathlibMini.Set` to a Mathlib `Set` with the same members.
-/
def toMathlib (set : MathlibMini.Set α) : _root_.Set α :=
  {element | element ∈ set}

/--
Convert a Mathlib `Set` to a `MathlibMini.Set` with the same members.
-/
def ofMathlib (set : _root_.Set α) : MathlibMini.Set α :=
  MathlibMini.Set.ofPredicate fun element => element ∈ set

/-! ### Membership and round trips -/

/--
Membership in the converted Mathlib set is membership in the original.
-/
@[simp]
theorem mem_toMathlib_iff {set : MathlibMini.Set α} {element : α} :
    element ∈ toMathlib set ↔ element ∈ set :=
  Iff.rfl

/--
Membership in the converted `MathlibMini` set is membership in the original.
-/
@[simp]
theorem mem_ofMathlib_iff {set : _root_.Set α} {element : α} :
    element ∈ ofMathlib set ↔ element ∈ set :=
  Iff.rfl

/--
Converting to Mathlib and back gives the original `MathlibMini` set.
-/
theorem ofMathlib_toMathlib (set : MathlibMini.Set α) :
    ofMathlib (toMathlib set) = set :=
  MathlibMini.Set.ext fun _ => Iff.rfl

/--
Converting to `MathlibMini` and back gives the original Mathlib set.
-/
theorem toMathlib_ofMathlib (set : _root_.Set α) :
    toMathlib (ofMathlib set) = set :=
  Set.ext fun _ => Iff.rfl

/--
The two set types are equivalent.
-/
def equiv : MathlibMini.Set α ≃ _root_.Set α where
  toFun := toMathlib
  invFun := ofMathlib
  left_inv := ofMathlib_toMathlib
  right_inv := toMathlib_ofMathlib

/-! ### Subset -/

/--
Conversion preserves and reflects the subset relation.
-/
theorem toMathlib_subset_iff {left right : MathlibMini.Set α} :
    toMathlib left ⊆ toMathlib right ↔ left ⊆ right :=
  Iff.rfl

/-! ### Operations -/

/--
The empty `MathlibMini` set converts to the empty Mathlib set.
-/
theorem toMathlib_empty : toMathlib (∅ : MathlibMini.Set α) = ∅ :=
  Set.ext fun _ => Iff.rfl

/--
The universal `MathlibMini` set converts to the universal Mathlib set.
-/
theorem toMathlib_univ : toMathlib (MathlibMini.Set.univ : MathlibMini.Set α) = Set.univ :=
  Set.ext fun _ => Iff.rfl

/--
A `MathlibMini` singleton converts to the Mathlib singleton.
-/
theorem toMathlib_singleton (element : α) :
    toMathlib ({element} : MathlibMini.Set α) = {element} :=
  Set.ext fun _ => Iff.rfl

/--
Insertion commutes with conversion.
-/
theorem toMathlib_insert (element : α) (set : MathlibMini.Set α) :
    toMathlib (insert element set) = insert element (toMathlib set) :=
  Set.ext fun _ => Iff.rfl

/--
Union commutes with conversion.
-/
theorem toMathlib_union (left right : MathlibMini.Set α) :
    toMathlib (left ∪ right) = toMathlib left ∪ toMathlib right :=
  Set.ext fun _ => Iff.rfl

/--
Intersection commutes with conversion.
-/
theorem toMathlib_inter (left right : MathlibMini.Set α) :
    toMathlib (left ∩ right) = toMathlib left ∩ toMathlib right :=
  Set.ext fun _ => Iff.rfl

end MathlibMiniCompat
