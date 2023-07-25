open OUnit2
open Arangodb.Cohttp_client
open Arangodb.Auth

let sample_basic_cred_defaults : Auth.basic_cred = {
   username = "root";
   password = "";
  }

let sample_basic_cred : Auth.basic_cred = {
   username = "arangodb";
   password = "julyjackson";
  }

let sample_auth_without_jti : Auth.auth = {
    exp = 1686612561;
    iat = 1686611561;
    scope = "read write delete";
    did = "123";
    jti = None;
    token = "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE";
    refresh_token = None;
  }

let sample_auth_with_jti : Auth.auth = {
    exp = 1686612561;
    iat = 1686611561;
    scope = "read write delete";
    did = "321";
    jti = Some "jti";
    token = "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE";
    refresh_token = Some "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6ImNvbS5hdHByb3RvLnJlZnJlc2giLCJzdWIiOiJkaWQ6cGxjOnhvdjN1dnhmZDR0bzZldjNhazVnNXV4ayIsImp0aSI6InM0Z2JDcWRXRlVhQ1lJQk4xdk93V2xBS01LR3ZkSnlla1V3TjJKL1paUDQiLCJpYXQiOjE2ODcyODgzMjIsImV4cCI6MTY5NTA2NDMyMn0.2wdx89mPzrwVyFHhVOpHw6iIooFCE3k6a4qvvBNwcCE";
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

let test_sample_auth_with_jti_exp _ =
    match sample_auth_with_jti with
     | { exp; _ } ->
        OUnit2.assert_equal 1686612561 exp

let test_sample_auth_with_jti_iat _ =
    match sample_auth_with_jti with
     | { iat; _ } ->
        OUnit2.assert_equal 1686611561 iat

let test_sample_auth_with_jti_scope _ =
    match sample_auth_with_jti with
     | { scope; _ } ->
        OUnit2.assert_equal "read write delete" scope

let test_sample_auth_with_jti_did _ =
    match sample_auth_with_jti with
     | { did; _ } ->
        OUnit2.assert_equal "321" did

let test_sample_auth_with_jti_jti _ =
    match sample_auth_with_jti with
     | { jti; _ } ->
      match jti with
       | Some j ->
         OUnit2.assert_equal "jti" j
       | _ ->
         OUnit2.assert_equal 0 1

let test_sample_auth_with_jti_token _ =
    match sample_auth_with_jti with
     | { token; _ } ->
        OUnit2.assert_equal "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE" token

let test_sample_auth_with_jti_refresh_token _ =
    match sample_auth_with_jti with
     | { refresh_token; _ } ->
      match refresh_token with
      | Some refresh_token -> OUnit2.assert_equal "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6ImNvbS5hdHByb3RvLnJlZnJlc2giLCJzdWIiOiJkaWQ6cGxjOnhvdjN1dnhmZDR0bzZldjNhazVnNXV4ayIsImp0aSI6InM0Z2JDcWRXRlVhQ1lJQk4xdk93V2xBS01LR3ZkSnlla1V3TjJKL1paUDQiLCJpYXQiOjE2ODcyODgzMjIsImV4cCI6MTY5NTA2NDMyMn0.2wdx89mPzrwVyFHhVOpHw6iIooFCE3k6a4qvvBNwcCE" refresh_token
      | _ -> OUnit2.assert_equal 0 1

let test_sample_auth_without_jti_exp _ =
    match sample_auth_without_jti with
     | { exp; _ } ->
        OUnit2.assert_equal 1686612561 exp

let test_sample_auth_without_jti_iat _ =
    match sample_auth_without_jti with
     | { iat; _ } ->
        OUnit2.assert_equal 1686611561 iat

let test_sample_auth_without_jti_scope _ =
    match sample_auth_without_jti with
     | { scope; _ } ->
        OUnit2.assert_equal "read write delete" scope

let test_sample_auth_without_jti_did _ =
    match sample_auth_without_jti with
     | { did; _ } ->
        OUnit2.assert_equal "123" did

let test_sample_auth_without_jti_jti _ =
    match sample_auth_without_jti with
     | { jti; _ } ->
      match jti with
       | Some _ ->
         OUnit2.assert_equal 0 1
       | _ ->
         OUnit2.assert_equal 1 1

let test_sample_auth_without_jti_token _ =
    match sample_auth_without_jti with
    | { token; _ } ->
        OUnit2.assert_equal "eyJCI6MTY4NzAyNjg0MCwiZXhwIjoxNjg3MDM0MDQwfQ.ZQem8wFw4HdYbbAnHpSvcwB3ue9HHK37K4QJ4QOzhKE" token

let test_sample_auth_without_jti_refresh_token _ =
    match sample_auth_without_jti with
     | { refresh_token; _ } ->
      match refresh_token with
       | Some _ ->
         OUnit2.assert_equal 0 1
       | _ ->
         OUnit2.assert_equal 1 1

let test_get_base_url_from_env _ =
    let base_url = Auth.get_base_url_from_env in
    Printf.printf "Base Url: %s\n" base_url;
    OUnit2.assert_equal "localhost:5001" base_url

let split_host_post base_url =
  match String.split_on_char ':' base_url with
  | [ host; port ] -> (host, int_of_string port)
  | _ -> failwith "Invalid format. expected host:port"


let test_ping_db _ =
  let base_url = Auth.get_base_url_from_env in
  let full_url = Printf.sprintf "https://%s" base_url in
  let ping_results = Lwt_main.run (Cohttp_client.get_body full_url) in
  Printf.printf "ping results: %s\n" ping_results;
  OUnit2.assert_bool "ping results is empty" (ping_results <> "")


let test_make_auth_token_request _ =
  let base_url = Auth.get_base_url_from_env in
  let full_url = Printf.sprintf "https://%s" base_url in
  let user_cred = Auth.username_and_password_from_env in
  let auth_body = Auth.make_auth_token_request user_cred full_url in
  Printf.printf "auth body post make_auth_token_request: %s\n" auth_body;
  OUnit2.assert_bool "auth_body is empty" (auth_body <> "")

let suite =
  "suite"
  >::: [
         "test_sample_auth_with_jti_exp" >:: test_sample_auth_with_jti_exp;
         "test_sample_auth_with_jti_iat" >:: test_sample_auth_with_jti_iat;
         "test_sample_auth_with_jti_scope" >:: test_sample_auth_with_jti_scope;
         "test_sample_auth_with_jti_did" >:: test_sample_auth_with_jti_did;
         "test_sample_auth_with_jti_jti" >:: test_sample_auth_with_jti_jti;
         "test_sample_auth_with_jti_refresh_token" >:: test_sample_auth_with_jti_refresh_token;
         "test_sample_auth_without_jti_exp" >:: test_sample_auth_without_jti_exp;
         "test_sample_auth_without_jti_iat" >:: test_sample_auth_without_jti_iat;
         "test_sample_auth_without_jti_scope" >:: test_sample_auth_without_jti_scope;
         "test_sample_auth_without_jti_did" >:: test_sample_auth_without_jti_did;
         "test_sample_auth_without_jti_jti" >:: test_sample_auth_without_jti_jti;
         "test_sample_auth_without_jti_refresh_token" >:: test_sample_auth_without_jti_refresh_token;
         "test_sample_basic_cred_defaults" >:: test_sample_basic_cred_defaults;
         "test_sample_basic_cred_username" >:: test_sample_basic_cred_username;
         "test_sample_basic_cred_password" >:: test_sample_basic_cred_password;
         "test_get_base_url_from_env" >:: test_get_base_url_from_env;
         "test_make_auth_token_request" >:: test_make_auth_token_request;
         "test_ping_db" >:: test_ping_db;
       ]

let () = run_test_tt_main suite
