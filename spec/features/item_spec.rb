require "rails_helper"

RSpec.feature 'Item management' , :type => :feature, js: true do
  background do
    @item = Item.create!(name: 'test', price: 1000, disable_flg: 0)
    @user = FactoryGirl.build(:user)
    @user.password = "123456"
    @user.save
    @delivery_info = FactoryGirl.build(:delivery_info)
    @delivery_info.user_id = @user.id
    @delivery_info.save
  end
  scenario "add item to shopping cart and order" do
    # TOPページ
    visit item_path(@item)

    # 商品をカートに追加
    expect{
      click_link 'カートに追加'
    }.to change(ShoppingCart, :count)
    visit shopping_carts_path
    click_link '注文する'
    expect(page).to have_content "ログイン"

    # 認証
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'

    # 注文確定
    expect{
      click_button '注文確定'
    }.to change(Order, :count).by(1)
    expect(page).to have_content "ご注文ありがとうございました"
  end

  scenario "add item to shopping cart and clear cart" do
    # TOPページ
    visit item_path(@item)

    # 商品をカートに追加
    expect{
      click_link 'カートに追加'
    }.to change(ShoppingCart, :count).from(0).to(1)
    visit shopping_carts_path
    # カートをクリア
    expect{
      click_link 'カートをクリア'
      page.driver.browser.switch_to.alert.accept
    }.to change(ShoppingCart, :count).by(0)
  end

  scenario "add item to shopping cart and remove item" do
    # TOPページ
    visit item_path(@item)

    # 商品をカートに追加
    expect{
      click_link 'カートに追加'
    }.to change(ShoppingCart, :count).from(0).to(1)
    visit shopping_carts_path

    # 商品を削除
    expect{
      click_link 'カートから削除'
      page.driver.browser.switch_to.alert.accept
    }.to change(ShoppingCart, :count).by(0)
  end
end