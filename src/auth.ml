open Cohttp_client
open Jose.Jwt

module Auth = struct
  type auth =
    {
      exp : int;
      iat : int;
      scope : string;
      did : string;
      jti : string option;
      token : string;
      refresh_token : string option;
    }

  type basic_cred =
    {
      username : string;
      password : string;
    }

  let create_basic_auth_header (cred : basic_cred) : (string * string) =
    ("authorization", ("Basic " ^ cred.username ^ ":" ^ cred.password))

  let create_bearer_auth_header (auth : auth) : (string * string) =
    ("authorization", ("Bearer " ^ auth.token))

  let make_auth_token_request (username : string) (password : string) (base_url : string) : string =
    let url = Printf.sprintf "%s/_open/auth" base_url in
    let data = Printf.sprintf "{\"username\": \"%s\", \"password\": \"%s\"}" username password in
    Printf.printf "url: %s\n" url;
    Printf.printf "data: %s\n" data;
    let body = Lwt_main.run (Cohttp_client.post_data url data) in
    body

  let parse_auth json : auth =
    let open Yojson.Safe.Util in
    let token = json |> member "accessJwt" |> to_string in
    match unsafe_of_string token with
    | Ok jwt ->
      let claims = jwt.payload in
      let exp = claims |> member "exp" |> to_int in
      let iat = claims |> member "iat" |> to_int in
      let scope = claims |> member "scope" |> to_string in
      let did = claims |> member "sub" |> to_string in
      let jti =
        try
          let refresh_jwt = json |> member "refreshJwt" |> to_string in
          match unsafe_of_string refresh_jwt with
          | Ok jwt -> Some ( jwt.payload |> member "jti" |> to_string)
          | Error _ -> None
        with _ -> None
      in
      let refresh_token = try Some (json |> member "refreshJwt" |> to_string) with _ -> None in
      { exp; iat; scope; did; jti; token; refresh_token }
    | Error _ -> failwith "Invalid JWT token"

  let convert_body_to_json (body : string) : Yojson.Safe.t =
    let json = Yojson.Safe.from_string body in
    json

  let username_and_password_from_env : basic_cred =
    let username = try Sys.getenv "ARANGO_USER" with Not_found -> "root" in
    let password = try Sys.getenv "ARANGO_PASSWORD" with Not_found -> "" in
    { username; password }

    let port_from_env : int =
      try
          let port_str = Sys.getenv "ARANGO_PORT" in
          try
              int_of_string port_str
          with Failure _ -> 5001
      with Not_found -> 5001

  let hostname_from_env : string =
    let hostname = try Sys.getenv "ARANGO_HOST" with Not_found -> "localhost" in
    hostname

  let remove_last_char str =
    let str_len = String.length str in
    if str_len = 0 then str else String.sub str 0 (str_len - 1)

  let get_base_url_from_env : string =
    let hostname = hostname_from_env in
    let hostname = if String.get hostname (String.length hostname - 1) = '/' then remove_last_char hostname else hostname in
    let port = port_from_env in
    let hostname = hostname ^ ":" ^ (string_of_int port) in
    hostname


end
