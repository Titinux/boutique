//= require jquery
//= require jquery_ujs

replace_ids = function(s){
  var new_id = new Date().getTime();
  return s.replace(/NEW_RECORD/g, new_id);
}

function add_nested_form(template_name, container) {
	template = eval(template_name);
	$(container).insert({
      bottom: replace_ids(template)
    });
}

function delete_record(caller, classname) {
	container_css_identifier = 'div[class="' + classname + '"]'
	delete_input_css_identifier = 'input[class="delete_field"]'

	if(container = $(caller).up(container_css_identifier)) {
		if(delete_input = container.down(delete_input_css_identifier)) {
			if (confirm('Are you sure ?')) {
	  		container.hide();
	  		delete_input.value = "1";
	  	}
		}
	}
}
