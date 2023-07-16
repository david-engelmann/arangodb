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
end
