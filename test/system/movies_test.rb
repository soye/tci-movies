require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  test "searching for a movie" do
    VCR.use_cassette 'system searching for a movie' do
      visit root_path

      click_on "search"

      assert_field "search by title"

      fill_in "search by title", with: "up"
      click_button "find the stars"

      assert_content "page 1"

      assert_link "Up"
    end
  end

  test "go to next page of results" do
    VCR.use_cassette 'system going to next page' do
      visit search_path
      fill_in "search by title", with: "up"
      click_button "find the stars"

      click_on "next page →"

      page.must_have_content "title ▼"
      assert_link "title ▼"
      assert_content "page 2"
    end
  end

  test "sorting movies by title" do
    VCR.use_cassette 'system sorting movies by title' do
      visit root_path
      click_on "title"

      # currently last film by title in db
      assert_content "The Ultimate Underdog Collection"
    end
  end

  test "sorting movies by release date" do
    VCR.use_cassette 'system sorting movies by release date' do
      visit root_path
      click_on "release date"

      page.must_have_content "release date ▼"
      click_on "release date ▼"

      # currently oldest film in db
      assert_link "Passage of Venus"
    end
  end

  test "filtering movies by genre" do
    VCR.use_cassette 'system filtering movies by genre' do
      visit movies_path

      # currently first in popularity from tmdb
      assert_link "Minions"

      # uncheck animation filter
      find('input#genres_16').set false

      # update results
      click_button "show me the stars"
    end

    page.wont_have_content "Minions"
  end
end