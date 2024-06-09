require 'rails_helper'

feature "Static content" do
  given!(:idea) { FactoryBot.create(:idea) }

  background do
    visit root_path
  end

  scenario "show author of idea" do
    expect(page).to have_content(idea.author)
  end

  scenario "show description of idea" do
    expect(page).to have_selector("p", text: idea.description)
  end

  scenario "have add idea button" do
    expect(page).to have_button('Add Idea')
    expect(page).to have_button('Add Idea', class: 'btn-primary')
  end

  scenario "have P tag with idea description" do
    expect(page).to have_selector("p", text: idea.description)
  end


# Adding idea and Description
  scenario 'clicking the any idea button' do
    click_button 'Add Idea'
    expect(page).to have_content("Modal title")
  end

  context 'when model is viewed' do
    background do
      click_button 'Add Idea'
    end

    scenario 'adding valid description and author' do  
      within('#new_idea') do
        fill_in 'Description', with: "Hello World!"
        fill_in 'Author', with: 'Test'
      end
      
      click_button 'Submit'
      expect(page).to have_content("Hello World!")
    end

    scenario 'adding invalid description and author' do  
      within('#new_idea') do
        fill_in 'Description', with: " "
        fill_in 'Author', with: ' '
      end
      
      click_button 'Submit'
      expect(page).to have_content("Woops! Looks like there has been an error!")
    end
  end
end
