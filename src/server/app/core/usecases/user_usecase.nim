import json, options
import allographer/query_builder
import basolato/password

type UserUsecase* = ref object

proc newUserUsecase*():UserUsecase =
  return UserUsecase()

proc update*(self:UserUsecase, loginId:int, id:int, name, email, password:string) =
  if loginId != id:
    raise newException(Exception, "不正なアクセスです")
  rdb().table("users").where("id", "=", id).update(%*{
    "name": name,
    "email": email,
    "password": password.genHashedPassword()
  })
  echo rdb().table("users").find(id).get()
