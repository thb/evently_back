
FactoryBot.define do
  factory :place do
    name { 'L’Écart' }
    address { '26 Rue Jeanne d’Arc, 59000 Lille' }
    lat { '50.62819283743522' }
    lng { '3.064379710485924' }
    street_number { '26' }
    street { 'Jeanne d’Arc' }
    city { 'Lille' }
    country { 'France' }
  end
end