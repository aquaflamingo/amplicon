module RepositoriesHelper
  Resource = Struct.new(:display_name, :value)

  def repository_resources
    Repository.resources.map do |k,v|
      Resource.new(k.humanize, k)
    end
  end
end
