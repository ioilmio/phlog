require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:opinions) }
  end
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    # it { is_expected.to validate_uniqueness_of(:email) }
  end
end
