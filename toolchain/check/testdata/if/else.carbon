// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() {}
fn G() {}
fn H() {}

fn If(b: bool) {
  if (b) {
    F();
  } else {
    G();
  }
  H();
}

// CHECK:STDOUT: file "else.carbon" {
// CHECK:STDOUT:   %F: <function> = fn_decl @F
// CHECK:STDOUT:   %G: <function> = fn_decl @G
// CHECK:STDOUT:   %H: <function> = fn_decl @H
// CHECK:STDOUT:   %If: <function> = fn_decl @If
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @H() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @If(%b: bool) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %b.ref: bool = name_reference "b", %b
// CHECK:STDOUT:   if %b.ref br !if.then else br !if.else
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then:
// CHECK:STDOUT:   %F.ref: <function> = name_reference "F", file.%F
// CHECK:STDOUT:   %.loc13_6.1: type = tuple_type ()
// CHECK:STDOUT:   %.loc13_6.2: init () = call %F.ref()
// CHECK:STDOUT:   br !if.done
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else:
// CHECK:STDOUT:   %G.ref: <function> = name_reference "G", file.%G
// CHECK:STDOUT:   %.loc15: init () = call %G.ref()
// CHECK:STDOUT:   br !if.done
// CHECK:STDOUT:
// CHECK:STDOUT: !if.done:
// CHECK:STDOUT:   %H.ref: <function> = name_reference "H", file.%H
// CHECK:STDOUT:   %.loc17: init () = call %H.ref()
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
