require 'rails_helper'

RSpec.describe 'opinions/show', type: :view do
  before(:each) do
    @opinion = assign(:opinion, Opinion.create!(
                                  content: 'MyText',
                                  user_id: 1
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
