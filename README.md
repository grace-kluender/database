# Database (PostgreSQL Initialization)

This repository contains the PostgreSQL schema and seed data for the microservices-based e-commerce platform.

The database supports:
- Product Service (product catalog)
- Order Service (order management)

At this stage (Phase 1), this repository provides version-controlled database structure and sample data.

---

## Repository Contents

- `src/init.sql` — SQL script that:
  - Creates required tables
  - Defines relationships
  - Inserts sample product data

---

## Schema Overview

### Products Table

The `products` table stores catalog items.

| Column      | Type              | Description |
|-------------|------------------|-------------|
| id          | SERIAL (PK)       | Unique product identifier |
| name        | VARCHAR(255)      | Product name |
| price       | DECIMAL(10,2)     | Product price |
| description | TEXT              | Product description |
| created_at  | TIMESTAMP         | Auto-generated creation timestamp |

---

### Orders Table

The `orders` table stores customer orders.

| Column       | Type              | Description |
|--------------|------------------|-------------|
| id           | SERIAL (PK)       | Unique order identifier |
| product_id   | INTEGER (FK)      | References `products(id)` |
| quantity     | INTEGER           | Quantity ordered (default: 1) |
| total_price  | DECIMAL(10,2)     | Calculated total price |
| status       | VARCHAR(50)       | Order status (default: `pending`) |
| created_at   | TIMESTAMP         | Auto-generated creation timestamp |

---

## Relationships

- `orders.product_id` references `products.id`
- Referential integrity is enforced via a foreign key constraint

---

## Seed Data

The script inserts five sample products:

- Laptop — 999.99
- Mouse — 29.99
- Keyboard — 79.99
- Monitor — 299.99
- Headphones — 149.99

This allows backend services to be tested immediately without manual data entry.

---

## How It Will Be Used (Future Phases)

In later phases, this SQL file will be used to initialize PostgreSQL in:

- Local development (Docker Compose)
- Kubernetes deployments (mounted as an initialization script)

---

## Git Workflow (Git Flow)

This repository follows the Git Flow branching model:

- `main` — production-ready releases
- `develop` — integration branch
- `feature/*` — schema or seed data updates
- `release/*` — release preparation
- `hotfix/*` — urgent fixes

Protected branches prevent direct pushes to `main` and `develop`. All changes must be merged via pull requests.
