namespace :deploy do

  desc "reload the database with seed data"
  task :seed do
    puts "\n=== Seeding Database ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc "reload the province data with seed data"
  task :seed_province do
    puts "\n=== Seeding province ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          # execute :rake, 'db:seed:area'
          # execute :rake, 'db:seed:stockpoint'
          # execute :rake, 'db:seed:division'
          # execute :rake, 'db:seed:product'
          # execute :rake, 'db:seed:user'
          execute :rake, 'db:seed:province'
        end
      end
    end
  end

  desc "reload the users data with seed data"
  task :seed_admin_data do
    puts "\n=== Seeding users ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed:users'
        end
      end
    end
  end
end