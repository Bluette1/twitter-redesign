require 'rails_helper'

RSpec.describe 'Features', type: :feature do
  let(:mary) do
    {
      username: 'MaryS', full_name: 'Mary S'
    }
  end
  let(:jane) { { username: 'JaneS', full_name: 'Jane S' } }

  before :each do
    # register_user mary
    visit sign_up_path
    fill_in 'Username', with: mary[:username]
    fill_in 'Full name', with: mary[:full_name]

    click_button 'Register'
    click_on 'Logout'
    # register_user jane
    visit sign_up_path
    fill_in 'Username', with: jane[:username]
    fill_in 'Full name', with: jane[:full_name]

    click_button 'Register'
  end
  scenario 'user can follow another user' do
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Jane with an idea.'
    click_button 'Save'
    click_on '@MaryS Mary S'
    click_on '+/Follow'

    expect(page).to have_content("You are now following #{mary[:username]}")
  end

  scenario 'user can unfollow and refollow another user' do
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Jane with an idea.'
    click_button 'Save'
    click_on '@MaryS Mary S'
    click_on '+/Follow'

    expect(page).to have_content("You are now following #{mary[:username]}")

    click_on '-/Unfollow'
    expect(page).to have_content("You have successfully unfollowed #{mary[:username]}")

    click_on '+/Follow'
    expect(page).to have_content("You are now following #{mary[:username]}")

    click_on 'Logout'

    fill_in 'Username', with: mary[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Mary with an idea.'
    click_button 'Save'
    click_on 'Logout'

    fill_in 'Username', with: jane[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    expect(page).to have_content('This is Mary with an idea.')
  end

  scenario 'user can bookmark another user\'s thought on their home page' do
    click_on 'HOME PAGE'
    click_on '@MaryS Mary S'
    click_on '+/Follow'
    click_on 'Logout'

    fill_in 'Username', with: mary[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Mary with an idea.'
    click_button 'Save'
    click_on 'Logout'

    fill_in 'Username', with: jane[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    expect(page).to have_content('This is Mary with an idea.')
    click_on '+/bookmark'
    expect(page).to have_content('You bookmarked an idea.')
  end

  scenario 'user can bookmark another user\'s thought on their user profile page' do
    click_on 'HOME PAGE'
    click_on '@MaryS Mary S'
    click_on '+/Follow'
    click_on 'Logout'

    fill_in 'Username', with: mary[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Mary with an idea.'
    click_button 'Save'
    click_on 'Logout'

    fill_in 'Username', with: jane[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    click_on '@MaryS Mary S'
    expect(page).to have_content('This is Mary with an idea.')
    click_on '+/bookmark'
    expect(page).to have_content('You bookmarked an idea.')
  end

  scenario 'user can remove a bookmark from their bookmarks page' do
    click_on 'HOME PAGE'
    click_on '@MaryS Mary S'
    click_on '+/Follow'
    click_on 'Logout'

    fill_in 'Username', with: mary[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    fill_in :post_content, with: 'This is Mary with an idea.'
    click_button 'Save'
    click_on 'Logout'

    fill_in 'Username', with: jane[:username]
    click_on 'Log In'
    click_on 'HOME PAGE'
    expect(page).to have_content('This is Mary with an idea.')
    click_on '+/bookmark'
    expect(page).to have_content('You bookmarked an idea.')
    click_on '-/unbookmark'
    expect(page).to have_content('You deleted a bookmark.')
  end
end
