module

public import MathlibMini.Set.Basic

/-!
# Sets: Operations

The empty set, the universal set, singletons, insertion, union, and
intersection, each with its membership lemma, and the basic order
lemmas relating them to the subset relation.

Inspired by Mathlib's `Set`. This is an independent, unofficial library.
-/

set_option autoImplicit false

namespace MathlibMini

universe u

@[expose] public section

namespace Set

variable {α : Type u}

instance : EmptyCollection (Set α) :=
  ⟨fun _ => False⟩

instance : Singleton α (Set α) :=
  ⟨fun element other => other = element⟩

instance : Insert α (Set α) :=
  ⟨fun element set other => other = element ∨ other ∈ set⟩

instance : Union (Set α) :=
  ⟨fun left right element => element ∈ left ∨ element ∈ right⟩

instance : Inter (Set α) :=
  ⟨fun left right element => element ∈ left ∧ element ∈ right⟩

/--
The set of all elements of `α`.
-/
def univ : Set α :=
  fun _ => True

/-! ### Membership -/

/--
No element is a member of the empty set.
-/
@[simp]
theorem mem_empty_iff_false (element : α) :
    element ∈ (∅ : Set α) ↔ False :=
  Iff.rfl

/--
Every element is a member of the universal set.
-/
@[simp]
theorem mem_univ (element : α) :
    element ∈ (univ : Set α) :=
  trivial

/--
Membership in a singleton is equality with its element.
-/
@[simp]
theorem mem_singleton_iff {element other : α} :
    other ∈ ({element} : Set α) ↔ other = element :=
  Iff.rfl

/--
Membership after insertion is equality with the inserted element or
membership in the original set.
-/
@[simp]
theorem mem_insert_iff {element other : α} {set : Set α} :
    other ∈ insert element set ↔ other = element ∨ other ∈ set :=
  Iff.rfl

/--
Membership in a union is membership in either set.
-/
@[simp]
theorem mem_union_iff {left right : Set α} {element : α} :
    element ∈ left ∪ right ↔ element ∈ left ∨ element ∈ right :=
  Iff.rfl

/--
Membership in an intersection is membership in both sets.
-/
@[simp]
theorem mem_inter_iff {left right : Set α} {element : α} :
    element ∈ left ∩ right ↔ element ∈ left ∧ element ∈ right :=
  Iff.rfl

/-! ### Order -/

/--
The empty set is a subset of every set.
-/
theorem empty_subset (set : Set α) : ∅ ⊆ set :=
  fun _ h => h.elim

/--
Every set is a subset of the universal set.
-/
theorem subset_univ (set : Set α) : set ⊆ univ :=
  fun _ _ => trivial

/--
A set is a subset of its union with another set, on the left.
-/
theorem subset_union_left (left right : Set α) : left ⊆ left ∪ right :=
  fun _ h => Or.inl h

/--
A set is a subset of its union with another set, on the right.
-/
theorem subset_union_right (left right : Set α) : right ⊆ left ∪ right :=
  fun _ h => Or.inr h

/--
A union is a subset of a set when both parts are.
-/
theorem union_subset {left right set : Set α}
    (h₁ : left ⊆ set) (h₂ : right ⊆ set) : left ∪ right ⊆ set :=
  fun _ h => h.elim (fun h => h₁ h) (fun h => h₂ h)

/--
An intersection is a subset of its left set.
-/
theorem inter_subset_left (left right : Set α) : left ∩ right ⊆ left :=
  fun _ h => h.1

/--
An intersection is a subset of its right set.
-/
theorem inter_subset_right (left right : Set α) : left ∩ right ⊆ right :=
  fun _ h => h.2

/--
A set is a subset of an intersection when it is a subset of both parts.
-/
theorem subset_inter {left right set : Set α}
    (h₁ : set ⊆ left) (h₂ : set ⊆ right) : set ⊆ left ∩ right :=
  fun _ h => ⟨h₁ h, h₂ h⟩

/-! ### Union laws -/

/--
Union is commutative.
-/
theorem union_comm (left right : Set α) : left ∪ right = right ∪ left :=
  ext fun _ => Or.comm

/--
Union is associative.
-/
theorem union_assoc (first second third : Set α) :
    first ∪ second ∪ third = first ∪ (second ∪ third) :=
  ext fun _ => or_assoc

/--
A set united with itself is itself.
-/
@[simp]
theorem union_self (set : Set α) : set ∪ set = set :=
  ext fun _ => or_self_iff

/--
The empty set is a right identity for union.
-/
@[simp]
theorem union_empty (set : Set α) : set ∪ ∅ = set :=
  ext fun _ => ⟨fun h => h.elim (fun h => h) (fun h => h.elim), fun h => Or.inl h⟩

/--
The empty set is a left identity for union.
-/
@[simp]
theorem empty_union (set : Set α) : ∅ ∪ set = set :=
  ext fun _ => ⟨fun h => h.elim (fun h => h.elim) (fun h => h), fun h => Or.inr h⟩

/-! ### Intersection laws -/

/--
Intersection is commutative.
-/
theorem inter_comm (left right : Set α) : left ∩ right = right ∩ left :=
  ext fun _ => And.comm

/--
A set intersected with itself is itself.
-/
@[simp]
theorem inter_self (set : Set α) : set ∩ set = set :=
  ext fun _ => and_self_iff

end Set

end -- public section

end MathlibMini
