require 'rails_helper'

RSpec.describe 'opinions/edit', type: :view do
  before(:each) do
    @opinion = assign(:opinion, Opinion.create!(
                                  content: 'MyText',
                                  user: nil
                                ))
  end

  it 'renders the edit opinion form' do
    render

    assert_select 'form[action=?][method=?]', opinion_path(@opinion), 'post' do
      assert_select 'textarea[name=?]', 'opinion[content]'

      assert_select 'input[name=?]', 'opinion[user_id]'
    end
  end
end
