require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def crypto_names(page)
    array_names = [] 
    page.xpath('//td[contains(@class,"cmc-table__cell--sort-by__symbol")]').each do |crypto_name|
        array_names << crypto_name.content
    end
    return array_names
end

def crypto_chiffres(page)
    page = page.xpath ('//td[contains(@class,"cmc-table__cell--sort-by__price")]/a')
    array_all_crypto_chiffres = []
    
    page.each do |crypto_chiffre|
        array_all_crypto_chiffres << crypto_chiffre.text.delete('$').to_f
        end
       
        return array_all_crypto_chiffres
end

def into_an_hash(crypto_names, crypto_chiffres)
  global_hash = Hash[crypto_names.zip(crypto_chiffres)]
  return global_hash
end

def rearrange_big_hash(hash)
    rearranged_tab = []
    hash.each do |symbol, price|
        rearranged_tab << { symbol => price }
    end
    return rearranged_tab
end

def perform(page)
    array_names = crypto_names(page)
    array_price = crypto_chiffres(page) 
    transition_hash = into_an_hash(array_names, array_price)
    final_tab = rearrange_big_hash(transition_hash)
    return final_tab.inspect
end

 perform(page)