use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :vanpool, Vanpool.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE") 
  # secret_key_base: 

# Configure your database
config :vanpool, Vanpool.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: "vanpool_prod",
  size: 20 # The amount of database connections in the pool
