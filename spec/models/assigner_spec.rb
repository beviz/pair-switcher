require 'rails_helper'

RSpec.describe Assigner do
  let(:team) { create :team }

  describe '#assign' do
    let(:result) { Assigner.assign(members) }

    context 'no history' do
      let(:members) { create_list :member, 6, team: team }
      it { expect(result.length).to be(3)
           expect(result.flatten - members).to be_empty }
    end

    context 'with history' do
      let(:members) { create_list :member, 20, team: team }
      before do
        sources, targets = members.shuffle.each_slice(10).to_a
        sources.each_with_index do |source, index|
          target = targets[index]
          create :pair_history, member: target, target: source
          create :pair_history, member: source, target: target
        end
      end
      it do
        expect(result.length).to be(10)
        expect(result.flatten - members).to be_empty
        result.each do |pair|
          last_pair = PairHistory.last_pair_of(pair[0])
          expect(last_pair).not_to eq(pair[1])
          expect(last_pair).not_to be_nil
        end
      end
    end
  end
end
