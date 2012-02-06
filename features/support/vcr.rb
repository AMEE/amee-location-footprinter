
require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :all }
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr'
end
