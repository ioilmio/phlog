require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it 'expect relationship to be valid' do
    Relationship.new(follower_id: 1, followed_id: 2)
  end  
  it 'expect relationship to not be valid' do
    Relationship.new(follower_id: nil, followed_id: 2)
  end 
  it 'expect relationship to not be valid' do
    Relationship.new(follower_id: 1, followed_id: nil)
  end
end
