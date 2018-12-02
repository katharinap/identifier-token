# frozen_string_literal: true

# form builder wrapper that adds bootstrap classes
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    super(method, text, insert_class('control-label', options), &block)
  end

  def text_field(method, options = {})
    super(method, insert_class('form-control', options))
  end

  def select(method, choices, options = {}, html_options = {})
    super(method, choices, options, insert_class('form-control', html_options))
  end

  def submit(value = nil, options = {})
    super(value, insert_class('btn btn-primary', options))
  end

  def group(method, &block)
    class_names = if object.errors.key?(method)
                    'form-group has-error'
                  else
                    'form-group'
                  end

    content = @template.capture(&block)

    %(<div class="#{class_names}">#{content}</div>).html_safe
  end

  private

  def insert_class(class_name, options)
    output = options.dup
    output[:class] = ((output[:class] || '') + " #{class_name}").strip
    output
  end
end
