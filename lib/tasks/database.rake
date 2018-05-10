namespace :db do

  desc "Copy production database to local"
  task :copy_production => :environment do

    # Download latest dump
    # system "heroku pg:backups:download"

    # get user and database name
    config   = Rails.configuration.database_configuration["development"]
    database = config["database"]
    user = config["username"]

    # import
    system("pg_restore --verbose --clean -U postgres -h localhost -p 5433 -d #{database} #{Rails.root}/latest.dump")
  end

end
