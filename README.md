# Presence Board

A real-time digital presence board (In/Out Board) designed to replace traditional physical sliders with a responsive web interface. Built with Ruby on Rails 8, featuring real-time updates via ActionCable, a modern Foundation CSS frontend, and comprehensive administrative controls.

## Features

- ✅ **Real-time Status Updates** - Instant updates across all connected clients via WebSockets
- ✅ **Multiple Status Options** - In, Out, Lunch, Meeting, Remote, Sick/Leave with custom notes
- ✅ **Kiosk Mode** - Optimized read-only view for large wall displays with auto-refresh
- ✅ **User Dashboard** - Personal status management interface
- ✅ **Administrative Interface** - Full back office via Active Admin
- ✅ **Search & Filtering** - Find users by name/email and filter by department
- ✅ **User Authentication** - Secure authentication with Devise
- ✅ **RESTful API** - JSON API for programmatic access
- ✅ **Responsive Design** - Works on desktop, tablet, and mobile devices

## Architecture

### System Overview

The application follows a traditional MVC architecture with real-time capabilities:

```
┌─────────────────────────────────────────────────────────┐
│                    Client Browsers                       │
│  (Dashboard, Kiosk Mode, Active Admin)                  │
└──────────────┬──────────────────────────────────────────┘
               │ HTTP/WebSocket
               │
┌──────────────▼──────────────────────────────────────────┐
│              Rails Application Layer                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │  Controllers │  │    Models    │  │    Views     │ │
│  │  (MVC)       │  │  (ActiveRec) │  │  (Slim)      │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ ActionCable  │  │   Devise     │  │ Active Admin │ │
│  │ (Real-time)  │  │ (Auth)       │  │ (Back Office)│ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└──────────────┬──────────────────────────────────────────┘
               │
┌──────────────▼──────────────────────────────────────────┐
│              Database Layer (PostgreSQL)                 │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ │
│  │  Users   │ │ Statuses │ │Departments│ │StatusLogs│ │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Data Model

- **User** - Employees with authentication, department, and current status
- **Status** - Predefined status options (In, Out, Lunch, etc.) with colors and icons
- **Department** - Organizational units for grouping users
- **StatusLog** - Historical record of all status changes

### Real-time Communication

Real-time updates are handled via ActionCable (Solid Cable) using WebSockets:
- When a user updates their status, a broadcast is sent to the `presence` channel
- All connected clients receive the update instantly
- Stimulus controllers handle DOM updates without page refresh

## Technology Stack

### Backend

| Technology | Version | Purpose |
|------------|---------|---------|
| **Ruby** | 3.4.0 | Programming language |
| **Rails** | 8.0.4 | Web framework |
| **PostgreSQL** | 9.3+ | Database |
| **Puma** | ≥5.0 | Web server |
| **Solid Cable** | Latest | ActionCable adapter (database-backed) |
| **Solid Queue** | Latest | Background job processing |
| **Solid Cache** | Latest | Caching layer |

### Frontend

| Technology | Purpose |
|------------|---------|
| **Foundation CSS** | Responsive CSS framework |
| **Stimulus** | JavaScript framework for interactivity |
| **Turbo** | SPA-like page navigation |
| **Slim** | Template engine (concise HTML) |
| **Importmap** | JavaScript module management (no bundler) |

### Authentication & Authorization

| Technology | Purpose |
|------------|---------|
| **Devise** | User authentication |
| **BCrypt** | Password hashing |
| **Active Admin** | Administrative interface |

### Development Tools

| Technology | Purpose |
|------------|---------|
| **Debug** | Interactive debugging |
| **Brakeman** | Security vulnerability scanner |
| **RuboCop** | Code style checker |
| **Web Console** | Browser-based debugging |

### Asset Pipeline

| Technology | Purpose |
|------------|---------|
| **Propshaft** | Modern asset pipeline (no Sprockets) |
| **Importmap Rails** | JavaScript module mapping |

## Project Structure

```
presence-board/
├── app/
│   ├── admin/              # Active Admin resources
│   ├── assets/              # Stylesheets (Foundation CSS)
│   ├── channels/            # ActionCable channels
│   ├── controllers/         # MVC controllers
│   │   ├── api/v1/         # REST API endpoints
│   │   └── users/          # Devise custom controllers
│   ├── javascript/          # Stimulus controllers
│   ├── models/              # ActiveRecord models
│   └── views/              # Slim templates
│       ├── dashboard/      # Main application views
│       ├── devise/         # Authentication views
│       └── layouts/        # Application layouts
├── config/
│   ├── routes.rb           # Application routes
│   ├── importmap.rb        # JavaScript module mapping
│   └── initializers/       # Configuration files
├── db/
│   ├── migrate/            # Database migrations
│   └── seeds.rb           # Seed data
├── test/                   # Test suite (16 test files)
│   ├── fixtures/           # Test data
│   ├── models/             # Model tests
│   ├── controllers/        # Controller tests
│   ├── integration/        # Integration tests
│   └── channels/           # Channel tests
└── .tool-versions          # asdf version file
```

## Setup

### Prerequisites

- [asdf](https://asdf-vm.com/) version manager (recommended)
- PostgreSQL 9.3 or higher
- Ruby 3.4.0

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd presence-board
   ```

2. **Install Ruby using asdf:**
   ```bash
   asdf plugin add ruby
   asdf install
   # This will read .tool-versions and install Ruby 3.4.0
   ```

