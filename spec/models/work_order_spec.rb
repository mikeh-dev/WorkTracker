require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:job_type).with_values(
      repair: 0,
      installation: 1,
      floor_protection_and_installation: 2
    ) }
  end

  describe 'validations' do
    it { should validate_presence_of(:production_job_number) }
    it { should validate_presence_of(:sales_order_number) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_length_of(:vehicle_registration_number).is_at_most(8) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      work_order = build(:work_order)
      expect(work_order).to be_valid
    end
  end
end