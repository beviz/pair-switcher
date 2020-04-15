require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'name validation' do
    context 'uniqueness in team' do
      let(:team) { create :team }
      let(:member) { create :member, team: team }
      it { new_member = build(:member, name: member.name, team: team)
           expect(new_member).not_to be_valid }
    end

    context 'uniqueness in team' do
      let(:team1) { create :team }
      let(:member) { create :member, team: team1 }
      let(:team2) { create :team }
      it { new_member = build(:member, name: member.name, team: team2 )
           expect(new_member).to be_valid }
    end
  end
end
