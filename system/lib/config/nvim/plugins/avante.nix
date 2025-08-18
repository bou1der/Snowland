{
  plugins.avante = {
    enable = true;
    settings = {
      diff = {
        debug = true;
        autojump = true;
      };
      providers = {
        gemini = {
          api_key_name = "GEMINI_API_KEY";
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models";
          model = "gemini-2.5-flash";
          timeout = 30000;
          temperature = 0;
          max_tokens = 8192;
        };
        claude = {
          endpoint = "https://us-east1-aiplatform.googleapis.com/v1";
          model = "claude-3-5-sonnet-20241022";
          timeout = 30000;
          extra_request_body = {
            temperature = 0.75;
            max_tokens = 20480;
          };
        };
        moonshot = {
          endpoint = "https://api.moonshot.ai/v1";
          model = "kimi-k2-0711-preview";
          timeout = 30000;
          extra_request_body = {
            temperature = 0.75;
            max_tokens = 32768;
          };
        };
      };
    };
  };
}
