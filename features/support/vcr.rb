
require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :once }
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr'
end
