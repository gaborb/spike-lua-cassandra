local cassandra = require "cassandra"
local uuid = require 'resty.jit-uuid'
local pretty = require "pl.pretty"

uuid.seed()

local peer = assert(cassandra.new {
  host = "local.db",
  port = 9042,
  keyspace = "my_keyspace"
})

peer:settimeout(1000)

assert(peer:connect())

assert(peer:execute "DROP TABLE IF EXISTS users")

assert(peer:execute [[
    CREATE TABLE users(
        id uuid PRIMARY KEY,
        first_name varchar,
        last_name varchar,
        age int,
        sex varchar
    )
]])

assert(peer:batch {
    {"INSERT INTO users(id, first_name, last_name, age, sex) VALUES(?, ?, ?, ?, ?)", {cassandra.uuid(uuid()), "Jake", "O Reilly", 42, "male"}},
    {"INSERT INTO users(id, first_name, last_name, age, sex) VALUES(?, ?, ?, ?, ?)", {cassandra.uuid(uuid()), "John", "Doe", 34, "male"}},
    {"INSERT INTO users(id, first_name, last_name, age, sex) VALUES(?, ?, ?, ?, ?)", {cassandra.uuid(uuid()), "Jane", "Doe", 32, "female"}},
})

local rows = assert(peer:execute "SELECT * FROM users")

pretty.dump(rows)

peer:close()