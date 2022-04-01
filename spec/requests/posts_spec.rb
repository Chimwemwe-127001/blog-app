RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before :each do
      @user1 = User.create('Name' => 'Amy', 'Bio' => 'bio', 'Photo' => 'Tom.png', 'Posts_Counter' => 0)
    end

    before(:each) { get "/users/#{@user1.id}/posts" }
    it 'checks if action returns correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'checks if action rendered a correct template' do
      expect(response).to render_template('index')
    end

    it 'checks if correct placeholder is shown' do
      expect(response.body).to include('Number of posts')
    end
  end
end
