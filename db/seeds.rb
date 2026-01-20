# Clear existing data (optional - comment out if you want to preserve data)
# User.destroy_all
# StatusLog.destroy_all
# Status.destroy_all
# Department.destroy_all

puts "🌱 Seeding Presence Board database..."

# Create default statuses
puts "Creating statuses..."
statuses = {
  in: Status.find_or_create_by(label: "In") do |s|
    s.color_code = "#2ecc71"
    s.icon = "✓"
  end,
  out: Status.find_or_create_by(label: "Out") do |s|
    s.color_code = "#e74c3c"
    s.icon = "✗"
  end,
  lunch: Status.find_or_create_by(label: "Lunch") do |s|
    s.color_code = "#f39c12"
    s.icon = "🍽"
  end,
  meeting: Status.find_or_create_by(label: "Meeting") do |s|
    s.color_code = "#3498db"
    s.icon = "📅"
  end,
  remote: Status.find_or_create_by(label: "Remote") do |s|
    s.color_code = "#9b59b6"
    s.icon = "🏠"
  end,
  sick: Status.find_or_create_by(label: "Sick/Leave") do |s|
    s.color_code = "#95a5a6"
    s.icon = "🏥"
  end
}

# Create departments
puts "Creating departments..."
departments = {
  engineering: Department.find_or_create_by(name: "Engineering"),
  sales: Department.find_or_create_by(name: "Sales"),
  hr: Department.find_or_create_by(name: "Human Resources"),
  marketing: Department.find_or_create_by(name: "Marketing"),
  design: Department.find_or_create_by(name: "Design"),
  operations: Department.find_or_create_by(name: "Operations")
}

# Create admin user
puts "Creating admin user..."
admin = User.find_or_create_by(email: "admin@example.com") do |u|
  u.name = "Admin User"
  u.password = "password"
  u.password_confirmation = "password"
  u.role = "admin"
  u.department = departments[:engineering]
  u.current_status = statuses[:in]
  u.current_note = "Managing the team"
end

# Create status log for admin
if admin.status_logs.empty?
  StatusLog.create!(
    user: admin,
    status: statuses[:in],
    note: "Managing the team",
    created_at: 2.hours.ago
  )
end

# Create demo users with varied statuses and realistic data
puts "Creating demo users..."
demo_users = [
  # Engineering Team
  {
    name: "Sarah Chen",
    email: "sarah@example.com",
    department: departments[:engineering],
    status: statuses[:in],
    note: "Working on API improvements",
    avatar_url: nil
  },
  {
    name: "Michael Rodriguez",
    email: "michael@example.com",
    department: departments[:engineering],
    status: statuses[:meeting],
    note: "Sprint planning until 3 PM",
    avatar_url: nil
  },
  {
    name: "Emily Watson",
    email: "emily@example.com",
    department: departments[:engineering],
    status: statuses[:remote],
    note: "Working from home today",
    avatar_url: nil
  },
  {
    name: "David Kim",
    email: "david@example.com",
    department: departments[:engineering],
    status: statuses[:lunch],
    note: "Back at 1:30 PM",
    avatar_url: nil
  },
  {
    name: "Alex Thompson",
    email: "alex@example.com",
    department: departments[:engineering],
    status: statuses[:out],
    note: "Client site visit",
    avatar_url: nil
  },

  # Sales Team
  {
    name: "Jessica Martinez",
    email: "jessica@example.com",
    department: departments[:sales],
    status: statuses[:in],
    note: "Available for calls",
    avatar_url: nil
  },
  {
    name: "Robert Taylor",
    email: "robert@example.com",
    department: departments[:sales],
    status: statuses[:meeting],
    note: "Demo call with potential client",
    avatar_url: nil
  },
  {
    name: "Lisa Anderson",
    email: "lisa@example.com",
    department: departments[:sales],
    status: statuses[:out],
    note: "On-site meeting",
    avatar_url: nil
  },
  {
    name: "James Wilson",
    email: "james@example.com",
    department: departments[:sales],
    status: statuses[:remote],
    note: "Working remotely",
    avatar_url: nil
  },

  # Marketing Team
  {
    name: "Amanda Lee",
    email: "amanda@example.com",
    department: departments[:marketing],
    status: statuses[:in],
    note: "Working on campaign launch",
    avatar_url: nil
  },
  {
    name: "Chris Brown",
    email: "chris@example.com",
    department: departments[:marketing],
    status: statuses[:meeting],
    note: "Content strategy session",
    avatar_url: nil
  },
  {
    name: "Nicole Garcia",
    email: "nicole@example.com",
    department: departments[:marketing],
    status: statuses[:lunch],
    note: nil,
    avatar_url: nil
  },

  # Design Team
  {
    name: "Ryan O'Connor",
    email: "ryan@example.com",
    department: departments[:design],
    status: statuses[:in],
    note: "Designing new UI components",
    avatar_url: nil
  },
  {
    name: "Maya Patel",
    email: "maya@example.com",
    department: departments[:design],
    status: statuses[:remote],
    note: "Working from home",
    avatar_url: nil
  },

  # HR Team
  {
    name: "Jennifer White",
    email: "jennifer@example.com",
    department: departments[:hr],
    status: statuses[:in],
    note: "Available for questions",
    avatar_url: nil
  },
  {
    name: "Kevin Davis",
    email: "kevin@example.com",
    department: departments[:hr],
    status: statuses[:meeting],
    note: "Interview session",
    avatar_url: nil
  },

  # Operations Team
  {
    name: "Rachel Green",
    email: "rachel@example.com",
    department: departments[:operations],
    status: statuses[:in],
    note: "Managing daily operations",
    avatar_url: nil
  },
  {
    name: "Tom Jackson",
    email: "tom@example.com",
    department: departments[:operations],
    status: statuses[:out],
    note: "Vendor meeting",
    avatar_url: nil
  },

  # Special cases
  {
    name: "Patricia Moore",
    email: "patricia@example.com",
    department: departments[:engineering],
    status: statuses[:sick],
    note: "Out sick today",
    avatar_url: nil
  }
]

