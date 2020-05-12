class Breadcrumbs
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def previous_routes
    @previous_routes ||= extract_previous_routes
  end

  def current_route_name
    @current_route_name ||= humanize_path(path_components.last)
  end

  def to_partial_path
    'breadcrumbs'
  end

  private

  Route = Struct.new(:name, :path)

  def extract_previous_routes
    previous_routes = []
    path_components[0..-2].inject('') do |prev, current|
      previous_routes << Route.new(humanize_path(current),
                                   join_paths(prev, current))
      join_paths(prev, current)
    end
    previous_routes
  end

  def path_components
    @path_components ||= request.path.split('/')[1..-1]
  end

  def join_paths(*paths)
    paths.join('/')
  end

  def humanize_path(path)
    path.humanize.capitalize
  end
end
