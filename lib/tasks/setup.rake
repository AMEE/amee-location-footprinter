namespace :alf do
  desc "Create yaml files for foursquare and AMEE to add credentials to"
  task :config do
    FileUtils.cp File.join("config", "foursquare.yml.sample"), File.join("config", "foursquare.yml")
    FileUtils.cp File.join("config", "amee.yml.sample"), File.join("config", "amee.yml")
    puts "There are now empty config files to put your Foursquare and AMEE credentials into."
    puts "You should find them on the paths below:"
    puts "config/foursquare.yml"
    puts "config/amee.yml"
  end
  
end