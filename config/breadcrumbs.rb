crumb :root do
  link "Главная", root_path
end

crumb :composition do |c|
  if params[:tag_id]
    link "Композиция №#{c.id}", tag_composition_path(c)
    parent :tag, Tag.frienldy.find(params[:tag_id])
  elsif params[:receiver_id]
    link "Композиция №#{c.id}", receiver_composition_path(c)
    parent :receiver, Receiver.frienldy.find(params[:receiver_id])
  end
end

crumb :tag_composition do |tag, c|
end

crumb :tag do |tag|
  link tag.name.capitalize, tag_path(tag)
end

crumb :receiver do |p|
  link p.title.capitalize, receiver_path(p)
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
