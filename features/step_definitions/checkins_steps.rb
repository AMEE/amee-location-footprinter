Then /^I should see a list of checkins$/ do
  page.has_css? "h3", :text => Date.new.strftime("%d %m %Y")
  page.has_css? 'ul.checkins'
end