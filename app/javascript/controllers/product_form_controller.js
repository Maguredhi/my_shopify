import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "template", "link" ]

  add_sku(event){
    event.preventDefault();

    // 找正規表示法 NEW_RECORD 字串，用 replace 改成 new 出來的 date time
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    this.linkTarget.insertAdjacentHTML('beforebegin', content);
    console.log(content);
  }

  remove_sku(event){
    event.preventDefault();
    
    let wrapper = event.target.closest('.nested-fields');
    console.log(wrapper);
    if (wrapper.dataset.newTecord == 'true') {
      wrapper.remove();
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1;
      wrapper.style.display = 'none';
    }
  }
}
