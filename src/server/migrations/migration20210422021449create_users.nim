import json, strformat
import allographer/schema_builder
import allographer/query_builder
import basolato/password

proc migration20210422021449create_users*() =
  schema(
    table("users", [
      Column().increments("id"),
      Column().string("name"),
      Column().string("email"),
      Column().string("password")
    ])
  )

  if rdb().table("users").count() == 0:
    var users: seq[JsonNode]
    for i in 1..5:
      users.add(%*{
        "id": i,
        "name": &"user{i}",
        "email": &"user{i}@gmail.com",
        "password": fmt"Password{i}".genHashedPassword()
      })
    rdb().table("users").insert(users)
  echo rdb().table("users").get()
