import Lake
open Lake DSL

package «evaluation» where
  -- add package configuration options here
  srcDir := "src"

lean_lib «Evaluation» where
  -- add library configuration options here

lean_lib «Testing» where
  -- add library configuration options here
  srcDir := "../tests"

@[default_target]
lean_exe «evaluation» where
  root := `Main
