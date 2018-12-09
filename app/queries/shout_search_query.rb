class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    Shout
      .joins(
        <<-SQL
          LEFT JOIN text_shouts
          ON shouts.content_id = text_shouts.id
          AND shouts.content_type = 'TextShout'
        SQL
      ).where('text_shouts.body iLIKE ?', term)
  end

  private

  attr_reader :term
end
