require 'rails_helper'

RSpec.describe 'opinions/index', type: :view do
  before(:each) do
    assign(:opinions, [
             Opinion.create!(
               content: 'MyText',
               user_id: 1
             ),
             Opinion.create!(
               content: 'MyText',
               user_id: 2
             )
           ])
  end

  it 'renders a list of opinions' do
    render
    assert_select 'td', text: 'MyText'.to_s, count: 2
    assert_select 'td', text: nil.to_s, count: 0
  end
end
