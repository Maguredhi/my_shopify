module OrdersHelper
  def state_format(state)
    case state
    when "paid"
      tag.span t('order.paid'), class: 'tag is-success is-medium'
    when "pending" 
      tag.span t('order.pending'), class: 'tag is-warning is-medium'
    when "cancelled"
      tag.span t('order.cancelled'), class: 'tag is-light is-medium'
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
