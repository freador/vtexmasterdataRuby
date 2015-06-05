#  ____          _      ____        
# / ___|___   __| | ___| __ ) _   _ 
#| |   / _ \ / _` |/ _ \  _ \| | | |
#| |__| (_) | (_| |  __/ |_) | |_| |
# \____\___/ \__,_|\___|____/ \__, |
#                             |___/ 
# Codeby bitches!

class Connector
	def initialize
		#inicializando libs
		require 'rubygems'
		require 'json'
		require 'pp'
		require 'rest-client'
	end

	def login_info
		#colocar login e senha para sua aplicação
		#login vtexappkey-
		# pegar no lincense
		login = "vtexappkey-sualoja"
		#senha vtextoken
		# senha pegar no lincense tbm
		senha = "ASDSAJDASKDAHSJDJKASDGHASKDASHDASKDASHKDASH"
		return { :login=> login, :senha=>senha}
	end

	def searchCustomer(login, senha, email)
		#buscar cliente cadastrado
		url = "http://api.vtexcrm.com.br/{nomeda sua loja}/dataentities/CL/search"

		begin
			resp = RestClient.get url,{:accept => "application/vnd.vtex.ds.v10+json", :content_type=>"application/json", 'x-vtex-api-appKey' => login, 'x-vtex-api-appToken'=> senha, :params => {'_keyword'=>email } }
			#Pegar a resposta como JSON
			resp = JSON.parse(resp)
			#criar um usuário ou atualizar
			self.createOrUpdateUser(login,senha,email)
			return "Tudo certo"
		rescue Exception => e
			return e
		end

	end

	def createOrUpdateUser(login,senha,email)
		# Atualiza ou cria usuário
		url = "http://api.vtexcrm.com.br/{sualoja}/dataentities/CL/documents"
		json = { "isNewsletterOptIn"=>"true", "email"=>email }.to_json
		resp = RestClient.put url,json, :accept => "application/vnd.vtex.ds.v10+json", :content_type=>"application/json", 'x-vtex-api-appKey' => login, 'x-vtex-api-appToken'=> senha
		resp = JSON.parse(resp)
		p resp
	end
	# prontinho vocês já sabem ler, atualizar e criar infos, agora só viajar!
end

connector = Connector.new()
connector.searchCustomer( vtexApi.login_info()[:login], vtexApi.login_info()[:senha], params[:name] )