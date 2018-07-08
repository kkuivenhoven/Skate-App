class BroadcastsController < ApplicationController

	def index
		headers = { 
			"Content-Type" : "application/json",
			"Authorization" : "key=AAAANlTyluU:APA91bGM2jWiSSFni4tHUhZYqBxmTb4c2qHzE62az0HY7IfAg8T6yN51qJqoENp_LM3yMeUZ-Bn6PU-SoGTHiPT8ZPdn-N3xLT3uwqqGwLGlXIpC94pa-TYvHMT-iLTUdHXHFe96qWhqbBqr1BxOlq40dqmOy5MOfw"}
			url="https://fcm.googleapis.com/fcm/send"
			User.find_each do |user|
				payload = {
					"notification": {
							"title": "Tenemos un mensaje para ti!",
							"body": "Respuesta por favor, somos que padre!",
							"icon": "/app_icon.png",
							"click_action": "localhost:3000"
					 },
					 "to": user.push_sub
				}
				RestClient.post(url,payload,headers)
			end
	end


end					
				




