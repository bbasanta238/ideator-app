server "10.0.22.47", user: "ubuntu", roles: %w{app web db} # AZ-a
set :ssh_options, {
  keys: %w(~/.ssh/re_ssh.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
  proxy: Net::SSH::Proxy::Command::new("ssh bastion-host -W %h:%p"),
  verbose: :debug,
  verify_host_key: :never,
}
