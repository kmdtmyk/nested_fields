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

  end

end
