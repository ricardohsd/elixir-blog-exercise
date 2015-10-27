use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pxblog, Pxblog.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Inform Comeonin to not try too hard to encrypt
config :comeonin, bcrypt_log_rounds: 4

# Configure your database
config :pxblog, Pxblog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ricardohsd",
  password: "",
  database: "pxblog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
