require "rails_helper"

RSpec.feature 'Delivery info management' , :type => :feature do
  background do
    @user = FactoryGirl.build(:user)
    @user.password = "123456"
    @user.save
  end
  scenario "regist delivery infos and update later" do
    # ユーザー認証ページ
    visit user_session_path

    # 認証
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    expect(page).to have_content "ログアウト"

    # ユーザー情報ページ
    visit user_path
    click_link '配送先情報追加'
    expect(page).to have_content "配送先情報"

    # 配送情報登録
    fill_in 'delivery_info[name]', with: "テストユーザー"
    fill_in 'delivery_info[address]', with: "テスト住所"
    expect {
      click_button '保存'
    }.to change(DeliveryInfo, :count).by(1)
    expect(page).to have_content "配送先情報を登録しました"
 
    # 配送情報更新
    click_link '編集'
    fill_in 'delivery_info[name]', with: "テストユーザー２"
    fill_in 'delivery_info[address]', with: "テスト住所２"
    click_button '保存'
    expect(page).to have_content "配送先情報を更新しました"

    visit current_path
    expect(page).to have_content "テストユーザー２"
    expect(page).to have_content "テスト住所２"    
  end
end