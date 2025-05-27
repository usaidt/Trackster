import Config

config :trackster, Trackster.Repo,
  username: "argon",
  password: "Pi.CQcrPQ4CKN!q",
  database: "argon_trackster",
  hostname: "postgresql-argon.alwaysdata.net",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
