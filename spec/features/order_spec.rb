require "rails_helper"

RSpec.feature 'Order management' , :type => :feature, js: true do
  background do
    @item = Item.create!(name: 'test', price: 1000, disable_flg: 0)
    @user = FactoryGirl.build(:user)
    @user.save
    @delivery_info = FactoryGirl.build(:delivery_info)
    @delivery_info.user_id = @user.id
    @delivery_info.save
  end
  scenario "if no order then order history has no record" do
    # TOPページ
    visit(items_path)
    click_link 'ログイン'

    # 認証
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'

    # ユーザー情報ページ
    visit user_path
    click_link '購入履歴を見る'

    # 購入履歴ページ
    expect(page).to_not have_content @item.name
  end

  scenario "watch order history" do

    # TOPページ
    visit items_path
    click_link 'ログイン'

    # 認証
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'

    # TOPページ
    visit item_path(@item)

    # 商品をカートに追加
    click_link 'カートに追加'

    # 注文
    visit shopping_carts_path
    click_link '注文する'

    click_button '注文確定'

    # ユーザー情報ページ
    visit user_path
    click_link '購入履歴を見る'
    expect(page).to have_link '注文詳細'

    # 注文詳細画面
    click_link '注文詳細'
    expect(page).to have_content @item.name 

  end
end