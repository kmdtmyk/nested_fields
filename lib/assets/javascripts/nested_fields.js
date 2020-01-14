class NestedFields{

  static add(element){
    const {target} = element.dataset
    const template = document.getElementById(`${target}_nested_fields_template`)
    template.dataset.next = template.dataset.next | 1000
    const number = ++template.dataset.next
    const clone = document.importNode(template.content, true).firstElementChild
    clone.querySelectorAll('[name*="_attributes][_]"]').forEach(element => {
      element.name = element.name.replace('[_]', `[${number}]`)
    })
    template.parentElement.insertBefore(clone, template)
  }

  static remove(element){
    const parent = this.findParent(element)
    parent.style.display = 'none'
    const idElement = parent.querySelector('[name$="[id]"]')
    if(idElement == null){
      return
    }
    const destroy = document.createElement('input')
    destroy.type = 'hidden'
    destroy.name = idElement.name.replace('[id]', '[_destroy]')
    destroy.value = '1'
    parent.appendChild(destroy)
  }

  static findParent(element){
    const parent = element.parentElement
    if(parent == null){
      return null
    }
    if(parent.className.includes('_nested_fields')){
      return parent
    }
    return this.findParent(parent)
  }

}
