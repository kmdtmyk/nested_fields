# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'nested_fields' do

    example 'no options' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
        end
      end

      expect(form).to include("div class=\"comments_nested_fields\"")
    end

    example 'tag' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments, tag: :span do |ff|
        end
      end

      expect(form).to include("span class=\"comments_nested_fields\"")
    end

    example 'class' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments, class: 'foo' do |ff|
        end
      end

      expect(form).to include("div class=\"comments_nested_fields foo\"")
    end

    example 'class (array)' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments, class: ['foo', 'bar'] do |ff|
        end
      end

      expect(form).to include("div class=\"comments_nested_fields foo bar\"")
    end

    example 'nested form' do
      book = Book.new
      book.comments.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.text_field :content
        end
      end

      expect(form).to include("input type=\"text\" name=\"book[comments_attributes][0][content]\"")
    end

  end

end
