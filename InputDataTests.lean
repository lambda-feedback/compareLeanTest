import «Evaluation»
-- import Lean.Data.Json
-- import Lean.Data.Json.FromToJson

-- open Lean Json System

-- -- Function to run a test and print the result
def runTest (testName : String) (result : Bool) : IO Unit := do
  if result then
    IO.println s!"[PASSED] {testName}"
  else
    IO.println s!"[FAILED] {testName}"

def testCompareValues : IO Unit := do
  runTest "Equal strings" (compareValues "test" "test" = true)
  runTest "Different strings" (compareValues "test" "TEST" = false)

-- def testProcessInputData : IO Unit := do
--   let input1 := { command := "eval", response := "42", answer := "42", params := none }
--   let expected1 := { command := "eval", result := { is_correct := true, feedback := "Correct!" } }
--   runTest "Correct response with default feedback" (processInputData input1 == expected1)

--   let input2 := { command := "eval", response := "42", answer := "24", params := none }
--   let expected2 := { command := "eval", result := { is_correct := false, feedback := "Incorrect!" } }
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
--   match fromJson? (Json.parse! json) with
--   | Except.ok (inputData : InputData) =>
--     runTest "Parse InputData from JSON (command)" (inputData.command = "eval")
--     runTest "Parse InputData from JSON (response)" (inputData.response = "42")
--     runTest "Parse InputData from JSON (answer)" (inputData.answer = "42")
--     runTest "Parse InputData from JSON (correct feedback)" (inputData.params.getD {}.correct_response_feedback = "Great!")
--     runTest "Parse InputData from JSON (incorrect feedback)" (inputData.params.getD {}.incorrect_response_feedback = "Not quite.")
--   | Except.error err =>
--     runTest "Parse InputData from JSON" false

--   let result := { is_correct := true, feedback := "Correct!" }
--   let outputData := { command := "eval", result := result }
--   let expectedJson := "{\"command\":\"eval\",\"result\":{\"is_correct\":true,\"feedback\":\"Correct!\"}}"
--   runTest "Generate OutputData to JSON" (toJson outputData).pretty = expectedJson

def main : IO Unit := do
  IO.println "Running tests..."
  -- testCompareValues
  -- testProcessInputData
  -- testJsonParsing
  IO.println "Tests completed."

-- #eval main
