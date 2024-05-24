import Lean
import Lean.Meta

open Lean System Meta

namespace Testing

structure TestResult where
  total : UInt32
  passed : UInt32
  failed : UInt32
  errored : UInt32

def TestResult.init (total : UInt32) : TestResult := { total := total, passed := 0, failed := 0, errored := 0 }

def TestResult.success (r : TestResult) : Bool :=
  r.failed == 0

-- Function to check if a given name is a test function
def isTestFunction (declName : Name) : Bool :=
  declName.toString.startsWith "test"

def getTestFunctions : MetaM (List ConstantInfo) := do
  let env ← getEnv
  let decls := env.constants.toList
  return decls.filter (λ (name, _) => isTestFunction name) |> .map Prod.snd

unsafe def run : MetaM (Except String TestResult) := do
  -- Get all test functions in the module
  let testFuncs ← getTestFunctions

  -- Ensure all test functions can be called
  for (cinfo) in testFuncs do
    if cinfo.numLevelParams != 0 then
      let funName := cinfo.name.toString
      return Except.error s!"Function {funName} is not a valid test function (should take no arguments)."

  let mut testResult := TestResult.init testFuncs.length.toUInt32

  -- for (cinfo) in testFuncs do
  --   let result ← evalConst (Bool × String) cinfo.name
  --   match result with
  --   | Except.ok (true, _) =>
  --     IO.println s!"[PASSED] {cinfo}"
  --     testResult := { testResult with passed := testResult.passed + 1 }
  --   | Except.ok (false, msg) =>
  --     IO.println s!"Test {name} failed: {msg}"
  --     testResult := { testResult with failed := testResult.failed + 1 }
  --   | Except.error err =>
  --     IO.println s!"Error executing test {name}: {err}"
  --     testResult := { testResult with errored := testResult.errored + 1 }

  return Except.ok testResult

end Testing

-- Function to run all test functions and gather results
-- def runTests : IO (Except String String) := do
--   let env ← IO.getEnv
--   let decls := env.constants.toList
--   let testFuncs := decls.filter (λ (name, _) => isTestFunction name)

--   -- Ensure all test functions can be called
--   for (name, _) in testFuncs do
--     let cinfo ← IO.ofExcept <| env.find? name
--     if cinfo.type.getPiArity != 0 then
--       return Except.error s!"Function {name} is not a valid test function (should take no arguments)."

--   -- Execute all test functions and gather results
--   let mut allTestsPassed := true
--   for (name, _) in testFuncs do
--     let result ← evalConst (Bool × String) name
--     match result with
--     | Except.ok (true, _) => continue
--     | Except.ok (false, msg) =>
--       IO.println s!"Test {name} failed: {msg}"
--       allTestsPassed := false
--     | Except.error err =>
--       IO.println s!"Error executing test {name}: {err}"
--       allTestsPassed := false

--   if allTestsPassed then
--     return Except.ok
--   else
--     return Except.error "Some tests failed."

-- end TestFramework




-- def executeTestFunction (funcName : Name) : MetaM Bool := do
--   let env ← getEnv
--   let some decl := env.find? funcName | throwError "Function {funcName} not found"
--   match decl with
--   | ConstantInfo.defnInfo val =>
--     match val.type with
--     | Expr.forallE _ _ body _ =>
--       match body with
--       | Expr.const `Bool _ =>
--         let fn ← evalConst (Unit → Bool) funcName
--         return fn ()
--       | _ => throwError "Function {funcName} does not return a Bool"
--     | _ => throwError "Expected a function type for {funcName}"
--   | _ => throwError "Expected a function declaration for {funcName}"

-- def executeTestsInModule (modName : Name) : MetaM Unit := do
--   let env ← getEnv
--   let decls := env.constants.fold (fun acc n _ =>
--     if n.isInternal then acc
--     else if n.getPrefix == modName then n :: acc
--     else acc
--   ) []
--   let testDecls := decls.filter (fun n => n.getString!.startsWith "Test")

--   for testDecl in testDecls do
--     try
--       let result ← executeTestFunction testDecl
--       if result then
--         IO.println s!"[PASSED] {testDecl}"
--       else
--         IO.println s!"[FAILED] {testDecl}"
--     catch e =>
--       IO.println s!"[ERROR] {testDecl}: {e.toMessageData}"
