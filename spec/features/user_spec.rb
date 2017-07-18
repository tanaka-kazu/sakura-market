require "rails_helper"

RSpec.feature 'User management' , :type => :feature do
  background do
    @user = FactoryGirl.build(:user)
    @user.password = "123456"
    @user.save
  end
    scenario "update user nickname" do
    # ユーザー認証ページ
    visit user_session_path

    # 認証
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    expect(page).to have_content "ログアウト"

    # ユーザー情報ページ
    visit user_path
    fill_in 'user[nickname]', with: "update_name"
    click_button '保存'
    expect(page).to have_content "ユーザー情報を更新しました"
  end
end