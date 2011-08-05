##
# Punchy Backup
#
# For more information:
#
# View the Git repository at https://github.com/meskyanichi/backup
# View the Wiki/Documentation at https://github.com/meskyanichi/backup/wiki
# View the issue log at https://github.com/meskyanichi/backup/issues
#
# You can run backup from the command line by issuing the following command:
#
# $ backup perform -t punchy -c config/backup.rb

Backup::Model.new(:punchy, 'Punchy Backup') do

  ##
  # Archive [Archive]
  #
  archive :punchy_files do |archive|
    archive.add '/home/railsapps/punchy'
  end

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    db.name               = "punchy_production"
    db.username           = "root"
    db.password           = ""
    db.host               = "localhost"
    db.port               = 3306
    db.additional_options = ['--quick', '--single-transaction', '--add-drop-database', '-B punchy_production']
  end

  ##
  # SCP (Secure Copy) [Storage]
  #
  store_with SCP do |server|
    server.username = 'railsapps'
    server.ip       = '67.23.239.112'
    server.port     = 22
    server.path     = '~/punchy-backups/'
    server.keep     = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

end
