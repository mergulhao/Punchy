namespace :restore do
  require 'net/ssh'
  require 'net/scp'
  HOST = '67.23.239.112'
  USER = 'railsapps'
  APPDIR = '/home/railsapps/punchy'
  OLDAPPDIR = '/home/railsapps/punchy-old'
  BACKUPDIR = '/home/railsapps/punchy-backups/punchy'
  TMPFILE = "/tmp/#{ENV['FILE']}"

  task :list do
    Net::SSH.start(HOST, USER) do |ssh|
      puts ssh.exec!("ls -l #{BACKUPDIR}")
    end
  end

  task :run do
    Net::SSH.start(HOST, USER) do |ssh|
      ssh.scp.download! "#{BACKUPDIR}/#{ENV['FILE']}", TMPFILE
    end
    
    `mv #{APPDIR} #{OLDAPPDIR}`
    `cd /tmp`
    `tar xvf #{TMPFILE}`
    `mysql -u root punchy_production < /tmp/punchy/MySQL/punchy_production.sql`
    `cd /`
    `tar xf /tmp/punchy/archive/punchy_files.tar`
    `rm -rf /tmp/punchy`
    `rm #{TMPFILE}`
    `touch /home/railsapps/punchy/current/tmp/restart.txt`
    `rm -rf #{OLDAPPDIR}`
  end
end