require 'rails_helper'

RSpec.describe User, type: :model do

  subject { described_class.new }
# pending "add some examples to (or delete) #{__FILE__}"
  it 'should not be valid with empty attributes' do
    expect(subject).to_not be_valid
  end

  it 'should now be valid with email and password' do
    subject.email = 'test@gmail.com'
    subject.password = '123456789'
    expect(subject).to be_valid
  end

  it 'should not create user with nil email' do
    subject.email = nil
    subject.password = '123456789'
    expect(subject).to_not be_valid
  end

  it 'should not create with nil password' do
    subject.email = 'test@gmail.com'
    subject.password = nil
    expect(subject).to_not be_valid
  end

end
