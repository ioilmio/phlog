require 'rails_helper'

RSpec.describe 'opinions/new', type: :view do
  before(:each) do
    assign(:opinion, Opinion.new(
                       content: 'MyText',
                       user: nil
                     ))
  end

  it 'renders new opinion form' do
    render

    assert_select 'form[action=?][method=?]', opinions_path, 'post' do
      assert_select 'textarea[name=?]', 'opinion[content]'

      assert_select 'input[name=?]', 'opinion[user_id]'
    end
  end
end
