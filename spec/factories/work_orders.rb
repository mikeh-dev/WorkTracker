FactoryBot.define do
  factory :work_order do
    vehicle_registration_number { "AB12 CDE" }
    vehicle_make { "Toyota" }
    vehicle_model { "Corolla" }
    vehicle_mileage { "50000" }
    vehicle_damage_notes { "Minor scratch on rear bumper" }
    
    customer_name { "John Doe" }
    customer_phone_number { "07700900000" }
    customer_email { "john.doe@example.com" }
    production_job_number { "PJ#{rand(10000..99999)}" }
    sales_order_number { "SO#{rand(10000..99999)}" }
    
    job_type { "repair" }
    job_instructions { "Replace brake pads and check alignment" }
    assigned_to { "Mike Smith" }
    location { "Liverpool" }
    start_date { Time.current }
    end_date { 3.days.from_now }
    job_notes { "Customer requested evening collection" }
    extra_parts_used { "None" }
    
    association :user
  end

  trait :booked do
    status { "Booked" }
  end

  trait :completed do
    status { "Completed" }
  end

  trait :repair do
    job_type { "repair" }
    job_instructions { "Replace brake pads and check alignment" }
  end

  trait :installation do
    job_type { "installation" }
    job_instructions { "Install new security system" }
  end

  trait :floor_protection do
    job_type { "floor_protection_and_installation" }
    job_instructions { "Install floor protection in cargo area" }
  end
end