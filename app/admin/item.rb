ActiveAdmin.register Item do
  permit_params :name, :image, :price, :description, :disable_flg, :sort_order

  form do |f|
    f.inputs "商品情報登録" do
      f.input :name
      f.input :image, :as => :file, :hint => f.object.new_record? ? "" : f.template.image_tag(f.object.image.url(:thumb))
      f.input :price
      f.input :description
      f.input :disable_flg
      f.input :sort_order
    end
    f.actions
  end

  show do |item|
    attributes_table do
      row :name
      row :image do
        image_tag(item.image.url(:medium))
      end
      row :price
      row :description
      row :disable_flg
      row :sort_order
    end
  end
end
