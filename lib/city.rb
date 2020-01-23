require 'nokogiri'
require 'open-uri'

page_list = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

def names_to_array(page)
    array = []
    page.xpath('//a[contains(@class,"lientxt")]').each do |name|
        array << name.content
    end
    return array
end

def townlink_to_array (page)
    array = []
    page.xpath('//a[contains(@class,"lientxt")]').each do |link|
        str = link['href']
        str [0] = ''
        array << str
    end
    return array
end

def emails_to_array(links_array)
    array = []
    debut_lien = "http://annuaire-des-mairies.com"
    links_array.each do |fin_lien|
        ville_page = Nokogiri::HTML(open(debut_lien + fin_lien))    
        email = ville_page.xpath("//td[contains(text(), '@')]")
        email = email.text
        if email == ""
            email = "ERROR_666 : AUCUNE ADRESSE MAIL REPERTORIEE"
        end
        array << email
        print "tic "
    end 
    print "\n"
    return array 
end

def make_hash(names, emails)
    array = []
    i = 0 
    names.each do  
        mini_hash = Hash.new
        mini_hash[names[i]] = emails[i]
        array << mini_hash  
        i = i + 1 
    end 
    return array
end

def perform(page_list)
    names_array = names_to_array(page_list)
    townlink_array = townlink_to_array(page_list)
    emails_array = emails_to_array(townlink_array)
    final_array = make_hash(names_array, emails_array)
    puts final_array
    return final_array
end

perform(page_list)