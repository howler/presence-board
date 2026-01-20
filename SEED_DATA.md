# Seed Data Guide

This document describes the demo seed data created by `rails db:seed`.

## Overview

The seed script creates a comprehensive demo environment with:
- **6 Status Types**: In, Out, Lunch, Meeting, Remote, Sick/Leave
- **6 Departments**: Engineering, Sales, Marketing, Design, HR, Operations
- **20+ Demo Users**: Distributed across departments with varied statuses
- **Status History**: Realistic status logs with timestamps

## Departments

1. **Engineering** - 6 users (largest team)
2. **Sales** - 4 users
3. **Marketing** - 3 users
4. **Design** - 2 users
5. **Human Resources** - 2 users
6. **Operations** - 2 users

## Demo Users

### Engineering Team
- **Sarah Chen** (`sarah@example.com`) - In - "Working on API improvements"
- **Michael Rodriguez** (`michael@example.com`) - Meeting - "Sprint planning until 3 PM"
- **Emily Watson** (`emily@example.com`) - Remote - "Working from home today"
- **David Kim** (`david@example.com`) - Lunch - "Back at 1:30 PM"
- **Alex Thompson** (`alex@example.com`) - Out - "Client site visit"
- **Patricia Moore** (`patricia@example.com`) - Sick/Leave - "Out sick today"

### Sales Team
- **Jessica Martinez** (`jessica@example.com`) - In - "Available for calls"
- **Robert Taylor** (`robert@example.com`) - Meeting - "Demo call with potential client"
- **Lisa Anderson** (`lisa@example.com`) - Out - "On-site meeting"
- **James Wilson** (`james@example.com`) - Remote - "Working remotely"

### Marketing Team
- **Amanda Lee** (`amanda@example.com`) - In - "Working on campaign launch"
- **Chris Brown** (`chris@example.com`) - Meeting - "Content strategy session"
- **Nicole Garcia** (`nicole@example.com`) - Lunch

### Design Team
- **Ryan O'Connor** (`ryan@example.com`) - In - "Designing new UI components"
- **Maya Patel** (`maya@example.com`) - Remote - "Working from home"

### HR Team
- **Jennifer White** (`jennifer@example.com`) - In - "Available for questions"
- **Kevin Davis** (`kevin@example.com`) - Meeting - "Interview session"

### Operations Team
- **Rachel Green** (`rachel@example.com`) - In - "Managing daily operations"
- **Tom Jackson** (`tom@example.com`) - Out - "Vendor meeting"

## Admin User

- **Admin User** (`admin@example.com`) - In - "Managing the team"
  - Password: `password`
  - Full access including Active Admin

## All User Passwords

All demo users have the password: **`password`**

## Status Distribution

The seed data creates users with varied statuses to demonstrate:
- ✅ Multiple users "In" (most common)
- 📅 Users in "Meeting" with notes about meeting times
- 🍽 Users at "Lunch" 
- 🏠 Users working "Remote"
- ✗ Users "Out" with reasons
- 🏥 One user "Sick/Leave"

## Status History

Each user has 4-7 status log entries with realistic timestamps:
- Most recent: 30 minutes ago (current status)
- Recent: 2 hours ago
- Yesterday: 1 day ago
- Last week: 3-7 days ago

## Demo Scenarios

### Scenario 1: Show Real-time Updates
1. Log in as `sarah@example.com` / `password`
2. Change status to "Meeting" with note "Team standup"
3. Open kiosk mode in another browser
4. Watch the status update in real-time

### Scenario 2: Department Filtering
1. Log in and view dashboard
2. Filter by "Engineering" department
3. See 6 engineering team members
4. Filter by "Sales" to see 4 sales team members

### Scenario 3: Search Functionality
1. Search for "Sarah" to find Sarah Chen
2. Search for "michael" to find Michael Rodriguez
3. Search by email "jessica@example.com"

### Scenario 4: Admin Management
1. Log in as `admin@example.com` / `password`
2. Access Active Admin at `/admin`
3. View all users, departments, statuses
4. Update any user's status from admin panel

### Scenario 5: Kiosk Mode
1. Navigate to `/kiosk` (no login required)
2. View all users in large, readable format
3. See real-time updates as users change status
4. Perfect for wall displays

## Resetting Seed Data

To reset and reseed:

```bash
rails db:reset
# or
rails db:drop db:create db:migrate db:seed
```

## Customizing Seed Data

Edit `db/seeds.rb` to:
- Add more users
- Change status distributions
- Modify department assignments
- Add custom notes
- Adjust status history
