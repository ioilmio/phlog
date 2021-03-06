require 'rails_helper'

RSpec.describe Opinion, type: :model do
  let(:user) do
    User.create!(
      username: 'user',
      fullname: 'user one',
      email: 'user21@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end
  describe 'validations' do
    it 'is valid with content' do
      opinion = user.opinions.create!(user_id: 2, content: 'Test content')
      expect(opinion).to be_valid
    end
    it 'is not valid without content' do
      opinion2 = user.opinions.create(user_id: user.id, content: '')
      expect(opinion2).not_to be_valid
    end
    describe 'Attachment' do
      it 'is valid with image' do
        opinion3 = user.opinions.new(user_id: user.id, content: 'test image')
        opinion3.image.attach(io: File.open(file_fixture('0.jpeg')), filename: '0.jpeg', content_type: 'image/jpeg')
        expect(opinion3.image).to be_attached
      end
    end
  end
end
