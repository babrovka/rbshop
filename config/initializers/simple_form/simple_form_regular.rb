# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.wrappers :regular, tag: 'div', class: 'form__row', error_class: 'm-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label

    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'form__error' }
    b.use :hint, wrap_with: { tag: 'p', class: 'form__help' }
  end

end
