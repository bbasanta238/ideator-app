require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let!(:idea) { FactoryBot.create(:idea) }
  
  it 'must show author of idea' do
    visit root_path
    debugger
    expect(page).to have_content(idea.author)
  end
  
  it 'must show description of idea' do
    visit root_path
    expect(page).to have_content(idea.description)
  end
  
  it 'must have add idea button' do
    visit root_path
    expect(page).to have_button('Add Idea')
    expect(page).to have_button('Add Idea', class: 'btn-primary')
  end

  it 'must have current path as root_path' do
    visit root_path
    expect(page).to have_current_path('/')
  end

  it 'must ' do
    visit root_path
    sleep(2)
    expect(page).to have_selector("p", text: idea.description)
  end

  it 'must have model on clicking the any idea button' do
    visit root_path
    click_button 'Add Idea'
    sleep(2)
    expect(page).to have_content("Modal title")
  end

  context 'when form is filled' do
    context 'with valid credentials' do
      it 'must add description and author' do
        visit root_path
        click_button 'Add Idea'
        
        within('#new_idea') do
          fill_in 'Description', with: "Hello World!"
          fill_in 'Author', with: 'Test'
        end
        
        click_button 'Submit'
        sleep(2)
        expect(page).to have_content("Hello World!")
      end
    end

    context 'with invalid description and author' do
      it 'must show error message' do
        visit root_path
        click_button 'Add Idea'

        within('#new_idea') do
          fill_in 'Description', with: " "
          fill_in 'Author', with: ' '
        end
        
        sleep(2)
        click_button 'Submit'
        expect(page).to have_content("Woops! Looks like there has been an error!")
      end
    end
  end

  context 'on clicking revise btn' do
    it 'must show edit page' do
      visit root_path
      click_link 'Revise'

      expect(page).to have_selector('form', class: 'edit_idea')
    end
  end

  context'when adding valid data on edit form' do
    it 'must change author and description' do
      visit root_path
      click_link 'Revise'

      within('.edit_idea') do
        fill_in 'Description', with: "Hello World!"
        fill_in 'Author', with: 'Test1'
      end

      click_button 'Submit'
      expect(page).to have_content("Hello World!")
    end
  end 
end
