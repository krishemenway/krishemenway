
class RageIDRetriever
	def retrieve_csv series
		series_data_result = open "http://epguides.com/common/exportToCSV.asp?rage=#{series.rage_id}" do |io| data = io.read end
		return /<pre>([^<]+)<\/pre>/.match(series_data_result)[1].strip
	end
end