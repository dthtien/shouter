class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    Shout.search(term).results
  end

  private

  attr_reader :term, :scope

  def matching_shout_for_text_shout
    Shout.joins(
      <<-SQL
        LEFT JOIN text_shouts
        ON shouts.content_id = text_shouts.id
        AND shouts.content_type = 'TextShout'
      SQL
    ).where('text_shouts.body iLIKE ?', term)
  end

  def matching_shout_for_photo_shout
    Shout.joins(
      <<-SQL
        LEFT JOIN text_shouts
        ON shouts.content_id = text_shouts.id
        AND shouts.content_type = 'TextShout'
      SQL
    ).where('text_shouts.body iLIKE ?', term)
  end
end
