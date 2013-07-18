namespace :cap_data do
  desc 'Load singleton cap entry row'
  task :singleton => :environment do
    unless CapEntry.singleton_entry.present?
      cap_entry = CapEntry.new
      cap_entry.message = CapEntry::SINGLETON_MSG
      cap_entry.save!
    end
  end

  desc 'Load a cap run entry row'
  task :run => :environment do
    cap_entry = CapEntry.new
    cap_entry.message = "I was created by a capistrano deploy!"
    cap_entry.save!
  end
  
  task :all => [:singleton, :run]
end

task :cap_data => 'cap_data:all'
