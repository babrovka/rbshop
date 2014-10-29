ThinkingSphinx::Index.define :order, :with => :active_record do
  indexes id
  indexes name
  indexes email
  indexes phone
  indexes city
  indexes address
  indexes comment
end