require 'rails_helper'
RSpec.describe 'Testing Post index view, it' do
  before :each do
    @user = User.create(name: 'Ben', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Test1', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Test2', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Test3', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    @comment = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'first comment')
    visit user_posts_url(@user.id, @post1.id)
  end

  it 'can see the profile picture of the user' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

end