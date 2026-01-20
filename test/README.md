# Test Suite

This directory contains the comprehensive test suite for the Presence Board application.

## Test Structure

```
test/
├── fixtures/          # Test data (users, statuses, departments, etc.)
├── models/            # Model unit tests
├── controllers/       # Controller tests
│   ├── api/v1/       # API endpoint tests
│   └── users/        # Devise controller tests
├── channels/         # ActionCable channel tests
├── integration/      # End-to-end flow tests
└── test_helper.rb    # Test configuration and helpers
```

## Running Tests

### Run all tests
```bash
rails test
```

### Run specific test categories
```bash
# Model tests only
rails test test/models/

# Controller tests only
rails test test/controllers/

# Integration tests only
rails test test/integration/

# Channel tests only
rails test test/channels/
```

### Run specific test files
```bash
rails test test/models/user_test.rb
rails test test/controllers/dashboard_controller_test.rb
```

### Run with verbose output
```bash
rails test --verbose
```

## Test Coverage

### Models (4 test files)
- `user_test.rb` - User model validations, associations, and status update logic
- `status_test.rb` - Status model validations and associations
- `department_test.rb` - Department model validations and associations
- `status_log_test.rb` - StatusLog model validations and associations

### Controllers (7 test files)
- `dashboard_controller_test.rb` - Dashboard access, filtering, and search
- `api/v1/users_controller_test.rb` - Users API endpoint with filtering
- `api/v1/status_controller_test.rb` - Status update API with authorization
- `api/v1/config_controller_test.rb` - Config API endpoint
- `users/sessions_controller_test.rb` - Sign in/out redirects
- `users/registrations_controller_test.rb` - User registration flow

### Integration Tests (4 test files)
- `user_authentication_test.rb` - Complete authentication flow
- `status_update_flow_test.rb` - End-to-end status update process
- `search_and_filter_test.rb` - Search and department filtering
- `admin_access_test.rb` - Admin authorization and Active Admin access

### Channels (1 test file)
- `presence_channel_test.rb` - ActionCable broadcasting and subscriptions

## Test Fixtures

Fixtures provide test data for:
- **Users**: Admin user, regular users (john, jane, bob)
- **Departments**: Engineering, Sales, HR, Marketing
- **Statuses**: In, Out, Lunch, Meeting, Remote, Sick/Leave
- **Status Logs**: Sample status history entries

## Writing New Tests

When adding new features, ensure you:

1. Add model tests for validations and associations
2. Add controller tests for new endpoints
3. Add integration tests for user flows
4. Update fixtures if new test data is needed
5. Run the full test suite before committing

## Continuous Integration

The test suite is designed to run in CI environments. Tests run in parallel by default for faster execution.
