class Author < ApplicationRecord
  has_many :books, inverse_of: :writer, dependent: :destroy
end
