# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  last_name  :string
#  first_name :string
#  aliases    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord
	has_and_belongs_to_many :performances, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:actor]) }, class_name: 'Movie', join_table: "movies_people"
	has_and_belongs_to_many :directions, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:director]) }, class_name: 'Movie', join_table: "movies_people"
	has_and_belongs_to_many :productions, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:producer]) }, class_name: 'Movie', join_table: "movies_people"
	validates :last_name, :first_name, :aliases, presence: true

	def as_json(options)
    super(only: [ :id, :last_name, :first_name, :aliases ], 
    			include: { 
    				performances: { only: [ :id, :title ], methods: [ :release_year_roman ] },
    				directions: { only: [ :id, :title ], methods: [ :release_year_roman ] },
    				productions: { only: [ :id, :title ], methods: [ :release_year_roman ] }
    			}
    		 )
  end
end
