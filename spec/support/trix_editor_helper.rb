module TrixEditorHelper
  def fill_in_trix_editor(id, value)
    find(:xpath, "//*[@id='#{id}']", visible: false).set(value)
  end
end

RSpec.configure do |config|
  config.include TrixEditorHelper, type: :feature
end
