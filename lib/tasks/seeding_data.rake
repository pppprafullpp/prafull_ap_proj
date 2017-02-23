namespace :seeding_data do
    task add_all_countries: :environment do
      csv_text = File.read(Rails.root.to_s+'/public/country_list.csv');
      csv = CSV.parse(csv_text, :headers => true)
      # puts csv_text
      csv.each do |row|
        country_name = row["country_name"]
        Country.create!(:country_name=>country_name)
        puts "Done for #{country_name}"
      end
    end
  end
