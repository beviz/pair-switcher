require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe 'GET #show' do
    let(:team) { create :team }
    before { create :member, :disabled, team: team }
    action { get :show, params: { id: team.token } }
    it { should respond_with(:success) }
  end

  describe 'GET #index' do
    action { get :index }
    it { should respond_with(:success) }
  end

  describe 'POST #create' do
    action { post :create, params: { team: attributes_for(:team) } }
    it { should respond_with(:redirect)
         should redirect_to(assigns[:team]) }
  end

  describe 'POST #pair' do
    let(:team) { create :team }
    before { create_list :member, 2, team: team }
    action { post :pair, params: { id: team.token } }
    it { should respond_with(:redirect) }
  end

  describe 'POST #rollback' do
    let(:team) { create :team }
    action { post :rollback, params: { id: team.token } }

    context 'has history' do
      let(:member) { create :member, team: team }
      let(:pair) { create :member, team: team }
      before { create :pair_history, member: member, target: pair }
      it { should respond_with(:redirect) }
    end

    context 'no history' do
      it { should respond_with(:redirect) }
    end
  end
end
