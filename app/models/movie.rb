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
	has_and_belongs_to_many :casting, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:actor]) }, class_name: 'Person', join_table: "movies_people"
	has_and_belongs_to_many :directors, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:director]) }, class_name: 'Person', join_table: "movies_people"
	has_and_belongs_to_many :producers, -> { where('movies_people.type_cd = ?', MoviesPerson.types[:producer]) }, class_name: 'Person', join_table: "movies_people"
	validates :title, :release_year, presence: true
end
