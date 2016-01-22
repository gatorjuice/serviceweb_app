require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#test_method' do
    it 'should return a vlaue' do
      @comment = Comment.new()
    end
  end 
end
