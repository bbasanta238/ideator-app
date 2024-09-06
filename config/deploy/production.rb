server "13.230.249.171", user: "ubuntu", roles: %w{web app db}
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w[publickey],
  keys: %w[~/.ssh/re_ssh.pem],
  verbose: :debug,
  verify_host_key: :never,
}
