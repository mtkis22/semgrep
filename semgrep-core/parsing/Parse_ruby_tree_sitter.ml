(* Yoann Padioleau
 *
 * Copyright (C) 2020 r2c
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License (GPL)
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * file license.txt for more details.
 *)
open Common
module CST = Tree_sitter_ruby.CST

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)
(* Ruby parser using ocaml-tree-sitter-lang/ruby and converting
 * to pfff/lang_ruby/parsing/ast_ruby.ml
 * This can then be converted to the generic AST by using
 * pfff/lang_ruby/analyze/ruby_to_generic.ml
 *)

(*****************************************************************************)
(* Boilerplate converter *)
(*****************************************************************************)
(* This was started by copying ocaml-tree-sitter-lang/ruby/Boilerplate.ml *)

(* Disable warnings against unused variables, unused value, unused rec *)
[@@@warning "-26-27-32-39"]

let token (_tok : Tree_sitter_run.Token.t) = failwith "not implemented"
let blank () = failwith "not implemented"
let todo x =
  pr2_gen x;
  failwith "not implemented"

let uninterpreted (tok : CST.uninterpreted) =
  token tok

let binary_star (tok : CST.binary_star) =
  token tok

let singleton_class_left_angle_left_langle (tok : CST.singleton_class_left_angle_left_langle) =
  token tok

let instance_variable (tok : CST.instance_variable) =
  token tok

let binary_minus (tok : CST.binary_minus) =
  token tok

let simple_symbol (tok : CST.simple_symbol) =
  token tok

let complex (tok : CST.complex) =
  token tok

let character (tok : CST.character) =
  token tok

let escape_sequence (tok : CST.escape_sequence) =
  token tok

let false_ (x : CST.false_) =
  (match x with
  | `False_false tok -> token tok
  | `False_FALSE tok -> token tok
  )

let subshell_start (tok : CST.subshell_start) =
  token tok

let regex_start (tok : CST.regex_start) =
  token tok

let constant (tok : CST.constant) =
  token tok

let symbol_start (tok : CST.symbol_start) =
  token tok

let unary_minus (tok : CST.unary_minus) =
  token tok

let block_ampersand (tok : CST.block_ampersand) =
  token tok

let class_variable (tok : CST.class_variable) =
  token tok

let string_array_start (tok : CST.string_array_start) =
  token tok

let splat_star (tok : CST.splat_star) =
  token tok

let integer (tok : CST.integer) =
  token tok

let heredoc_content (tok : CST.heredoc_content) =
  token tok

let string_end (tok : CST.string_end) =
  token tok

let line_break (tok : CST.line_break) =
  token tok

let identifier (tok : CST.identifier) =
  token tok

let string_content (tok : CST.string_content) =
  token tok

let heredoc_end (tok : CST.heredoc_end) =
  token tok

let nil (x : CST.nil) =
  (match x with
  | `Nil_nil tok -> token tok
  | `Nil_NIL tok -> token tok
  )

let heredoc_beginning (tok : CST.heredoc_beginning) =
  token tok

let float_ (tok : CST.float_) =
  token tok

let global_variable (tok : CST.global_variable) =
  token tok

let symbol_array_start (tok : CST.symbol_array_start) =
  token tok

let heredoc_body_start (tok : CST.heredoc_body_start) =
  token tok

let operator (x : CST.operator) =
  (match x with
  | `Op_DOTDOT tok -> token tok
  | `Op_BAR tok -> token tok
  | `Op_HAT tok -> token tok
  | `Op_AMP tok -> token tok
  | `Op_LTEQGT tok -> token tok
  | `Op_EQEQ tok -> token tok
  | `Op_EQEQEQ tok -> token tok
  | `Op_EQTILDE tok -> token tok
  | `Op_GT tok -> token tok
  | `Op_GTEQ tok -> token tok
  | `Op_LT tok -> token tok
  | `Op_LTEQ tok -> token tok
  | `Op_PLUS tok -> token tok
  | `Op_DASH tok -> token tok
  | `Op_STAR tok -> token tok
  | `Op_SLASH tok -> token tok
  | `Op_PERC tok -> token tok
  | `Op_BANG tok -> token tok
  | `Op_BANGTILDE tok -> token tok
  | `Op_STARSTAR tok -> token tok
  | `Op_LTLT tok -> token tok
  | `Op_GTGT tok -> token tok
  | `Op_TILDE tok -> token tok
  | `Op_PLUSAT tok -> token tok
  | `Op_DASHAT tok -> token tok
  | `Op_LBRACKRBRACK tok -> token tok
  | `Op_LBRACKRBRACKEQ tok -> token tok
  | `Op_BQUOT tok -> token tok
  )

