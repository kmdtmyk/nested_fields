class NestedFields{

  static add(button){
    const {target} = button.dataset
    const template = this.findTemplate(target)
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

    this.updateAddButton(target)
  }

  static remove(button){
    const wrapper = button.closest('[class$="_nested_fields"]')
    const idElement = wrapper.querySelector('[name$="[id]"]')
    if(idElement == null){
      wrapper.parentElement.removeChild(wrapper)
    }else{
      wrapper.style.display = 'none'
      const destroy = document.createElement('input')
      destroy.type = 'hidden'
      destroy.name = idElement.name.replace('[id]', '[_destroy]')
      destroy.value = '1'
      wrapper.appendChild(destroy)
    }

    const target = this.targetFromClassList(wrapper.classList)
    this.updateAddButton(target)
  }

  static updateAddButton(name){
    const template = this.findTemplate(name)
    const exceeded = this.exceededMaximum(template)
    document.querySelectorAll(`[data-target="${name}"]`).forEach(button => {
      if(exceeded === true){
        button.disabled = true
      }else{
        button.disabled = false
      }
    })
  }

  static targetFromClassList(classList){
    const suffix = '_nested_fields'
    for(const className of classList){
      if(className.endsWith(suffix)){
        return className.slice(0, className.length - suffix.length)
      }
    }
    return null
  }

  static findTemplate(name){
    return document.getElementById(`${name}_nested_fields_template`)
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
