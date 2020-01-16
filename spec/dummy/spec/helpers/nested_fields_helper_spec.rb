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

  describe 'add_nested_fields_button' do

    example 'basic' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.add_nested_fields_button :comments, 'add text'
      end

      expect(form).to include("<button type=\"button\"")
      expect(form).to include("onclick=\"NestedFields.add(this)\"")
    end

    example 'text' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.add_nested_fields_button :comments, 'add text'
      end

      expect(form).to include(">add text</button>")
    end

    example 'tag' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.add_nested_fields_button :comments, 'add', tag: :span
      end

      expect(form).to include(">add</span>")
    end

    example 'class' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.add_nested_fields_button :comments, 'add', class: 'foo'
      end

      expect(form).to include("<button class=\"foo\"")
    end

    example 'class (array)' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.add_nested_fields_button :comments, 'add', class: ['foo', 'bar']
      end

      expect(form).to include("<button class=\"foo bar\"")
    end

    context 'block' do

      example 'basic' do
        book = Book.new

        form = form_with(model: book) do |f|
          f.add_nested_fields_button :comments do
            'block'
          end
        end

        expect(form).to include(">block</button>")
      end

      example 'options' do
        book = Book.new

        form = form_with(model: book) do |f|
          f.add_nested_fields_button :comments, tag: :span, class: 'foo' do
            'block'
          end
        end

        expect(form).to include("<span class=\"foo\"")
      end

    end

  end

  describe 'remove_nested_fields_button' do

    example 'basic' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.remove_nested_fields_button 'remove text'
        end
      end

      expect(form).to include("<button type=\"button\"")
      expect(form).to include("onclick=\"NestedFields.remove(this)\"")
    end

    example 'text' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.remove_nested_fields_button 'remove text'
        end
      end

      expect(form).to include(">remove text</button>")
    end

    example 'tag' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.remove_nested_fields_button 'remove', tag: :span
        end
      end

      expect(form).to include(">remove</span>")
    end

    example 'class' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.remove_nested_fields_button 'remove', class: 'foo'
        end
      end

      expect(form).to include("<button class=\"foo\"")
    end

    example 'class (array)' do
      book = Book.new

      form = form_with(model: book) do |f|
        f.nested_fields :comments do |ff|
          ff.remove_nested_fields_button 'remove', class: ['foo', 'bar']
        end
      end

      expect(form).to include("<button class=\"foo bar\"")
    end

    context 'block' do

      example 'basic' do
        book = Book.new

        form = form_with(model: book) do |f|
          f.nested_fields :comments do |ff|
            ff.remove_nested_fields_button do
              'block'
            end
          end
        end

        expect(form).to include(">block</button>")
      end

      example 'options' do
        book = Book.new

        form = form_with(model: book) do |f|
          f.nested_fields :comments do |ff|
            ff.remove_nested_fields_button tag: :span, class: 'foo' do
              'block'
            end
          end
        end

        expect(form).to include("<span class=\"foo\"")
      end

    end

  end

end