let true_ (x : CST.true_) =
  (match x with
  | `True_true tok -> token tok
  | `True_TRUE tok -> token tok
  )

let string_start (tok : CST.string_start) =
  token tok

let identifier_hash_key (tok : CST.identifier_hash_key) =
  token tok

let terminator (x : CST.terminator) =
  (match x with
  | `Term_line_brk tok -> token tok
  | `Term_SEMI tok -> token tok
  )

let variable (x : CST.variable) =
  (match x with
  | `Self tok -> token tok
  | `Super tok -> token tok
  | `Inst_var tok -> token tok
  | `Class_var tok -> token tok
  | `Glob_var tok -> token tok
  | `Id tok -> token tok
  | `Cst tok -> token tok
  )

let do_ (x : CST.do_) =
  (match x with
  | `Do_do tok -> token tok
  | `Do_term x -> terminator x
  )

let rec statements (x : CST.statements) =
  (match x with
  | `Stmts_rep1_choice_stmt_term_opt_stmt (v1, v2) ->
      let v1 =
        List.map (fun x ->
          (match x with
          | `Stmt_term (v1, v2) ->
              let v1 = statement v1 in
              let v2 = terminator v2 in
              todo (v1, v2)
          | `Empty_stmt tok -> token tok
          )
        ) v1
      in
      let v2 =
        (match v2 with
        | Some x -> statement x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Stmts_stmt x -> statement x
  )

and statement (x : CST.statement) =
  (match x with
  | `Stmt_undef (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 = method_name v2 in
      let v3 =
        List.map (fun (v1, v2) ->
          let v1 = token v1 in
          let v2 = method_name v2 in
          todo (v1, v2)
        ) v3
      in
      todo (v1, v2, v3)
  | `Stmt_alias (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 = method_name v2 in
      let v3 = method_name v3 in
      todo (v1, v2, v3)
  | `Stmt_if_modi (v1, v2, v3) ->
      let v1 = statement v1 in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Stmt_unle_modi (v1, v2, v3) ->
      let v1 = statement v1 in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Stmt_while_modi (v1, v2, v3) ->
      let v1 = statement v1 in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Stmt_until_modi (v1, v2, v3) ->
      let v1 = statement v1 in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Stmt_resc_modi (v1, v2, v3) ->
      let v1 = statement v1 in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Stmt_begin_blk (v1, v2, v3, v4) ->
      let v1 = token v1 in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | Some x -> statements x
        | None -> todo ())
      in
      let v4 = token v4 in
      todo (v1, v2, v3, v4)
  | `Stmt_end_blk (v1, v2, v3, v4) ->
      let v1 = token v1 in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | Some x -> statements x
        | None -> todo ())
      in
      let v4 = token v4 in
      todo (v1, v2, v3, v4)
  | `Stmt_exp x -> expression x
  )

and method_rest ((v1, v2, v3) : CST.method_rest) =
  let v1 = method_name v1 in
  let v2 =
    (match v2 with
    | `Params_opt_term (v1, v2) ->
        let v1 = parameters v1 in
        let v2 =
          (match v2 with
          | Some x -> terminator x
          | None -> todo ())
        in
        todo (v1, v2)
    | `Opt_bare_params_term (v1, v2) ->
        let v1 =
          (match v1 with
          | Some x -> bare_parameters x
          | None -> todo ())
        in
        let v2 = terminator v2 in
        todo (v1, v2)
    )
  in
  let v3 = body_statement v3 in
  todo (v1, v2, v3)

and parameters ((v1, v2, v3) : CST.parameters) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) ->
        let v1 = formal_parameter v1 in
        let v2 =
          List.map (fun (v1, v2) ->
            let v1 = token v1 in
            let v2 = formal_parameter v2 in
            todo (v1, v2)
          ) v2
        in
        todo (v1, v2)
    | None -> todo ())
  in
  let v3 = token v3 in
  todo (v1, v2, v3)

and bare_parameters ((v1, v2) : CST.bare_parameters) =
  let v1 = simple_formal_parameter v1 in
  let v2 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 = formal_parameter v2 in
      todo (v1, v2)
    ) v2
  in
  todo (v1, v2)

and block_parameters ((v1, v2, v3, v4, v5) : CST.block_parameters) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) ->
        let v1 = formal_parameter v1 in
        let v2 =
          List.map (fun (v1, v2) ->
            let v1 = token v1 in
            let v2 = formal_parameter v2 in
            todo (v1, v2)
          ) v2
        in
        todo (v1, v2)
    | None -> todo ())
  in
  let v3 =
    (match v3 with
    | Some tok -> token tok
    | None -> todo ())
  in
  let v4 =
    (match v4 with
    | Some (v1, v2, v3) ->
        let v1 = token v1 in
        let v2 = token v2 in
        let v3 =
          List.map (fun (v1, v2) ->
            let v1 = token v1 in
            let v2 = token v2 in
            todo (v1, v2)
          ) v3
        in
        todo (v1, v2, v3)
    | None -> todo ())
  in
  let v5 = token v5 in
  todo (v1, v2, v3, v4, v5)

and formal_parameter (x : CST.formal_parameter) =
  (match x with
  | `Form_param_simple_form_param x ->
      simple_formal_parameter x
  | `Form_param_params x -> parameters x
  )

and simple_formal_parameter (x : CST.simple_formal_parameter) =
  (match x with
  | `Simple_form_param_id tok -> token tok
  | `Simple_form_param_splat_param (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some tok -> token tok
        | None -> todo ())
      in
      todo (v1, v2)
  | `Simple_form_param_hash_splat_param (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some tok -> token tok
        | None -> todo ())
      in
      todo (v1, v2)
  | `Simple_form_param_blk_param (v1, v2) ->
      let v1 = token v1 in
      let v2 = token v2 in
      todo (v1, v2)
  | `Simple_form_param_kw_param (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | Some x -> arg x
        | None -> todo ())
      in
      todo (v1, v2, v3)
  | `Simple_form_param_opt_param (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  )

and superclass ((v1, v2) : CST.superclass) =
  let v1 = token v1 in
  let v2 = arg v2 in
  todo (v1, v2)

and in_ ((v1, v2) : CST.in_) =
  let v1 = token v1 in
  let v2 = arg v2 in
  todo (v1, v2)

and when_ ((v1, v2, v3, v4) : CST.when_) =
  let v1 = token v1 in
  let v2 = pattern v2 in
  let v3 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 = pattern v2 in
      todo (v1, v2)
    ) v3
  in
  let v4 =
    (match v4 with
    | `Term x -> terminator x
    | `Then x -> then_ x
    )
  in
  todo (v1, v2, v3, v4)

and pattern (x : CST.pattern) =
  (match x with
  | `Pat_arg x -> arg x
  | `Pat_splat_arg x -> splat_argument x
  )

and elsif ((v1, v2, v3, v4) : CST.elsif) =
  let v1 = token v1 in
  let v2 = statement v2 in
  let v3 =
    (match v3 with
    | `Term x -> terminator x
    | `Then x -> then_ x
    )
  in
  let v4 =
    (match v4 with
    | Some x ->
        (match x with
        | `Else x -> else_ x
        | `Elsif x -> elsif x
        )
    | None -> todo ())
  in
  todo (v1, v2, v3, v4)

and else_ ((v1, v2, v3) : CST.else_) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> terminator x
    | None -> todo ())
  in
  let v3 =
    (match v3 with
    | Some x -> statements x
    | None -> todo ())
  in
  todo (v1, v2, v3)

and then_ (x : CST.then_) =
  (match x with
  | `Then_term_stmts (v1, v2) ->
      let v1 = terminator v1 in
      let v2 = statements v2 in
      todo (v1, v2)
  | `Then_opt_term_then_opt_stmts (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | Some x -> terminator x
        | None -> todo ())
      in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | Some x -> statements x
        | None -> todo ())
      in
      todo (v1, v2, v3)
  )

and ensure ((v1, v2) : CST.ensure) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> statements x
    | None -> todo ())
  in
  todo (v1, v2)

and rescue ((v1, v2, v3, v4) : CST.rescue) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> exceptions x
    | None -> todo ())
  in
  let v3 =
    (match v3 with
    | Some x -> exception_variable x
    | None -> todo ())
  in
  let v4 =
    (match v4 with
    | `Term x -> terminator x
    | `Then x -> then_ x
    )
  in
  todo (v1, v2, v3, v4)

and exceptions ((v1, v2) : CST.exceptions) =
  let v1 =
    (match v1 with
    | `Arg x -> arg x
    | `Splat_arg x -> splat_argument x
    )
  in
  let v2 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Arg x -> arg x
        | `Splat_arg x -> splat_argument x
        )
      in
      todo (v1, v2)
    ) v2
  in
  todo (v1, v2)

