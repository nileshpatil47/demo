class SmartLabelFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, content_or_options_with_block = nil, options = {}, &block)
    if !block_given?
      # No block, use the standard label helper.
      super(method, content_or_options_with_block, options)
    else
      # We've got a block. This is where we want to do custom shit.
      options = content_or_options_with_block.is_a?(Hash) ? content_or_options_with_block.stringify_keys : {}

      if errors_on?(method)
        (options['class'] = options['class'].to_s + ' error').strip!
      end

      @template.content_tag(:label, options, &block)
    end
  end

  private

  def errors_on?(method)
    @object.respond_to?(:errors) && @object.errors.respond_to?(:on) && @object.errors.on(method.to_sym)
  end
end

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end