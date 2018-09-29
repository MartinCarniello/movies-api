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
	as_enum :type, actor: 0, director: 1, producer: 2
	validates :type_cd, :movie_id, :person_id, presence: true
end