3. **Install PostgreSQL:**
   
   **macOS (Homebrew):**
   ```bash
   brew install postgresql@14
   brew services start postgresql@14
   ```
   
   **Ubuntu/Debian:**
   ```bash
   sudo apt-get install postgresql postgresql-contrib
   sudo systemctl start postgresql
   ```
   
   **Other systems:** Follow the [PostgreSQL installation guide](https://www.postgresql.org/download/).

4. **Install Ruby dependencies:**
   ```bash
   bundle install
   ```

5. **Set up the database:**
   ```bash
   # Create databases
   rails db:create
   
   # Run migrations
   rails db:migrate
   
   # Seed initial data (statuses, departments, sample users)
   rails db:seed
   ```

6. **Start the Rails server:**
   ```bash
   # Using bin/dev (recommended - starts Rails + asset pipeline)
   bin/dev
   
   # Or separately:
   rails server
   ```

7. **Access the application:**
   - Main application: http://localhost:3000
   - Active Admin: http://localhost:3000/admin
   - Kiosk mode: http://localhost:3000/kiosk

## Default Credentials

After running `rails db:seed`, you can log in with:

- **Admin User:**
  - Email: `admin@example.com`
  - Password: `password`
  - Access: Full access including Active Admin

- **Demo Users (20+ users across 6 departments):**
  - All users have password: `password`
  - Examples:
    - `sarah@example.com` (Engineering - In)
    - `michael@example.com` (Engineering - Meeting)
    - `jessica@example.com` (Sales - In)
    - `amanda@example.com` (Marketing - In)
    - `ryan@example.com` (Design - In)
    - `jennifer@example.com` (HR - In)
    - `rachel@example.com` (Operations - In)
  - Users have varied statuses (In, Out, Lunch, Meeting, Remote, Sick/Leave)
  - Many users have custom notes for realistic demo scenarios

## API Documentation

### Endpoints

#### GET `/api/v1/users`
List all users with their current status.

**Query Parameters:**
- `department_id` (optional) - Filter by department
- `search` (optional) - Search by name or email

**Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "department": "Engineering",
    "avatar_url": null,
    "status": {
      "id": 1,
      "label": "In",
      "color_code": "#2ecc71",
      "icon": "✓"
    },
    "note": null,
    "last_updated": "2024-01-20T10:30:00Z"
  }
]
```

#### PATCH `/api/v1/status`
Update a user's status.

**Parameters:**
- `status_id` (required) - ID of the status
- `note` (optional) - Custom note
- `email` (optional) - Required if not authenticated

**Response:**
```json
{
  "success": true,
  "user": {
    "id": 1,
    "name": "John Doe",
    "status": {
      "id": 2,
      "label": "Out",
      "color_code": "#e74c3c",
      "icon": "✗"
    },
    "note": "Going out for lunch"
  }
}
```

#### GET `/api/v1/config`
Get application configuration (statuses and departments).

**Response:**
```json
{
  "statuses": [
    {
      "id": 1,
      "label": "In",
      "color_code": "#2ecc71",
      "icon": "✓"
    }
  ],
  "departments": [
    {
      "id": 1,
      "name": "Engineering"
    }
  ]
}
```

## Development

### Running Tests

The project includes comprehensive test coverage (16 test files):

```bash
# Run all tests
rails test

# Run specific test categories
rails test test/models/           # Model tests
rails test test/controllers/      # Controller tests
rails test test/integration/       # Integration tests
rails test test/channels/          # Channel tests

# Run specific test files
rails test test/models/user_test.rb
rails test test/integration/status_update_flow_test.rb

# Run tests in parallel (faster)
PARALLEL_WORKERS=4 rails test
```

### Test Coverage

- ✅ **Model Tests** (4 files) - Validations, associations, business logic
- ✅ **Controller Tests** (7 files) - API endpoints, authentication, authorization
- ✅ **Integration Tests** (4 files) - End-to-end user flows
- ✅ **Channel Tests** (1 file) - ActionCable broadcasting

### Code Quality

**Linting:**
```bash
bundle exec rubocop
```

**Security Scanning:**
```bash
bin/brakeman
```

**JavaScript Audit:**
```bash
bin/importmap audit
```

### Database Management

```bash
# Create database
rails db:create

# Run migrations
rails db:migrate

# Rollback last migration
rails db:rollback

# Reset database (⚠️ destroys all data)
rails db:reset

# Open database console
rails dbconsole
```

### Console Access

```bash
# Rails console
rails console

# Create a user
user = User.create!(name: "Test User", email: "test@example.com", password: "password")

# Update status
status = Status.find_by(label: "In")
user.update_status!(status, note: "Working from office")
```

## Deployment

### Environment Variables

Set these in your production environment:

- `RAILS_MASTER_KEY` - Required for encrypted credentials
- `DATABASE_URL` - PostgreSQL connection string
- `SECRET_KEY_BASE` - Rails secret key (auto-generated)

### Database Setup

```bash
# Production database setup
RAILS_ENV=production rails db:create
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails db:seed
```

### Asset Precompilation

```bash
RAILS_ENV=production rails assets:precompile
```

## Routes

### Main Routes
- `GET /` - Dashboard (requires authentication)
- `GET /kiosk` - Kiosk mode (public)
- `GET /dashboard` - Dashboard alias

### Authentication Routes
- `GET /users/sign_in` - Sign in page
- `POST /users/sign_in` - Sign in
- `GET /users/sign_up` - Sign up page
- `POST /users/sign_up` - Create account
- `DELETE /users/sign_out` - Sign out

### Admin Routes
- `GET /admin` - Active Admin dashboard (admin only)

### API Routes
- `GET /api/v1/users` - List users
- `PATCH /api/v1/status` - Update status
- `GET /api/v1/config` - Get configuration

### WebSocket
- `WS /cable` - ActionCable connection

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Ensure all tests pass (`rails test`)
5. Run linters (`bundle exec rubocop`)
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

## License

MIT License - see LICENSE file for details

## Support

For issues, questions, or contributions, please open an issue on the repository.