and exception_variable ((v1, v2) : CST.exception_variable) =
  let v1 = token v1 in
  let v2 = lhs v2 in
  todo (v1, v2)

and body_statement ((v1, v2, v3) : CST.body_statement) =
  let v1 =
    (match v1 with
    | Some x -> statements x
    | None -> todo ())
  in
  let v2 =
    List.map (fun x ->
      (match x with
      | `Resc x -> rescue x
      | `Else x -> else_ x
      | `Ensu x -> ensure x
      )
    ) v2
  in
  let v3 = token v3 in
  todo (v1, v2, v3)

and expression (x : CST.expression) =
  (match x with
  | `Exp_cmd_bin (v1, v2, v3) ->
      let v1 = expression v1 in
      let v2 =
        (match v2 with
        | `Or tok -> token tok
        | `And tok -> token tok
        )
      in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Exp_cmd_assign x -> command_assignment x
  | `Exp_cmd_op_assign (v1, v2, v3) ->
      let v1 = lhs v1 in
      let v2 =
        (match v2 with
        | `PLUSEQ tok -> token tok
        | `DASHEQ tok -> token tok
        | `STAREQ tok -> token tok
        | `STARSTAREQ tok -> token tok
        | `SLASHEQ tok -> token tok
        | `BARBAREQ tok -> token tok
        | `BAREQ tok -> token tok
        | `AMPAMPEQ tok -> token tok
        | `AMPEQ tok -> token tok
        | `PERCEQ tok -> token tok
        | `GTGTEQ tok -> token tok
        | `LTLTEQ tok -> token tok
        | `HATEQ tok -> token tok
        )
      in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  | `Exp_cmd_call x -> command_call x
  | `Exp_ret_cmd (v1, v2) ->
      let v1 = token v1 in
      let v2 = command_argument_list v2 in
      todo (v1, v2)
  | `Exp_yield_cmd (v1, v2) ->
      let v1 = token v1 in
      let v2 = command_argument_list v2 in
      todo (v1, v2)
  | `Exp_brk_cmd (v1, v2) ->
      let v1 = token v1 in
      let v2 = command_argument_list v2 in
      todo (v1, v2)
  | `Exp_next_cmd (v1, v2) ->
      let v1 = token v1 in
      let v2 = command_argument_list v2 in
      todo (v1, v2)
  | `Exp_arg x -> arg x
  )

