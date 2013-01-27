class ApplicationController < ActionController::Base
	protect_from_forgery

	def frontpage
		respond_to do |format|
			format.html { render "frontpage/default" }
		end
	end
end
