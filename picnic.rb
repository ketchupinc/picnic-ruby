require "net/http"
require "uri"
require "json"

class Picnic
  BASE_URL = "https://picnic.sh"
  def initialize api_key
    @api_key = api_key

    uri = URI.parse(BASE_URL)
    @http = Net::HTTP.new(uri.host, uri.port)
  end

  def list_websites
    response = @http.request(Net::HTTP::Get.new("/api/websites/?api_key=#{@api_key}"))
    json_or_exception(response, "Unable to fetch websites")
  end

  def get_website domain_name
    response = @http.request(Net::HTTP::Get.new("/api/websites/#{domain_name}?api_key=#{@api_key}"))
    json_or_exception(response, "Unable to fetch website: #{domain_name}")
  end

  def get_price domain_name
    response = @http.request(Net::HTTP::Get.new("/api/price/#{domain_name}?api_key=#{@api_key}"))
    json_or_exception(response, "Unable to fetch price for: #{domain_name}")
  end

  def create_website domain_name, html
    request = Net::HTTP::Post.new("/api/websites/?api_key=#{@api_key}")
    request.add_field("Content-Type", "application/json")
    request.body = JSON.dump({ "domain_name" => domain_name, "html" => html })
    response = @http.request(request)
    json_or_exception(response, "Unable to create website: #{domain_name}")
  end

  def update_website domain_name, html
    request = Net::HTTP::Put.new("/api/websites/#{domain_name}?api_key=#{@api_key}")
    request.add_field("Content-Type", "application/json")
    request.body = JSON.dump({ "html" => html })
    response = @http.request(request)
    json_or_exception(response, "Unable to update: #{domain_name}")
  end

  private
  def json_or_exception res, error
    code = res.code.to_i
    if code >= 200 && code < 300
      JSON.parse(res.body)
    else
      raise Exception.new("#{error}\n#{res.body}")
    end
  end
end
