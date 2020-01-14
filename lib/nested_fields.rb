# frozen_string_literal: true

require 'nested_fields/engine'
require 'nested_fields/version'

module NestedFields
  # Your code goes here...
end

module ActionView::Helpers

  class FormBuilder

    def nested_fields(name, &block)

      output = ActiveSupport::SafeBuffer.new

      object.send(name).each do |child|
        output << @template.content_tag(:div, class: "#{name}_nested_fields") do
          fields_for_nested_model("#{object_name}[#{name}_attributes][#{options[:child_index]}]", child, options, block)
        end
      end

      output << @template.content_tag(:template, id: "#{name}_nested_fields_template") do
        @template.content_tag(:div, class: "#{name}_nested_fields") do
          @template.fields_for("#{object_name}[#{name}_attributes][_]", object, options, &block)
        end
      end

      output
    end

    def add_nested_fields_button(name, text = nil, &block)
      @template.content_tag(:button, type: 'button', 'data-target': name, onclick: 'NestedFields.add(this)') do
        if block_given?
          yield block
        else
          text
        end
      end
    end

    def remove_nested_fields_button(text = nil, &block)
      @template.content_tag(:button, type: 'button', onclick: 'NestedFields.remove(this)') do
        if block_given?
          yield block
        else
          text
        end
      end
    end

  end

end
