module InvoicesHelper
  
  def add_invoice_labours_link(form_builder)
    link_to_function( 'add a labour entry', { :class => 'button add'  } ) do |page|
      form_builder.semantic_fields_for :invoice_labours, InvoiceLabour.new, :child_index => 'NEW_RECORD' do |f|
        html = render( :partial => 'invoice_labours_form', :locals => { :f => f } )
        page << "$('invoice_labours').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  
  def remove_invoice_labours_link(form_builder)
    if form_builder.object.new_record?
      # If the es cell is a new record, we can just remove from the dom
      link_to_function( "remove", { :class => 'button remove' } ) do |page|
        page << "$(this).up('tr.labour').remove();"
      end
    else
      # However if it's a "real" record it has to be deleted from the database,
      # for this reason the new fields_for, accept_nested_attributes helpers give us _destroy,
      # a virtual attribute that tells rails to delete the child record.
      form_elm = form_builder.hidden_field(:_destroy)
      link_elm = link_to_function("remove", { :class => 'button remove' } ) do |page|
        page << "$(this).up('tr.labour').hide();"
        page << "$(this).previous().value = '1';"
      end
      
      return form_elm + link_elm
    end
  end
  
  def add_invoice_parts_link(form_builder)
    link_to_function( 'add a part entry', { :class => 'button add'  } ) do |page|
      form_builder.semantic_fields_for :invoice_parts, InvoicePart.new, :child_index => 'NEW_RECORD' do |f|
        html = render( :partial => 'invoice_parts_form', :locals => { :f => f } )
        page << "$('invoice_parts').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  
  def remove_invoice_parts_link(form_builder)
    if form_builder.object.new_record?
      # If the es cell is a new record, we can just remove from the dom
      link_to_function( "remove", { :class => 'button remove' } ) do |page|
        page << "$(this).up('tr.part').remove();"
      end
    else
      # However if it's a "real" record it has to be deleted from the database,
      # for this reason the new fields_for, accept_nested_attributes helpers give us _destroy,
      # a virtual attribute that tells rails to delete the child record.
      form_elm = form_builder.hidden_field(:_destroy)
      link_elm = link_to_function("remove", { :class => 'button remove' } ) do |page|
        page << "$(this).up('tr.part').hide();"
        page << "$(this).previous().value = '1';"
      end
      
      return form_elm + link_elm
    end
  end
  
end
