class Student < ApplicationRecord
	has_many :score, dependent: :destroy
end
