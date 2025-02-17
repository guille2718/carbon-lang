// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/parse/context.h"

namespace Carbon::Parse {

// Handles ParameterAs(Implicit|Regular).
static auto HandleParameter(Context& context, State pattern_state,
                            State finish_state) -> void {
  context.PopAndDiscardState();

  context.PushState(finish_state);
  context.PushState(pattern_state);
}

auto HandleParameterAsImplicit(Context& context) -> void {
  HandleParameter(context, State::PatternAsImplicitParameter,
                  State::ParameterFinishAsImplicit);
}

auto HandleParameterAsRegular(Context& context) -> void {
  HandleParameter(context, State::PatternAsParameter,
                  State::ParameterFinishAsRegular);
}

// Handles ParameterFinishAs(Implicit|Regular).
static auto HandleParameterFinish(Context& context, Lex::TokenKind close_token,
                                  State param_state) -> void {
  auto state = context.PopState();

  if (state.has_error) {
    context.ReturnErrorOnState();
  }

  if (context.ConsumeListToken(NodeKind::ParameterListComma, close_token,
                               state.has_error) ==
      Context::ListTokenKind::Comma) {
    context.PushState(param_state);
  }
}

auto HandleParameterFinishAsImplicit(Context& context) -> void {
  HandleParameterFinish(context, Lex::TokenKind::CloseSquareBracket,
                        State::ParameterAsImplicit);
}

auto HandleParameterFinishAsRegular(Context& context) -> void {
  HandleParameterFinish(context, Lex::TokenKind::CloseParen,
                        State::ParameterAsRegular);
}

// Handles ParameterListAs(Implicit|Regular).
static auto HandleParameterList(Context& context, NodeKind parse_node_kind,
                                Lex::TokenKind open_token_kind,
                                Lex::TokenKind close_token_kind,
                                State param_state, State finish_state) -> void {
  context.PopAndDiscardState();

  context.PushState(finish_state);
  context.AddLeafNode(parse_node_kind, context.ConsumeChecked(open_token_kind));

  if (!context.PositionIs(close_token_kind)) {
    context.PushState(param_state);
  }
}

auto HandleParameterListAsImplicit(Context& context) -> void {
  HandleParameterList(
      context, NodeKind::ImplicitParameterListStart,
      Lex::TokenKind::OpenSquareBracket, Lex::TokenKind::CloseSquareBracket,
      State::ParameterAsImplicit, State::ParameterListFinishAsImplicit);
}

auto HandleParameterListAsRegular(Context& context) -> void {
  HandleParameterList(context, NodeKind::ParameterListStart,
                      Lex::TokenKind::OpenParen, Lex::TokenKind::CloseParen,
                      State::ParameterAsRegular,
                      State::ParameterListFinishAsRegular);
}

// Handles ParameterListFinishAs(Implicit|Regular).
static auto HandleParameterListFinish(Context& context,
                                      NodeKind parse_node_kind,
                                      Lex::TokenKind token_kind) -> void {
  auto state = context.PopState();

  context.AddNode(parse_node_kind, context.ConsumeChecked(token_kind),
                  state.subtree_start, state.has_error);
}

auto HandleParameterListFinishAsImplicit(Context& context) -> void {
  HandleParameterListFinish(context, NodeKind::ImplicitParameterList,
                            Lex::TokenKind::CloseSquareBracket);
}

auto HandleParameterListFinishAsRegular(Context& context) -> void {
  HandleParameterListFinish(context, NodeKind::ParameterList,
                            Lex::TokenKind::CloseParen);
}

}  // namespace Carbon::Parse
