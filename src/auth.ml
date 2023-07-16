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

end
