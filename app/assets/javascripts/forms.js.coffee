window.Boutique ||= {}

Boutique.add_nested_form = (template_id, container_id) ->
  tpl = $(template_id).tmpl { new_id: new Date().getTime() }

  $(container_id).append tpl

Boutique.remove_fields = (caller, container_id) ->
  container = $(caller).closest(container_id)

  if container.length == 1
    delete_input = container.find('input.remove_fields')

    if delete_input.length == 1
      if confirm('Are you sure ?')
        delete_input.attr('value', 'true')
        container.hide()
    else
      container.remove()
