# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# ---------- ORG ----------
org = Org.find_or_create_by!(name: "Acme Corp") do |o|
  o.status = "active"
end

# ---------- ADMIN ----------
admin = User.find_or_create_by!(email: "admin@acme.com") do |u|
  u.name = "Acme Admin"
  u.org_id = org.id
  u.role = 1
  u.password = "password123"
  u.password_confirmation = "password123"
end

# ---------- USERS ----------
3.times do |i|
  User.find_or_create_by!(email: "user#{i + 1}@acme.com") do |u|
    u.name = "Acme User #{i + 1}"
    u.org_id = org.id
    u.role = 0
    u.password = "password123"
    u.password_confirmation = "password123"
  end
end

# ---------- RULES ----------
rules = [
  { key: "max_posts", rule_type: "integer", description: "Maximum blog posts allowed" },
  { key: "can_comment", rule_type: "boolean", description: "Can comment on blogs" }
]

rules.each do |r|
  Rule.find_or_create_by!(key: r[:key]) do |rule|
    rule.rule_type = r[:rule_type]
    rule.description = r[:description]
  end
end

# ---------- ORG RULES ----------
Rule.find_each do |rule|
  OrgRule.find_or_create_by!(org_id: org.id, rule_id: rule.id) do |orule|
    orule.enabled = true
    orule.value =
      case rule.rule_type
      when "integer" then 10
      when "boolean" then true
      else nil
      end
  end
end

# ---------- BLOGS ----------
User.where(org_id: org.id).each_with_index do |user, idx|
  Blog.find_or_create_by!(title: "Blog #{idx + 1} by #{user.name}") do |b|
    b.body = "This is a seeded blog post by #{user.name}"
    b.org_id = org.id
  end
end
