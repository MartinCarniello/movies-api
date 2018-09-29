# == Schema Information
#
# Table name: movies_people
#
#  id         :integer          not null, primary key
#  type_cd    :integer
#  movie_id   :integer
#  person_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MoviesPerson < ApplicationRecord

	# Type Enum
	as_enum :type, actor: 0, director: 1, producer: 2

	# Validations
	validates :type_cd, :movie_id, :person_id, presence: true

	# Methods
	def as_json(options)
    super(only: [ :id, :movie_id, :person_id ],
    			methods: [ :type ]
    		 )
  end
end
