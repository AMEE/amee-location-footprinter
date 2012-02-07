
namespace :alf do
  desc "Create yaml files for foursquare and AMEE to add credentials to"
  task :config do
    FileUtils.cp File.join("config", "foursquare.yml.sample"), File.join("config", "foursquare.yml")
    FileUtils.cp File.join("config", "amee.yml.sample"), File.join("config", "amee.yml")
  end
  
end
