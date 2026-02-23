# Repository Guidelines

## Project Structure & Module Organization
- `account/`, `catalog/`, `order/`: Go microservices with `cmd/<service>/main.go` entrypoints, `service.go` business logic, `repository.go` data access, and `server.go` gRPC server wiring.
- `graphql/`: GraphQL gateway (`main.go`, `schema.graphql`, `*_resolver.go`).
- `*/pb/` and `graphql/generated.go`: generated code (do not edit by hand).
- `docker-compose.yaml`: local orchestration and service wiring.

## Build, Test, and Development Commands
- Start backing stores (Postgres + Elasticsearch):
  - `docker-compose up -d account_db catalog_db order_db`
- Regenerate protobuf stubs:
  - `cd account && protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative account.proto`
  - Repeat for `catalog/catalog.proto` and `order/order.proto`.
- Run services locally:
  - `cd account && go run cmd/account/main.go`
  - `cd catalog && go run cmd/catalog/main.go`
  - `cd order && go run cmd/order/main.go`
  - `cd graphql && go run main.go`
- GraphQL Playground: `http://localhost:8000/playground`

## Coding Style & Naming Conventions
- Go standard formatting (`gofmt`) and idiomatic naming:
  - Exported identifiers: `PascalCase`
  - Unexported: `camelCase`
  - Packages: short, lowercase (`account`, `catalog`)
- Avoid editing generated files in `*/pb/` and `graphql/generated.go`.

## Testing Guidelines
- No test suite is present yet (no `*_test.go` files found).
- When adding tests, use Go’s standard tooling and naming:
  - Files: `*_test.go`, tests: `TestXxx`
  - Run: `go test ./...`

## Commit & Pull Request Guidelines
- Existing commit messages are short and informal (e.g., “docker fixes”, “readme gen”).
- Suggested practice:
  - Keep commits focused and descriptive.
  - In PRs, include:
    - Summary of services touched (`account`, `catalog`, `order`, `graphql`)
    - Steps to run locally
    - Any schema/proto changes and regeneration steps

## Configuration Notes
- Service configuration is via environment variables (e.g., `DATABASE_URL`, `ACCOUNT_SERVICE_URL`), defined in `docker-compose.yaml`.
- Update both service code and compose envs when adding new dependencies or cross-service calls.
