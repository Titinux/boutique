every 12.hours do
  rake "db:sessions:prune"
  rake "logs:prune"
end
