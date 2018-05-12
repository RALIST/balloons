if Rails.env.development?
  ActiveRecordQueryTrace.enabled = true
  ActiveRecordQueryTrace.level = :rails
  ActiveRecordQueryTrace.colorize = 35
end
