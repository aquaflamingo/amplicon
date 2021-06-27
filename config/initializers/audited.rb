ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.class_eval do
    audited
  end
end
