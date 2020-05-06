module TrixEditorHelper
  def fill_in_trix_editor(id, value)
    find_trix_editor(id).set(value)
  end

  def find_trix_editor(id)
    find(:xpath, "//*[@id='#{id}']", visible: false)
  end
end
