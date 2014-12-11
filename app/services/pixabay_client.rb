class PixabayClient
  # see api spec http://pixabay.com/api/docs/
  CONFIGURATION = Struct.new(:username, :key)

  def self.configure
    yield(configuration)
    configuration
  end

  def self.configuration
    @configuration ||= CONFIGURATION.new
  end

  def initialize
    @api_wrapper = ApiWrapper.new
  end

  def request(search_term, options = {})
    @api_wrapper.process(search_term, options)
    Response.new(@api_wrapper)
  end

  class Response
    attr_reader   :raw_response, :response_hash
    attr_accessor :total_number_of_images, :number_of_images, :images

    def initialize(api_wrapper)
      @api_wrapper  = api_wrapper
      @raw_response = @api_wrapper.response
      parse_api_response!
    end

    delegate :request_params,    to: :@api_wrapper
    delegate :request_query_url, to: :@api_wrapper

    def error_message
      @api_wrapper.error_message || @error_message
    end

    def errors?
      error_message.present?
    end

    def valid?
      !errors?
    end

    def raw_request_body
      request_params.to_json
    end

    def raw_response_body
      raw_response.respond_to?(:body) ? raw_response.body.to_s : nil
    end

    def parse_api_response!
      if valid? && raw_response_body.present?
        @response_hash          = JSON.parse(@raw_response.body)
        @total_number_of_images = @response_hash['totalHits']
        @number_of_images       = @response_hash['hits'].size
        @images                 = @response_hash['hits'].map { |h| Image.from_hash(h) }
      end
    rescue => e
      @error_message = e.message
    end


    def best_image
      images.first
      # ( images.find { |i| i.type == 'vector' }.presence  ||
      #   images.find { |i| i.type == 'clipart' }.presence ||
      #   images.first )
    end

    ImageStruct = Struct.new(:preview_height, :likes, :tags, :model_release,:webformat_height, :views, :webformat_width,
                             :preview_width, :comments, :downloads, :page_url, :preview_url, :webformat_url, :image_width,
                             :user, :type, :id, :image_height)

    class Image < ImageStruct
      def self.from_hash(image_hash)
        image_hash = {}.tap { |h| image_hash.each { |k, v| h[k.underscore] = v } }
        self[*image_hash.values_at(* Image.members.map(&:to_s) )]
      end
    end
  end



  class ApiWrapper
    API_BASE_URL  = 'http://pixabay.com'
    API_END_POINT = '/api/'

    attr_reader :response, :error_message, :request_params, :request_query_url

    def process(search_term, options)
      @response = @error_message = @request_params, @request_query_url = nil
      begin
        sess            = Patron::Session.new
        sess.base_url   = API_BASE_URL
        sess.timeout    = 10
        @request_params = build_request_params(search_term, options)
        @request_query_url = API_END_POINT + '?' + @request_params.to_param
        @response       = sess.get(@request_query_url)
        @error_message  = @response.status_line if @response.status != 200
      rescue => e
        @error_message  = e.message
      end
    end


    def build_request_params(search_term, options)
      { username:       PixabayClient.configuration.username,
        key:            PixabayClient.configuration.key,
        search_term:    search_term,
        image_type:     'all', # "all", "photo", "clipart", "vector"
        min_width:      nil,
        min_height:     nil,
        editors_choice: false,
        orientation:    'all', # "all", "horizontal", "vertical"
        order:          'popular', # "popular", "latest"
        page:           1,
        per_page:       20 }.merge(options).compact
    end
  end

end