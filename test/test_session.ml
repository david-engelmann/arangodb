open OUnit2
open Arangodb.Session
open Arangodb.Auth

let create_test_session _ =
  let test_cred = Auth.username_and_password_from_env in
  let username = test_cred.username in
  let password = test_cred.password in
  Session.create_session username password

let test_create_session _ =
  let test_session = create_test_session () |> Session.refresh_session_auth in
  match test_session with
  | { username; _ } ->
    OUnit2.assert_bool "username is empty" (username <> "")

let test_token_from_session _ =
  let test_session = create_test_session () |> Session.refresh_session_auth in
  let token = test_session.auth.token in
  OUnit2.assert_equal ~printer:string_of_bool true ((String.length token) > 0)

let test_token_header_from_session_param _ =
  let test_session = create_test_session () |> Session.refresh_session_auth in
  let token_header = Session.token_header_from_session test_session in
  match token_header with
  | (param, _) ->
    OUnit2.assert_bool "Token Header Parameter Name is empty" (param <> "")

let test_token_header_from_session_header _ =
  let open Core in
  let test_session = create_test_session () |> Session.refresh_session_auth in
  let token_header = Session.token_header_from_session test_session in
  match token_header with
  | (_, header) ->
    OUnit2.assert_bool "Token Header is doesn't contain Bearer" (String.is_substring header ~substring:"Bearer")

let test_get_session_request _ =
  let test_session = create_test_session () |> Session.refresh_session_auth in
  let test_session_response = Session.get_session_request test_session in
  Printf.printf "get_session_request response %s\n" test_session_response;
  OUnit2.assert_bool "Get Session Request Response is empty" (test_session_response <> "")

let suite =
  "suite"
  >::: [
         "test_create_session" >:: test_create_session;
         "test_token_from_session" >:: test_token_from_session;
         "test_token_header_from_session_header" >:: test_token_header_from_session_header;
         "test_get_session_request" >:: test_get_session_request;
       ]

let () = run_test_tt_main suite
