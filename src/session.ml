open Auth
open Cohttp_client

module Session = struct
  type session =
    {
      username : string;
      password : string;
      host : string;
      auth : Auth.auth;
    }

  let token_header_from_session (s : session) : (string * string) =
    let token_header = "Bearer " ^ s.auth.token in
    ("Authorization", token_header)

  let create_session (username : string) (password : string) : session =
    let host = Auth.get_base_url_from_env in
    let host = Printf.sprintf "http://%s" host in
    let creds = Auth.create_basic_cred username password in
    let body = Auth.make_auth_token_request creds host in
    let session_auth = body |> Auth.convert_body_to_json |> Auth.parse_auth in
    { username; password; host; auth=session_auth }

  let get_new_session (s : session) : session =
    create_session s.username s.password

  let get_session_request (s : session) : string =
    let host = Auth.get_base_url_from_env in
    let get_session_url = Printf.sprintf "http://%s/_admin/server/jwt" host in
    Printf.printf "host from get_session_request: %s\n" get_session_url;
    let token_header = token_header_from_session s in
    let application_json = Cohttp_client.application_json_setting_tuple in
    let headers = Cohttp_client.create_headers_from_pairs [application_json; token_header] in
    let session = Lwt_main.run (Cohttp_client.get_request_with_headers get_session_url headers) in
    session

  let refresh_session_auth (s : session) : session =
    if Auth.is_token_expired s.auth then
      let username = s.username in
      let password = s.password in
      let host = s.host in
      let sesh =
        try
          let creds = Auth.create_basic_cred username password in
          let body = Auth.make_auth_token_refresh creds host in
          let session_auth = body |> Auth.convert_body_to_json |> Auth.parse_auth in
          { username; password; host; auth=session_auth }
        with _ -> get_new_session s
      in
      sesh
    else
      s




end
