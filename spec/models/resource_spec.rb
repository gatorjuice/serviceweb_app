require 'rails_helper'

describe Resource do
  before :each do
    sleep(0.5)
  end

  it "has a valid factory" do
    expect(build(:resource)).to be_valid
  end

  it "is invalid without a name" do
    resource = build(:resource, name: nil)
    resource.valid?
    expect(resource.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a street" do
    resource = build(:resource, street: nil)
    resource.valid?
    expect(resource.errors[:street]).to include("can't be blank")
  end

  it "is invalid without a city" do
    resource = build(:resource, city: nil)
    resource.valid?
    expect(resource.errors[:city]).to include("can't be blank")
  end

  it "is invalid without a state" do
    resource = build(:resource, state: nil)
    resource.valid?
    expect(resource.errors[:state]).to include("can't be blank")
  end

  it "is invalid without a zip_code" do
    resource = build(:resource, zip_code: nil)
    resource.valid?
    expect(resource.errors[:zip_code]).to include("can't be blank")
  end

  it "is invalid without a phone" do
    resource = build(:resource, phone: nil)
    resource.valid?
    expect(resource.errors[:phone]).to include("can't be blank")
  end

  it "is invalid without a description" do
    resource = build(:resource, description: nil)
    resource.valid?
    expect(resource.errors[:description]).to include("can't be blank")
  end

  it "must have at least one item checked" do
    resource = build(:resource, food: false, health: false, shelter: false)
    resource.valid?
    expect(resource.errors[:resource_types]).to include("must choose one type")
  end

  describe '#resource_types' do
    it 'returns an array of strings with the types' do
      resource = build(:resource, food: true, health: true, shelter: true)
      expect(resource.resource_types).to eq(["food", "health", "shelter"])
    end
  end

  describe '#display_resources' do
    it 'returns an array of strings with the types' do
      resource = build(:resource, food: true, health: true, shelter: true)
      expect(resource.display_resources).to eq("food, health, shelter")
    end
  end

  describe '#verify' do
    it 'should return an initial score of 0' do
      resource = build(:resource)
      expect(resource.score).to eq(0)
    end

    it 'should have a score of 1 after being verified once' do
      resource = build(:resource)
      resource.verify
      expect(resource.score).to eq(1)
    end
  end

  describe '#phone_with_dashes' do
    it 'should return a properly formatted phone number for readability' do
      resource = build(:resource, phone: '5555555555')
      expect(resource.phone_with_dashes).to eq('(555) 555-5555')
    end
  end
end
