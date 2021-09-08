import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = [ "email" ]

  add(event) {
    event.preventDefault()
    // 頭尾空白去掉 用 trim()
    let email = this.emailTarget.value.trim();
    let data = new FormData();
    data.append("subscribe[email]", email)

    Rails.ajax({
      url: '/api/v1/subscribe',
      data,
      type: 'POST',
      dataType: 'json',
      // Arrow function 用來抓外面的 emailTarget 丟進 this
      success: (response) => {
        switch (response.status) {
          case 'ok':
            alert('完成訂閱')
            this.emailTarget.value = '';
            break;
          case 'duplicated':
            alert(`${response.email} 已經訂閱過囉`)
            break;
        }
        console.log(response);
      },
      error: function(err) {
        console.log(err);
      }
    })
  }
}
