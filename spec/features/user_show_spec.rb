require 'rails_helper'

RSpec.feature 'UserShowPostsAndNavigation', type: :feature do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, author: user).sort_by(&:created_at).reverse }
  let!(:first_post) { posts.first }

  before do
    visit user_path(user)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'displays the username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  it 'displays the user bio' do
    expect(page).to have_content(user.bio)
  end

  it 'displays the first 3 posts' do
    user.three_most_recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end
  end

  it 'has a button to view all posts' do
    expect(page).to have_button('See All Posts')
  end

  it 'redirects to user posts index page when "See All Posts" is clicked' do
    click_button 'See All Posts'
    expect(page).to have_current_path(user_posts_path(user))
  end

  it 'redirects to post show page when a post is clicked' do
    # puts "Debug: first_post ID is #{first_post.id}"
    find(:link, first_post.title, match: :first).click
    # puts "Debug: Current path is #{page.current_path}"
    expect(page).to have_current_path(user_post_path(user, first_post))
  end
end
