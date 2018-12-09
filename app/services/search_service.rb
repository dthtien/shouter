class SearchService
  def initialize(term:)
    @term = term
  end

  def run
    ShoutSearchQuery.new(term: "%##{term}%").to_relation
  end

  alias results run

  private

  attr_reader :term
end
