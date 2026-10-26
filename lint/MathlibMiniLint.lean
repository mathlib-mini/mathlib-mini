/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public meta import Batteries.Tactic.Lint
import all MathlibMini.Set.Basic
import all MathlibMini.Set.Operations

/-!
# MathlibMini Lint Driver

Runs the Batteries environment linters over declarations in the
`MathlibMini` module hierarchy.
-/

#lint- only
  unusedArguments
  docBlame
  checkType
  synTaut
  unusedHavesSuffices
  impossibleInstance
  nonClassInstance
  simpNF
  simpComm
  in MathlibMini

public def main : IO Unit :=
  pure ()
