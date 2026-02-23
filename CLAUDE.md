# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Treebook is a Facebook-like social network clone built with Rails 6.0.6.1 and Ruby 2.7.8. It features user authentication, friendships with a state machine, status updates, photo albums, activity feeds, OAuth login, and an admin panel.

## Development Commands

### Docker (recommended)

```bash
docker-compose up                              # Start db + web services
docker-compose exec web bundle exec rails db:migrate
docker-compose exec web bundle exec rails db:seed
docker-compose exec web bundle exec rails console
```

Access the app at `http://localhost:3001` (mapped from container port 3000).

### Without Docker

```bash
bundle install
rails db:migrate
rails server
```

Requires a running PostgreSQL instance and `DATABASE_URL` set in the environment.

### Testing

```bash
bundle exec rspec                              # Run full test suite
bundle exec rspec spec/models/user_spec.rb    # Run a single file
bundle exec rspec spec/models/user_spec.rb:42 # Run a single example
docker-compose exec web bundle exec rspec     # Run via Docker
```

### Other Useful Commands

```bash
bundle exec rails routes                      # List all routes
bundle exec guard                             # Auto-run tests on file changes
```

## Architecture

### Key Patterns

- **Views**: All templates use HAML (`.html.haml`), not ERB.
- **Decorators**: Draper decorators in `app/decorators/` handle view-specific logic for `UserFriendship`, `Album`, `Picture`, and `Activity`.
- **Pagination**: `will_paginate` is used throughout; `Status` paginates at 25/page, `Activity` at 5/page.
- **File Uploads**: Paperclip handles user avatars, album pictures, and status documents. Images are stored with styles: `large`, `medium`, `small`, `thumb`.
- **Background Jobs**: `ApplicationJob` base class exists; no active jobs are implemented yet.

### Authentication & Authorization

Devise handles authentication with custom `RegistrationsController` and `OmniauthCallbacksController`. OAuth providers: Twitter, Facebook, Instagram, Google OAuth2. OAuth identities are stored in the `identities` table via `Identity` model.

The `ApplicationController` rescues `ActiveRecord::RecordNotFound` with a 404 and restricts admin routes via `authenticate_admin_user!`.

### Friendship System

`UserFriendship` uses `state_machines-activerecord` with states: `pending` → `requested` → `accepted` or `blocked`. Friendships are bidirectional — `UserFriendship.request(user1, user2)` creates two mirrored records. After-transition callbacks send emails and update both records.

### Activity Feed

`Activity` has a polymorphic `trackable` association. Activities are created in controllers (statuses, pictures, friendships) and displayed via type-specific partials in `app/views/activities/`. The `for_user(user)` scope returns friends' activities.

### Routing

- Profiles use `profile_name` as the URL slug (`:id` maps to profile name via `to_param`).
- Albums are nested under profiles: `/:profile_name/albums/:album_id/pictures`.
- Blog is a read-only namespace: `/blog/articles`.
- Admin panel at `/admin` (ActiveAdmin).
- Statuses feed aliased as `/feed`.

### Database

PostgreSQL via the `DATABASE_URL` environment variable. Docker Compose sets this to `postgresql://postgres@db:5432/treebook_development`. The test environment uses `treebook_test`.

### Environment Variables

- `DATABASE_URL` — PostgreSQL connection string (required)
- `RAILS_ENV` — defaults to `development`
- `DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL` — set to `'true'` in Docker for test isolation

## Current State

The project is on the `feature/upgrade` branch, having been upgraded from Rails 4.2 through 6.0 and Ruby 2.3 through 2.7. The `new_framework_defaults_6_0.rb` initializer and an Active Storage foreign key migration are pending review. The deleted `app/views/blog/articles/_meta.html.haml` has a `.bak` backup.
