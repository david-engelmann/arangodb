open Auth

module Session = struct
  type session =
    {
      username : string;
      password : string;
      host : string;
      auth : Auth.auth;
    }

  let create_session (username : string) (password : string) : session =
    let host = Auth.get_base_url_from_env in
    let full_url = Printf.sprintf "http://%s" host in
    Printf.printf "host from create_session: %s\n" full_url;
    let creds = Auth.create_basic_cred username password in
    let body = Auth.make_auth_token_request creds full_url in
    let session_auth = body |> Auth.convert_body_to_json |> Auth.parse_auth in
    { username; password; host; auth=session_auth }
end
