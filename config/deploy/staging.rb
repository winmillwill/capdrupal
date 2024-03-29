set :stage, :staging

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
server 'capdrupal.dev', user: 'vagrant', roles: %w{web app db}

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
server 'capdrupal.dev',
  ssh_options: {
    keys: %w(~/.vagrant.d/insecure_private_key),
    forward_agent: false,
    auth_methods: %w(publickey)
  }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(:rails_env, :staging)