and arg (x : CST.arg) =
  (match x with
  | `Arg_prim x -> primary x
  | `Arg_assign x -> assignment x
  | `Arg_op_assign (v1, v2, v3) ->
      let v1 = lhs v1 in
      let v2 =
        (match v2 with
        | `PLUSEQ tok -> token tok
        | `DASHEQ tok -> token tok
        | `STAREQ tok -> token tok
        | `STARSTAREQ tok -> token tok
        | `SLASHEQ tok -> token tok
        | `BARBAREQ tok -> token tok
        | `BAREQ tok -> token tok
        | `AMPAMPEQ tok -> token tok
        | `AMPEQ tok -> token tok
        | `PERCEQ tok -> token tok
        | `GTGTEQ tok -> token tok
        | `LTLTEQ tok -> token tok
        | `HATEQ tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Arg_cond (v1, v2, v3, v4, v5) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      let v4 = token v4 in
      let v5 = arg v5 in
      todo (v1, v2, v3, v4, v5)
  | `Arg_range (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `DOTDOT tok -> token tok
        | `DOTDOTDOT tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Arg_bin x -> binary x
  | `Arg_un x -> unary x
  )

and primary (x : CST.primary) =
  (match x with
  | `Prim_paren_stmts x -> parenthesized_statements x
  | `Prim_lhs x -> lhs x
  | `Prim_array (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list_with_trailing_comma x
        | None -> todo ())
      in
      let v3 = token v3 in
      todo (v1, v2, v3)
  | `Prim_str_array (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some () -> todo ()
        | None -> todo ())
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) ->
            let v1 = literal_contents v1 in
            let v2 =
              List.map (fun (v1, v2) ->
                let v1 = blank v1 in
                let v2 = literal_contents v2 in
                todo (v1, v2)
              ) v2
            in
            todo (v1, v2)
        | None -> todo ())
      in
      let v4 =
        (match v4 with
        | Some () -> todo ()
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_symb_array (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some () -> todo ()
        | None -> todo ())
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) ->
            let v1 = literal_contents v1 in
            let v2 =
              List.map (fun (v1, v2) ->
                let v1 = blank v1 in
                let v2 = literal_contents v2 in
                todo (v1, v2)
              ) v2
            in
            todo (v1, v2)
        | None -> todo ())
      in
      let v4 =
        (match v4 with
        | Some () -> todo ()
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_hash (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2, v3) ->
            let v1 =
              (match v1 with
              | `Pair x -> pair x
              | `Hash_splat_arg x -> hash_splat_argument x
              )
            in
            let v2 =
              List.map (fun (v1, v2) ->
                let v1 = token v1 in
                let v2 =
                  (match v2 with
                  | `Pair x -> pair x
                  | `Hash_splat_arg x -> hash_splat_argument x
                  )
                in
                todo (v1, v2)
              ) v2
            in
            let v3 =
              (match v3 with
              | Some tok -> token tok
              | None -> todo ())
            in
            todo (v1, v2, v3)
        | None -> todo ())
      in
      let v3 = token v3 in
      todo (v1, v2, v3)
  | `Prim_subs (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> literal_contents x
        | None -> todo ())
      in
      let v3 = token v3 in
      todo (v1, v2, v3)
  | `Prim_symb x -> symbol x
  | `Prim_int tok -> token tok
  | `Prim_float tok -> token tok
  | `Prim_comp tok -> token tok
  | `Prim_rati (v1, v2) ->
      let v1 = token v1 in
      let v2 = token v2 in
      todo (v1, v2)
  | `Prim_str x -> string_ x
  | `Prim_char tok -> token tok
  | `Prim_chai_str (v1, v2) ->
      let v1 = string_ v1 in
      let v2 = List.map string_ v2 in
      todo (v1, v2)
  | `Prim_regex (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> literal_contents x
        | None -> todo ())
      in
      let v3 = token v3 in
      todo (v1, v2, v3)
  | `Prim_lamb (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x ->
            (match x with
            | `Params x -> parameters x
            | `Bare_params x -> bare_parameters x
            )
        | None -> todo ())
      in
      let v3 =
        (match v3 with
        | `Blk x -> block x
        | `Do_blk x -> do_block x
        )
      in
      todo (v1, v2, v3)
  | `Prim_meth (v1, v2) ->
      let v1 = token v1 in
      let v2 = method_rest v2 in
      todo (v1, v2)
  | `Prim_sing_meth (v1, v2, v3, v4) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Var x -> variable x
        | `LPAR_arg_RPAR (v1, v2, v3) ->
            let v1 = token v1 in
            let v2 = arg v2 in
            let v3 = token v3 in
            todo (v1, v2, v3)
        )
      in
      let v3 =
        (match v3 with
        | `DOT tok -> token tok
        | `COLONCOLON tok -> token tok
        )
      in
      let v4 = method_rest v4 in
      todo (v1, v2, v3, v4)
  | `Prim_class (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Cst tok -> token tok
        | `Scope_resol x -> scope_resolution x
        )
      in
      let v3 =
        (match v3 with
        | Some x -> superclass x
        | None -> todo ())
      in
      let v4 = terminator v4 in
      let v5 = body_statement v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_sing_class (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      let v4 = terminator v4 in
      let v5 = body_statement v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_modu (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Cst tok -> token tok
        | `Scope_resol x -> scope_resolution x
        )
      in
      let v3 =
        (match v3 with
        | `Term_body_stmt (v1, v2) ->
            let v1 = terminator v1 in
            let v2 = body_statement v2 in
            todo (v1, v2)
        | `End tok -> token tok
        )
      in
      todo (v1, v2, v3)
  | `Prim_begin (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> terminator x
        | None -> todo ())
      in
      let v3 = body_statement v3 in
      todo (v1, v2, v3)
  | `Prim_while (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 = arg v2 in
      let v3 = do_ v3 in
      let v4 =
        (match v4 with
        | Some x -> statements x
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_until (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 = arg v2 in
      let v3 = do_ v3 in
      let v4 =
        (match v4 with
        | Some x -> statements x
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_if (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 = statement v2 in
      let v3 =
        (match v3 with
        | `Term x -> terminator x
        | `Then x -> then_ x
        )
      in
      let v4 =
        (match v4 with
        | Some x ->
            (match x with
            | `Else x -> else_ x
            | `Elsif x -> elsif x
            )
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_unle (v1, v2, v3, v4, v5) ->
      let v1 = token v1 in
      let v2 = statement v2 in
      let v3 =
        (match v3 with
        | `Term x -> terminator x
        | `Then x -> then_ x
        )
      in
      let v4 =
        (match v4 with
        | Some x ->
            (match x with
            | `Else x -> else_ x
            | `Elsif x -> elsif x
            )
        | None -> todo ())
      in
      let v5 = token v5 in
      todo (v1, v2, v3, v4, v5)
  | `Prim_for (v1, v2, v3, v4, v5, v6) ->
      let v1 = token v1 in
      let v2 = mlhs v2 in
      let v3 = in_ v3 in
      let v4 = do_ v4 in
      let v5 =
        (match v5 with
        | Some x -> statements x
        | None -> todo ())
      in
      let v6 = token v6 in
      todo (v1, v2, v3, v4, v5, v6)
  | `Prim_case (v1, v2, v3, v4, v5, v6, v7) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> arg x
        | None -> todo ())
      in
      let v3 = terminator v3 in
      let v4 = List.map token v4 in
      let v5 = List.map when_ v5 in
      let v6 =
        (match v6 with
        | Some x -> else_ x
        | None -> todo ())
      in
      let v7 = token v7 in
      todo (v1, v2, v3, v4, v5, v6, v7)
  | `Prim_ret (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_yield (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_brk (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_next (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_redo (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_retry (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> argument_list x
        | None -> todo ())
      in
      todo (v1, v2)
  | `Prim_paren_un (v1, v2) ->
      let v1 =
        (match v1 with
        | `Defi tok -> token tok
        | `Not tok -> token tok
        )
      in
      let v2 = parenthesized_statements v2 in
      todo (v1, v2)
  | `Prim_un_lit (v1, v2) ->
      let v1 =
        (match v1 with
        | `Un_minus tok -> token tok
        | `PLUS tok -> token tok
        )
      in
      let v2 =
        (match v2 with
        | `Int tok -> token tok
        | `Float tok -> token tok
        )
      in
      todo (v1, v2)
  | `Prim_here_begin tok -> token tok
  )

and parenthesized_statements ((v1, v2, v3) : CST.parenthesized_statements) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> statements x
    | None -> todo ())
  in
  let v3 = token v3 in
  todo (v1, v2, v3)

and scope_resolution ((v1, v2) : CST.scope_resolution) =
  let v1 =
    (match v1 with
    | `COLONCOLON tok -> token tok
    | `Prim_COLONCOLON (v1, v2) ->
        let v1 = primary v1 in
        let v2 = token v2 in
        todo (v1, v2)
    )
  in
  let v2 =
    (match v2 with
    | `Id tok -> token tok
    | `Cst tok -> token tok
    )
  in
  todo (v1, v2)

and call ((v1, v2, v3) : CST.call) =
  let v1 = primary v1 in
  let v2 =
    (match v2 with
    | `DOT tok -> token tok
    | `AMPDOT tok -> token tok
    )
  in
  let v3 =
    (match v3 with
    | `Id tok -> token tok
    | `Op x -> operator x
    | `Cst tok -> token tok
    | `Arg_list x -> argument_list x
    )
  in
  todo (v1, v2, v3)

and command_call (x : CST.command_call) =
  (match x with
  | `Cmd_call_choice_var_cmd_arg_list (v1, v2) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = command_argument_list v2 in
      todo (v1, v2)
  | `Cmd_call_choice_var_cmd_arg_list_blk (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = command_argument_list v2 in
      let v3 = block v3 in
      todo (v1, v2, v3)
  | `Cmd_call_choice_var_cmd_arg_list_do_blk (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = command_argument_list v2 in
      let v3 = do_block v3 in
      todo (v1, v2, v3)
  )

and method_call (x : CST.method_call) =
  (match x with
  | `Meth_call_choice_var_arg_list (v1, v2) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = argument_list v2 in
      todo (v1, v2)
  | `Meth_call_choice_var_arg_list_blk (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = argument_list v2 in
      let v3 = block v3 in
      todo (v1, v2, v3)
  | `Meth_call_choice_var_arg_list_do_blk (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = argument_list v2 in
      let v3 = do_block v3 in
      todo (v1, v2, v3)
  | `Meth_call_choice_var_blk (v1, v2) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = block v2 in
      todo (v1, v2)
  | `Meth_call_choice_var_do_blk (v1, v2) ->
      let v1 =
        (match v1 with
        | `Var x -> variable x
        | `Scope_resol x -> scope_resolution x
        | `Call x -> call x
        )
      in
      let v2 = do_block v2 in
      todo (v1, v2)
  )

and command_argument_list (x : CST.command_argument_list) =
  (match x with
  | `Cmd_arg_list_arg_rep_COMMA_arg (v1, v2) ->
      let v1 = argument v1 in
      let v2 =
        List.map (fun (v1, v2) ->
          let v1 = token v1 in
          let v2 = argument v2 in
          todo (v1, v2)
        ) v2
      in
      todo (v1, v2)
  | `Cmd_arg_list_cmd_call x -> command_call x
  )

and argument_list ((v1, v2, v3) : CST.argument_list) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> argument_list_with_trailing_comma x
    | None -> todo ())
  in
  let v3 = token v3 in
  todo (v1, v2, v3)

and argument_list_with_trailing_comma ((v1, v2, v3) : CST.argument_list_with_trailing_comma) =
  let v1 = argument v1 in
  let v2 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 = argument v2 in
      todo (v1, v2)
    ) v2
  in
  let v3 =
    (match v3 with
    | Some tok -> token tok
    | None -> todo ())
  in
  todo (v1, v2, v3)

and argument (x : CST.argument) =
  (match x with
  | `Arg_arg x -> arg x
  | `Arg_splat_arg x -> splat_argument x
  | `Arg_hash_splat_arg x -> hash_splat_argument x
  | `Arg_blk_arg (v1, v2) ->
      let v1 = token v1 in
      let v2 = arg v2 in
      todo (v1, v2)
  | `Arg_pair x -> pair x
  )

and splat_argument ((v1, v2) : CST.splat_argument) =
  let v1 = token v1 in
  let v2 = arg v2 in
  todo (v1, v2)

and hash_splat_argument ((v1, v2) : CST.hash_splat_argument) =
  let v1 = token v1 in
  let v2 = arg v2 in
  todo (v1, v2)

and do_block ((v1, v2, v3, v4) : CST.do_block) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> terminator x
    | None -> todo ())
  in
  let v3 =
    (match v3 with
    | Some (v1, v2) ->
        let v1 = block_parameters v1 in
        let v2 =
          (match v2 with
          | Some x -> terminator x
          | None -> todo ())
        in
        todo (v1, v2)
    | None -> todo ())
  in
  let v4 = body_statement v4 in
  todo (v1, v2, v3, v4)

and block ((v1, v2, v3, v4) : CST.block) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> block_parameters x
    | None -> todo ())
  in
  let v3 =
    (match v3 with
    | Some x -> statements x
    | None -> todo ())
  in
  let v4 = token v4 in
  todo (v1, v2, v3, v4)

and assignment (x : CST.assignment) =
  (match x with
  | `Choice_lhs_EQ_choice_arg (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Lhs x -> lhs x
        | `Left_assign_list x -> left_assignment_list x
        )
      in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | `Arg x -> arg x
        | `Splat_arg x -> splat_argument x
        | `Right_assign_list x -> right_assignment_list x
        )
      in
      todo (v1, v2, v3)
  )

and command_assignment (x : CST.command_assignment) =
  (match x with
  | `Choice_lhs_EQ_exp (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Lhs x -> lhs x
        | `Left_assign_list x -> left_assignment_list x
        )
      in
      let v2 = token v2 in
      let v3 = expression v3 in
      todo (v1, v2, v3)
  )

and binary (x : CST.binary) =
  (match x with
  | `Bin_arg_and_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_or_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_BARBAR_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_AMPAMP_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_LTLT_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `LTLT tok -> token tok
        | `GTGT tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_LT_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `LT tok -> token tok
        | `LTEQ tok -> token tok
        | `GT tok -> token tok
        | `GTEQ tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_AMP_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_HAT_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `HAT tok -> token tok
        | `BAR tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_PLUS_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `PLUS tok -> token tok
        | `Bin_minus tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_SLASH_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `SLASH tok -> token tok
        | `PERC tok -> token tok
        | `Bin_star tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_choice_EQEQ_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 =
        (match v2 with
        | `EQEQ tok -> token tok
        | `BANGEQ tok -> token tok
        | `EQEQEQ tok -> token tok
        | `LTEQGT tok -> token tok
        | `EQTILDE tok -> token tok
        | `BANGTILDE tok -> token tok
        )
      in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Bin_arg_STARSTAR_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  )

and unary (x : CST.unary) =
  (match x with
  | `Un_defi_arg (v1, v2) ->
      let v1 = token v1 in
      let v2 = arg v2 in
      todo (v1, v2)
  | `Un_not_arg (v1, v2) ->
      let v1 = token v1 in
      let v2 = arg v2 in
      todo (v1, v2)
  | `Un_choice_un_minus_arg (v1, v2) ->
      let v1 =
        (match v1 with
        | `Un_minus tok -> token tok
        | `PLUS tok -> token tok
        )
      in
      let v2 = arg v2 in
      todo (v1, v2)
  | `Un_choice_BANG_arg (v1, v2) ->
      let v1 =
        (match v1 with
        | `BANG tok -> token tok
        | `TILDE tok -> token tok
        )
      in
      let v2 = arg v2 in
      todo (v1, v2)
  )

and right_assignment_list ((v1, v2) : CST.right_assignment_list) =
  let v1 =
    (match v1 with
    | `Arg x -> arg x
    | `Splat_arg x -> splat_argument x
    )
  in
  let v2 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Arg x -> arg x
        | `Splat_arg x -> splat_argument x
        )
      in
      todo (v1, v2)
    ) v2
  in
  todo (v1, v2)

and left_assignment_list (x : CST.left_assignment_list) =
  mlhs x

and mlhs ((v1, v2, v3) : CST.mlhs) =
  let v1 =
    (match v1 with
    | `Lhs x -> lhs x
    | `Rest_assign x -> rest_assignment x
    | `Dest_left_assign x -> destructured_left_assignment x
    )
  in
  let v2 =
    List.map (fun (v1, v2) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | `Lhs x -> lhs x
        | `Rest_assign x -> rest_assignment x
        | `Dest_left_assign x -> destructured_left_assignment x
        )
      in
      todo (v1, v2)
    ) v2
  in
  let v3 =
    (match v3 with
    | Some tok -> token tok
    | None -> todo ())
  in
  todo (v1, v2, v3)

and destructured_left_assignment ((v1, v2, v3) : CST.destructured_left_assignment) =
  let v1 = token v1 in
  let v2 = mlhs v2 in
  let v3 = token v3 in
  todo (v1, v2, v3)

and rest_assignment ((v1, v2) : CST.rest_assignment) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> lhs x
    | None -> todo ())
  in
  todo (v1, v2)

and lhs (x : CST.lhs) =
  (match x with
  | `Var x -> variable x
  | `True x -> true_ x
  | `False x -> false_ x
  | `Nil x -> nil x
  | `Scope_resol x -> scope_resolution x
  | `Elem_ref (v1, v2, v3, v4) ->
      let v1 = primary v1 in
      let v2 = token v2 in
      let v3 =
        (match v3 with
        | Some x -> argument_list_with_trailing_comma x
        | None -> todo ())
      in
      let v4 = token v4 in
      todo (v1, v2, v3, v4)
  | `Call x -> call x
  | `Meth_call x -> method_call x
  )

and method_name (x : CST.method_name) =
  (match x with
  | `Meth_name_id tok -> token tok
  | `Meth_name_cst tok -> token tok
  | `Meth_name_sett (v1, v2) ->
      let v1 = token v1 in
      let v2 = token v2 in
      todo (v1, v2)
  | `Meth_name_symb x -> symbol x
  | `Meth_name_op x -> operator x
  | `Meth_name_inst_var tok -> token tok
  | `Meth_name_class_var tok -> token tok
  | `Meth_name_glob_var tok -> token tok
  )

and interpolation ((v1, v2, v3) : CST.interpolation) =
  let v1 = token v1 in
  let v2 = statement v2 in
  let v3 = token v3 in
  todo (v1, v2, v3)

and string_ ((v1, v2, v3) : CST.string_) =
  let v1 = token v1 in
  let v2 =
    (match v2 with
    | Some x -> literal_contents x
    | None -> todo ())
  in
  let v3 = token v3 in
  todo (v1, v2, v3)

and symbol (x : CST.symbol) =
  (match x with
  | `Symb_simple_symb tok -> token tok
  | `Symb_symb_start_opt_lit_content_str_end (v1, v2, v3) ->
      let v1 = token v1 in
      let v2 =
        (match v2 with
        | Some x -> literal_contents x
        | None -> todo ())
      in
      let v3 = token v3 in
      todo (v1, v2, v3)
  )

and literal_contents (xs : CST.literal_contents) =
  List.map (fun x ->
    (match x with
    | `Str_content tok -> token tok
    | `Interp x -> interpolation x
    | `Esc_seq tok -> token tok
    )
  ) xs

and pair (x : CST.pair) =
  (match x with
  | `Pair_arg_EQGT_arg (v1, v2, v3) ->
      let v1 = arg v1 in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  | `Pair_choice_id_hash_key_COLON_arg (v1, v2, v3) ->
      let v1 =
        (match v1 with
        | `Id_hash_key tok -> token tok
        | `Id tok -> token tok
        | `Cst tok -> token tok
        | `Str x -> string_ x
        )
      in
      let v2 = token v2 in
      let v3 = arg v3 in
      todo (v1, v2, v3)
  )

let program ((v1, v2) : CST.program) =
  let v1 =
    (match v1 with
    | Some x -> statements x
    | None -> todo ())
  in
  let v2 =
    (match v2 with
    | Some (v1, v2, v3) ->
        let v1 = token v1 in
        let v2 = token v2 in
        let v3 = token v3 in
        todo (v1, v2, v3)
    | None -> todo ())
  in
  todo (v1, v2)


(*****************************************************************************)
(* Entry point *)
(*****************************************************************************)
let parse file =
  (* TODO: tree-sitter bindings are buggy so we cheat and fork to
   * avoid segfaults to popup. See Main.ml test_parse_ruby function.
   *)
   let cst_opt =
      if false
      then Tree_sitter_ruby.Parse.file file
      else begin
         Parallel.backtrace_when_exn := false;
         Parallel.invoke Tree_sitter_ruby.Parse.file file ()
      end
   in
   match cst_opt with
   | None -> failwith (spf "No CST returned for %s" file)
   | Some x ->
      let sexp = CST.sexp_of_program x in
      let s = Sexplib.Sexp.to_string_hum sexp in
      pr s;
      program x