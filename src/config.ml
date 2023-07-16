open Auth

module Config = struct
  type config =
    {
      database_name : string;
      url : string;
      auth : Auth.auth;
      arango_version : int;
      load_balancing_strategy : string;
      max_retries : int option;
      retry_on_confict : int option;
      agent : string;
      agent_option : string;
      headers : string;
    }
end
