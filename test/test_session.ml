open OUnit2
open Arangodb.Session
open Arangodb.Auth

let create_test_session _ =
  let test_cred = Auth.username_and_password_from_env in
  let username = test_cred.username in
  let password = test_cred.password in
  Session.create_session username password

let test_create_session _ =
  let test_session = create_test_session () in
  match test_session with
  | { username; _ } ->
    OUnit2.assert_bool "username is empty" (username <> "")


let suite =
  "suite"
  >::: [
         "test_create_session" >:: test_create_session;
       ]

let () = run_test_tt_main suite
