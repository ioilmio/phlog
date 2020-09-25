require 'rails_helper'

RSpec.describe 'opinions/edit', type: :view do
  before(:each) do
    @opinion = assign(:opinion, Opinion.create!(
                                  content: 'MyText',
                                  user_id: 1
                                ))
  end

  it 'renders the edit opinion form' do
    render

    assert_select 'form[action=?][method=?]', opinion_path(@opinion), 'post' do
      assert_select 'textarea[name=?]', 'opinion[content]'
    end
  end
end