demo_users.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email]) do |u|
    u.name = user_data[:name]
    u.password = "password"
    u.password_confirmation = "password"
    u.role = "user"
    u.department = user_data[:department]
    u.current_status = user_data[:status]
    u.current_note = user_data[:note]
    u.avatar_url = user_data[:avatar_url]
  end

  # Update existing users to ensure they have current status
  unless user.current_status == user_data[:status]
    user.update!(
      current_status: user_data[:status],
      current_note: user_data[:note],
      department: user_data[:department]
    )
  end

  # Create status log entries with realistic timestamps
  if user.status_logs.empty? || user.status_logs.last.status != user.current_status
    # Create a few historical logs for each user
    statuses_array = statuses.values
    time_offsets = [30.minutes.ago, 2.hours.ago, 1.day.ago, 3.days.ago]

    time_offsets.each_with_index do |time_offset, index|
      historical_status = index == 0 ? user.current_status : statuses_array.sample
      StatusLog.create!(
        user: user,
        status: historical_status,
        note: index == 0 ? user.current_note : nil,
        created_at: time_offset
      )
    end
  end
end

# Create some additional status logs for more history
puts "Creating status history..."
User.where.not(email: "admin@example.com").limit(10).each do |user|
  next if user.status_logs.count > 5

  # Add a few more random status changes in the past week
  3.times do
    random_status = statuses.values.sample
    random_time = rand(1..7).days.ago + rand(0..23).hours + rand(0..59).minutes

    StatusLog.create!(
      user: user,
      status: random_status,
      note: ["Working on project", "In a meeting", "Available", nil].sample,
      created_at: random_time
    )
  end
end

# Summary
puts "\n✅ Seeding complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📊 Statistics:"
puts "   • Statuses: #{Status.count}"
puts "   • Departments: #{Department.count}"
puts "   • Users: #{User.count} (#{User.where(role: 'admin').count} admin, #{User.where(role: 'user').count} regular)"
puts "   • Status Logs: #{StatusLog.count}"
puts "\n🔐 Demo Credentials:"
puts "   • Admin: admin@example.com / password"
puts "   • Any user: [email]@example.com / password"
puts "\n📈 Status Distribution:"
Status.all.each do |status|
  count = User.where(current_status: status).count
  puts "   • #{status.label}: #{count} user#{'s' if count != 1}"
end
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
