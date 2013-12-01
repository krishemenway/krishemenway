
class SteamArticleRepository
	@@max_length = 100
	@@back_article_count = 3
	@@base_url = 'http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/'

	def find_articles_for_app_id(app_id)
		Rails.cache.fetch ['news_items', app_id], expires_in: 5.hours do
			url_options = {
				:appid => app_id,
				:count => @@back_article_count,
				:max_length => @@max_length,
				:format => 'xml'
			}

			url = "#{@@base_url}?#{URI.encode_www_form(url_options)}"
			news_xml = Nokogiri::XML open(url)

			news = []

			news_xml.xpath('//appnews/newsitems/newsitem').each do |news_item_xml|
				news_item_hash = Hash.from_xml(news_item_xml.to_s)

				news_article = news_item_hash['newsitem']['contents']
				news_article = news_article.gsub /\[img\][^\]]+\[\/img\]/i, ''
				news_article = news_article.gsub /<img[^>]+>/i, ''

				news.push({
					:title => news_item_hash['newsitem']['title'],
					:url => news_item_hash['newsitem']['url'],
					:contents => news_article.bbcode_to_html({}, false)
				})
			end

			news
		end
	end
end