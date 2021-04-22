import options, json
import allographer/query_builder
import basolato/password

type SignUsecase* = ref object

proc newSignUsecase*():SignUsecase =
  return SignUsecase()

proc signin*(self:SignUsecase, email, password:string):JsonNode =
  let userOption = rdb().table("users").where("email", "=", email).first()
  if not userOption.isSome():
    raise newException(Exception, "一致するユーザーがいません")
  let user = userOption.get()
  if not isMatchPassword(password, user["password"].getStr):
    raise newException(Exception, "パスワードが不正です")
  return user