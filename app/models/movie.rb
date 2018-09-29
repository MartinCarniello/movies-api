# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string
#  release_year :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Movie < ApplicationRecord

	# Associations
	has_and_belongs_to_many :casting, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:actor]) }, class_name: 'Person', join_table: "movies_people"
	has_and_belongs_to_many :directors, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:director]) }, class_name: 'Person', join_table: "movies_people"
	has_and_belongs_to_many :producers, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:producer]) }, class_name: 'Person', join_table: "movies_people"

	# Validations
	validates :title, :release_year, presence: true

	# Methods
	def release_year_roman
		RomanConverter.romanize(release_year)
	end

	def as_json(options)
    super(only: [ :id, :title ],
    			methods: [ :release_year_roman ],
    			include: { 
    				casting: { only: [ :id, :last_name, :first_name, :aliases ] },
    				directors: { only: [ :id, :last_name, :first_name, :aliases ] },
    				producers: { only: [ :id, :last_name, :first_name, :aliases ] }
    			}
    		 )
  end
end
