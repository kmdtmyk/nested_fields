# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, class_name: 'BookComment', dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
end
