require_relative '../lib/scrapper'

describe "crypto_names function" do
    it "make an array of names" do
      expect(crypto_names(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))).size).to eq(200)
    end
    it "make an array of prices" do
        expect(crypto_chiffres(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))).size).to eq(200)
    end
  end
