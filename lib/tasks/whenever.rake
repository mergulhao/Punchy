namespace :whenever do
  task :create_punch => :environment do
    Punch.create(:body => Time.now.to_s(:db))
  end
end