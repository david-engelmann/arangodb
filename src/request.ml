module Request = struct
  type request =
    {
      host_url : string;
      http_method : string;
      body : string;
      expect_binary : bool;
      is_binary : bool;
      allow_dirty_read : bool;
      retry_on_confict : int option;
      headers : (string * string) list;
      timeout : int;
      base_path : string;
      path : string;
      qs : (string * string) list;
    }
end
