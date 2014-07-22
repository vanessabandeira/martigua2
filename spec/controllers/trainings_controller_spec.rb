require "rails_helper"

describe TrainingsController, :type => :controller do

  let(:request_params) { {} }
  let(:section) { create :section }

  describe "GET index" do
    let(:request) { get :index, request_params }

    context 'within section' do
      let(:request_params) { { section_id: section.to_param } }

      context 'signed as user' do
        let(:user) { create :user, with_section: section }

        let(:training_1) { create :training, with_section: section }
        let(:training_2) { create :training, with_section: section }
        let!(:training_not_in_section) { create :training }

        before { sign_in user }
        before { request }

        it { expect(assigns[:trainings]).to match_array([training_1, training_2 ]) }
      end
    end
  end

  describe "POST create" do
    let(:request) { post :create, request_params }
    let(:new_training) { build :training }

    context 'signed as user' do
      let(:training_params) { { training: new_training.attributes.slice('start_datetime', 'end_datetime') } }
      let(:request_params) { training_params.merge(section_id: section.id) }

      let(:user) { create :user, with_section: section }
      before { sign_in user }

      it { expect{request}.to change{section.trainings.count}.by(1) }

      describe 'response' do
        before { request }

        it { expect(response).to redirect_to(section_trainings_path(section_id: section.to_param))}        
      end
    end
  end

end