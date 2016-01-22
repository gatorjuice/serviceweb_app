require 'rails_helper'

RSpec.describe Resource, type: :model do

  describe '#verify' do
    it 'should return an initial score of 0' do
      resource = Resource.new
      expect(resource.score).to eq(0)
    end
  end

  describe '#phone_with_dashes' do
    it 'should return a properly formatted phone number for readability' do
      resource = Resource.new(phone: '5555555555')
      expect(resource.phone_with_dashes).to eq('(555) 555-5555')
    end
  end

end
