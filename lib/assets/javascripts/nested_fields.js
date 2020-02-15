class NestedFields{

  static add(element){
    const {target} = element.dataset
    const template = document.getElementById(`${target}_nested_fields_template`)
    if(this.exceededMaximum(template)){
      return
    }
    template.dataset.next = template.dataset.next || 1000
    const number = template.dataset.next++
    const clone = document.importNode(template.content, true).firstElementChild
    clone.querySelectorAll('[name*="__index__"]').forEach(element => {
      element.name = element.name.replace('__index__', number)
      if(element.id != null){
        element.id = element.id.replace('__index__', number)
      }
    })
    template.parentElement.insertBefore(clone, template)
  }

  static remove(element){
    const wrapper = element.closest('[class$="_nested_fields"]')
    const idElement = wrapper.querySelector('[name$="[id]"]')
    if(idElement == null){
      wrapper.parentElement.removeChild(wrapper)
      return
    }
    wrapper.style.display = 'none'
    const destroy = document.createElement('input')
    destroy.type = 'hidden'
    destroy.name = idElement.name.replace('[id]', '[_destroy]')
    destroy.value = '1'
    wrapper.appendChild(destroy)
  }

  static exceededMaximum(template){
    const maximum = this.getMaximum(template)
    if(maximum == null){
      return false
    }
    const childCount = this.getChildCount(template)
    return maximum <= childCount
  }

  static getMaximum(template){
    const {maximum} = template.dataset
    if(maximum != null){
      return parseInt(maximum)
    }
    return null
  }

  static getChildCount(template){
    return Array.from(template.parentElement.children).filter(element => {
      if(element.tagName === 'TEMPLATE'){
        return false
      }
      const destroy = element.querySelector('input[name$="[_destroy]"][value="1"]')
      return destroy == null
    }).length
  }

}
