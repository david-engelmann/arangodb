open OUnit2
open Arangodb.Auth

let sample_basic_cred_defaults : Auth.basic_cred = {
   username = "root";
   password = "";
  }

let sample_basic_cred : Auth.basic_cred = {
   username = "arangodb";
   password = "julyjackson";
  }

let sample_auth : Auth.auth = {
    exp = 1686612561;
    iat = 1686611561;
    iss = "arangodb";
    token = "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE";
    preferred_username = "root";
  }

let test_sample_basic_cred_defaults _ =
  match sample_basic_cred_defaults with
   | { username; _ } ->
      OUnit2.assert_equal "root" username

let test_sample_basic_cred_username _ =
  match sample_basic_cred with
   | { username; _ } ->
      OUnit2.assert_equal "arangodb" username

let test_sample_basic_cred_password _ =
  match sample_basic_cred with
   | { password; _ } ->
      OUnit2.assert_equal "julyjackson" password

let test_sample_auth_exp _ =
    match sample_auth with
     | { exp; _ } ->
        OUnit2.assert_equal 1686612561 exp

let test_sample_auth_iat _ =
    match sample_auth with
     | { iat; _ } ->
        OUnit2.assert_equal 1686611561 iat

let test_sample_auth_iss _ =
    match sample_auth with
     | { iss; _ } ->
        OUnit2.assert_equal "arangodb" iss

let test_sample_auth_preferred_username _ =
    match sample_auth with
     | { preferred_username; _ } ->
      OUnit2.assert_equal "root" preferred_username

let test_sample_auth_token _ =
    match sample_auth with
     | { token; _ } ->
        OUnit2.assert_equal "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE" token

let split_host_post base_url =
  match String.split_on_char ':' base_url with
  | [ host; port ] -> (host, int_of_string port)
  | _ -> failwith "Invalid format. expected host:port"

let test_make_auth_token_request _ =
  let base_url = Auth.get_base_url_from_env in
  let full_url = Printf.sprintf "http://%s" base_url in
  let user_cred = Auth.username_and_password_from_env in
  let auth_body = Auth.make_auth_token_request user_cred full_url in
  Printf.printf "auth body post make_auth_token_request: %s\n" auth_body;
  OUnit2.assert_bool "auth_body is empty" (auth_body <> "")

let suite =
  "suite"
  >::: [
         "test_sample_auth_exp" >:: test_sample_auth_exp;
         "test_sample_auth_iat" >:: test_sample_auth_iat;
         "test_sample_auth_token" >:: test_sample_auth_token;
         "test_sample_auth_iss" >:: test_sample_auth_iss;
         "test_sample_auth_preferred_username" >:: test_sample_auth_preferred_username;
         "test_sample_basic_cred_defaults" >:: test_sample_basic_cred_defaults;
         "test_sample_basic_cred_username" >:: test_sample_basic_cred_username;
         "test_sample_basic_cred_password" >:: test_sample_basic_cred_password;
         "test_make_auth_token_request" >:: test_make_auth_token_request;
       ]

let () = run_test_tt_main suite
