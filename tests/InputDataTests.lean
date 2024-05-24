import «Testing»
import «Evaluation»
import Lean.Meta
import Lean.Data.Json
import Lean.Data.Json.FromToJson

open Lean System Meta

-- -- Function to run a test and print the result
-- def runTest (testName : String) (result : Bool) : IO Bool := do
--   if result then
--     IO.println s!"[PASSED] {testName}"
--   else
--     IO.println s!"[FAILED] {testName}"
--   return result

-- def runGroup (groupName : String) (tests : List (String × IO Bool)) : IO Bool := do
--   IO.println s!"Running group: {groupName}"
--   let results ← tests.mapM (λ (testName, test) => do
--     let result ← test
--     if result then
--       IO.println s!"  [PASSED] {testName}"
--     else
--       IO.println s!"  [FAILED] {testName}"
--     return result
--   )
--   return results.all id

-- def testCompareValues : IO Unit := do
--   runTest "Equal strings" (compareValues "test" "test" = true)
--   runTest "Different strings" (compareValues "test" "TEST" = false)

-- def testProcessInputData : IO Unit := do
--   let input1 := { command := "eval", response := "42", answer := "42", params := none }
--   let expected1 := { command := "eval", result := { is_correct := true, feedback := "Correct" } }
--   runTest "Correct response with default feedback" (processInputData input1 == expected1)

--   let input2 := { command := "eval", response := "42", answer := "24", params := none }
--   let expected2 := { command := "eval", result := { is_correct := false, feedback := "Incorrect" } }
--   runTest "Incorrect response with default feedback" (processInputData input2 == expected2)

--   let params := { correct_response_feedback := some "Well done!", incorrect_response_feedback := some "Try again." }
--   let input3 := { command := "eval", response := "42", answer := "42", params := some params }
--   let expected3 := { command := "eval", result := { is_correct := true, feedback := "Well done!" } }
--   runTest "Correct response with custom feedback" (processInputData input3 == expected3)

--   let input4 := { command := "eval", response := "42", answer := "24", params := some params }
--   let expected4 := { command := "eval", result := { is_correct := false, feedback := "Try again." } }
--   runTest "Incorrect response with custom feedback" (processInputData input4 == expected4)

-- def testJsonParsing : IO Unit := do
--   let json := "{\"command\":\"eval\",\"response\":\"42\",\"answer\":\"42\",\"params\":{\"correct_response_feedback\":\"Great!\",\"incorrect_response_feedback\":\"Not quite.\"}}"
--   match Json.parse json with
--   | Except.ok json =>
--     match fromJson? json with
--     | Except.ok (inputData : InputData) =>
--       runTest "Parse InputData from JSON (command)" (inputData.command = "eval")
--       runTest "Parse InputData from JSON (response)" (inputData.response = "42")
--       runTest "Parse InputData from JSON (answer)" (inputData.answer = "42")
--       runTest "Parse InputData from JSON (correct feedback)" ((inputData.params.getD {}).correct_response_feedback == "Great!")
--       runTest "Parse InputData from JSON (incorrect feedback)" ((inputData.params.getD {}).incorrect_response_feedback == "Not quite.")
--     | Except.error _ =>
--       runTest "Parse InputData from JSON" false

--     let outputData : OutputData := { command := "eval", result := { is_correct := true, feedback := "Correct!" } }
--     let expectedJson := "{\"command\":\"eval\",\"result\":{\"is_correct\":true,\"feedback\":\"Correct!\"}}"
--     runTest "Generate OutputData to JSON" ((toJson outputData).compress == expectedJson)
--   | Except.error _ =>
--     runTest "Parse JSON" false


def main : IO Unit := do
  match Testing.runTests with
  | Except.ok _ => IO.println "All tests passed!"
  | Except.error _ => IO.println "Some tests failed"
