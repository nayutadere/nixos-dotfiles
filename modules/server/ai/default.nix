{config, ...}:
{
services.ollama = {
  enable = true;
  host = "127.0.0.1";
  loadModels = [
    "qwen2.5-coder:7b-instruct"
    "qwen2.5:7b-instruct"
  ];
  environmentVariables = {
    OLLAMA_NUM_THREADS = "16";
    OLLAMA_KEEP_ALIVE = "30m";
  };
};

services.open-webui = {
  enable = true;
  host = "127.0.0.1";
  port = 8089;
  environment = {
    OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    ANONYMIZED_TELEMETRY = "False";
    DO_NOT_TRACK = "True";
    SCARF_NO_ANALYTICS = "True";
    WEBUI_AUTH = "False";
  };
};

services.caddy.virtualHosts."ai.bocchide.re".extraConfig = ''
  forward_auth localhost:9091 {
    uri /api/authz/forward-auth
    copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
  }
  reverse_proxy localhost:8089
'';
}