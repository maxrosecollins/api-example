require 'httparty'
require 'redis_cache'
class Display
  include HTTParty
  base_uri 'https://api.gojimo.net'
  default_timeout 1

  def base_path
    "/api/v4/"
  end

  def timeout
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      []
    end
  end

  def cache(endpoint)
    cached = $redis.cache(
        key: "gojimo:#{endpoint}",
        expire: 100.hour,
        timeout: 5
      ) do
        yield.tap do |results|
          results
        end
      end
    unless cached.nil?
      return cached
    end
  end

  def check_cache(url, key)
    last_modified = self.class.get(url).headers['last-modified']
    expires = Time.now + ($redis.TTL "gojimo:#{key}")
    if expires < last_modified.to_time
      $redis.del "gojimo:#{key}"
    end
  end

  def qualifications
    #$redis.del "gojimo:qualifications"
    url = "#{base_path}qualifications"
    check_cache(url, "qualifications")
    timeout do
      cache("qualifications") do
        self.class.get(url).body
      end
    end
  end

end
