// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// ARGS: compile --phase=check --dump-sem-ir --dump-raw-sem-ir %s
//
// Check that we can combine textual IR and raw IR dumping in one compile.
//
// AUTOUPDATE

// --- a.carbon
fn A() {}

// --- b.carbon
fn B() {}

// CHECK:STDOUT: ---
// CHECK:STDOUT: filename:        a.carbon
// CHECK:STDOUT: sem_ir:
// CHECK:STDOUT:   cross_reference_irs_size: 1
// CHECK:STDOUT:   functions:
// CHECK:STDOUT:     function0:       {name: str0, param_refs: block0, body: [block1]}
// CHECK:STDOUT:   classes:         {}
// CHECK:STDOUT:   types:
// CHECK:STDOUT:     type0:           {node: nodeFunctionType, value_rep: {kind: copy, type: type0}}
// CHECK:STDOUT:   type_blocks:     {}
// CHECK:STDOUT:   nodes:
// CHECK:STDOUT:     node+0:          {kind: FunctionDeclaration, arg0: function0, type: type0}
// CHECK:STDOUT:     node+1:          {kind: Return}
// CHECK:STDOUT:   node_blocks:
// CHECK:STDOUT:     block0:          {}
// CHECK:STDOUT:     block1:
// CHECK:STDOUT:       0:               node+1
// CHECK:STDOUT:     block2:
// CHECK:STDOUT:       0:               node+0
// CHECK:STDOUT: ...
// CHECK:STDOUT:
// CHECK:STDOUT: file "a.carbon" {
// CHECK:STDOUT:   %A: <function> = fn_decl @A
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @A() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT: ---
// CHECK:STDOUT: filename:        b.carbon
// CHECK:STDOUT: sem_ir:
// CHECK:STDOUT:   cross_reference_irs_size: 1
// CHECK:STDOUT:   functions:
// CHECK:STDOUT:     function0:       {name: str1, param_refs: block0, body: [block1]}
// CHECK:STDOUT:   classes:         {}
// CHECK:STDOUT:   types:
// CHECK:STDOUT:     type0:           {node: nodeFunctionType, value_rep: {kind: copy, type: type0}}
// CHECK:STDOUT:   type_blocks:     {}
// CHECK:STDOUT:   nodes:
// CHECK:STDOUT:     node+0:          {kind: FunctionDeclaration, arg0: function0, type: type0}
// CHECK:STDOUT:     node+1:          {kind: Return}
// CHECK:STDOUT:   node_blocks:
// CHECK:STDOUT:     block0:          {}
// CHECK:STDOUT:     block1:
// CHECK:STDOUT:       0:               node+1
// CHECK:STDOUT:     block2:
// CHECK:STDOUT:       0:               node+0
// CHECK:STDOUT: ...
// CHECK:STDOUT:
// CHECK:STDOUT: file "b.carbon" {
// CHECK:STDOUT:   %B: <function> = fn_decl @B
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @B() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
