require 'rails_helper'

describe "Product", :js => true, :sauce => true do
  let!(:products) { Product.all }
  let!(:product) { products.first }
  let!(:product2) { products[1] }
  let!(:product3) { products[2] }
  let!(:product4) { products[3] }
  let!(:product5) { products[4] }
  it "Shows a welcome title" do
    visit root_path
    expect(page).to have_content('Welcome to our Shoppe')
  end

  context "Click Products Link" do
    it "shows all products" do
      visit root_path
      click_on('All Products')
      expect(page).to have_content('Our Products')
      expect(page).to have_content(product.title.upcase)
      expect(page).to have_content(product2.title.upcase)
      expect(page).to have_content(product3.title.upcase)
      expect(page).to have_content(product4.title.upcase)
    end
  end

  context "Click on products from all products page" do
    before(:each) do
      visit products_path
      click_on(product.title.upcase)
    end
    it "shows product title" do
      expect(page).to have_content(product.title)
    end
    it "shows product details" do
      expect(page).to have_content(product.details)
    end
    it "shows product quantity" do
      expect(page).to have_content(product.quantity)
    end
    it "shows product price" do
      expect(page).to have_content(product.price)
    end
  end
  context "Edit items page" do
    before(:each) do
      visit edit_product_path(product)
    end
    it "displays edit form" do
      expect(page).to have_css('form.edit_product')
    end
    context "Title formgroup" do
      it "has a title field" do
        expect(page).to have_field("product[title]")
      end
      it "has title pre-filled" do
        expect(page).to have_field("product[title]", with: product.title)
      end
    end
    context "Price formgroup" do
      it "has a price field" do
        expect(page).to have_field("product[price]")
      end
      it "has price pre-filled" do
        expect(page).to have_field("product[price]", with: product.price)
      end
    end
    context "Quantity formgroup" do
      it "has a quantity field" do
        expect(page).to have_field("product[quantity]")
      end
    end
    context "Photo formgroup" do
      it "has a photo field" do
        expect(page).to have_field("product[photo]")
      end
    end
    context "Details formgroup" do
      it "has a details field" do
        expect(page).to have_field("product[details]")
      end
      it "has details pre-filled" do
        expect(page).to have_field("product[details]", with: product.details)
      end
    end
    it "has a categories field" do
      expect(page).to have_field("product[category_ids][]")
    end
  end
end
