module OrdersHelper
  def state_format(state)
    case state
    when "paid"
      tag.div class: 'tags has-addons' do
        concat(tag.span t('order.paid'), class: 'tag is-success is-medium')
        concat(tag.span t('order.back_order'), class: 'tag is-success is-light is-medium')
      end
    when "pending" 
      tag.span t('order.pending'), class: 'tag is-warning is-medium'
    when "cancelled"
      tag.span t('order.cancelled'), class: 'tag is-dark is-medium'
    else
    end
  end

  def payment_format(payment)
    case payment
    when "linepay"
      tag.span 'LINE Pay', class: 'tag is-success is-medium'
    when "paypal" 
      tag.span 'PayPal', class: 'tag is-info is-medium'
    else
    end
  end
end
