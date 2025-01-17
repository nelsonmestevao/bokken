[asdf-vm]: https://asdf-vm.com/

# 🚀 Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes.

## 📥 Prerequisites

The following software is required to be installed on your system:

- [Erlang 24+](https://www.erlang.org/downloads)
- [Elixir 1.13+](https://elixir-lang.org/install.html)
- [PostgreSQL 13+](https://www.postgresql.org/download/)(^See [this section](#-docker) for setting up with docker.)

We recommend using [asdf version manager][asdf-vm] to install and manage all
the programming languages' requirements.

If you prefer to use docker, see the [section below](#-docker).

## 🔧 Setup

First, clone the repository:

```
git clone git@github.com:coderdojobraga/bokken.git
cd bokken
```

Then, run the setup script to get all dependencies configured. Make sure the database is up and running.

```
bin/setup
```

Then you should change the `.env.dev` file as needed. Run this script again if
needed.

## 🔨 Development

Start the development server and then you can visit `http://localhost:4000`
from your browser.

```
bin/server
```

Run the tests.

```
bin/test
```

Lint your code.

```
bin/lint
```

Format your code.

```
bin/format
```

## 🛠️ Tools

As a complementary tool for development and testing, we use
[Postman](https://www.postman.com/downloads/). We also use
[newman](https://www.npmjs.com/package/newman) for terminal base workflows.

## 🐳 Docker

For data persistence this project uses a PostgreSQL database. You should have
PostgreSQL up and running.

If you want to setup the required database using docker containers you can
easily do it with [docker-compose](https://docs.docker.com/compose/install/).

Create and start the database containers.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml up db
```

Start the previously created containers.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml start
```

Stop the containers.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml stop
```

Destroy the containers and volumes created.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml down -v
```

## 🔗 References

You can use these resources to learn more about the technologies this project
uses.

- [Getting Started with Elixir](https://elixir-lang.org/getting-started/introduction.html)
- [Erlang/Elixir Syntax: A Crash Course](https://elixir-lang.org/crash-course.html)
- [Elixir School Course](https://elixirschool.com/en/)
- [Phoenix Guides Overview](https://hexdocs.pm/phoenix/overview.html)
- [Phoenix Documentation](https://hexdocs.pm/phoenix)
