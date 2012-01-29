# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leg do
      distance "8.12"
      co2 "1.54"
      name "optional named journey"
      start_checkin_id "4e8b71d5d3e303e9db27e45f"
      end_checkin_id "4e86100c30f873b8fa4f3b83"
      mode_of_transport "car"
    end
end