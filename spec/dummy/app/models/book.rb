# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :tags, class_name: 'BookTag', dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  validates_length_of :tags, maximum: 3

  has_many :comments, class_name: 'BookComment', dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
end
