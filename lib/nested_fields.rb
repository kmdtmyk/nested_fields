# frozen_string_literal: true

require 'nested_fields/engine'
require 'nested_fields/version'

module NestedFields
  # Your code goes here...

  module_function

  def maximum_length(object, name)
    validator = object.class.validators.find do |validator|
      validator.attributes.include?(name)
    end

    validator&.options&.fetch(:maximum)
  end

end

module ActionView::Helpers

  class FormBuilder

    def nested_fields(name, options = nil, &block)
      nested_fields_for(name, object.send(name), options, &block)
    end

    def nested_fields_for(name, record_object, options = nil, &block)
      options ||= {}

      tag = options.delete(:tag){ :div }

      options[:class] = Array.wrap(options[:class])
      options[:class].prepend "#{name}_nested_fields"

      output = ActiveSupport::SafeBuffer.new

      record_object.each do |child|
        output << @template.content_tag(tag, options) do
          child_index = nested_child_index(name)
          fields_for_nested_model("#{object_name}[#{name}_attributes][#{child_index}]", child, self.options, block)
        end
      end

      maximum = NestedFields.maximum_length(object, name)

      output << @template.content_tag(:template, id: "#{name}_nested_fields_template", data: { maximum: maximum} ) do
        @template.content_tag(tag, options) do
          @template.fields_for("#{object_name}[#{name}_attributes][__index__]", nil, self.options, &block)
        end
      end

      output
    end

    def add_nested_fields_button(name, text = nil, options = nil, &block)
      if block_given?
        return add_nested_fields_button name, yield(block), text
      end

      options ||= {}

      tag = options.delete(:tag){ :button }

      if tag == :button
        options[:type] = 'button'
      end

      options['data-target'] = name
      options[:onclick] = 'NestedFields.add(this)'

      maximum = NestedFields.maximum_length(object, name)

      if maximum.present? && maximum <= object.send(name).size
        options[:disabled] = true
      end

      @template.content_tag(tag, options) do
        text
      end
    end

    def remove_nested_fields_button(text = nil, options = nil, &block)
      if block_given?
        return remove_nested_fields_button yield(block), text
      end

      options ||= {}

      tag = options.delete(:tag){ :button }

      if tag == :button
        options[:type] = 'button'
      end

      options[:onclick] = 'NestedFields.remove(this)'

      @template.content_tag(tag, options) do
        text
      end
    end

  end

end
