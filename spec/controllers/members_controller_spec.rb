require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:team) { create :team }

  describe 'GET #show' do
    let(:member) { create :member, team: team }
    let(:pair) { create :member, team: team }
    before { create :pair_history, member: member, target: pair }
    action { get :show, params: { team_id: team.token, id: member.id } }

    it { should respond_with(:success) }
  end

  describe 'POST #create' do
    action { post :create, params: { member: member_params }.merge(team_id: team.token) }

    context 'valid attributes' do
      let(:member_params) { attributes_for(:member) }
      it { should redirect_to(team) }
    end

    context 'invalid attributes' do
    end
  end

  describe 'POST #disable' do
    let(:member) { create :member, team: team }
    action { post :disable, params: { team_id: team.token, id: member.id } }
    it { should redirect_to(team) }
  end

  describe 'POST #enable' do
    let(:member) { create :member, team: team }
    action { post :enable, params: { team_id: team.token, id: member.id } }
    it { should redirect_to(team) }
  end

  describe 'POST #destroy' do
    let(:member) { create :member, team: team }
    let(:pair) { create :member, team: team }
    before { create :pair_history, member: member, target: pair }
    action { delete :destroy, params: { team_id: team.token, id: member.id } }
    it { should redirect_to(team) }
  end
end
