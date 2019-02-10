class Post < ApplicationRecord
  validates_presence_of :date, :rational
end
