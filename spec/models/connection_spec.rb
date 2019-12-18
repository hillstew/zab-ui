require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:connected_user_id)}
    it { should validate_presence_of(:accepted?)}
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:connected_user) }
  end
end
