import json, strutils
# framework
import basolato/controller
import basolato/request_validation
import ../../core/usecases/user_usecase

# proc index*(request:Request, params:Params):Future[Response] {.async.} =
#   return render("index")

# proc show*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("show")

# proc create*(request:Request, params:Params):Future[Response] {.async.} =
#   return render("create")

# proc store*(request:Request, params:Params):Future[Response] {.async.} =
#   return render("store")

# proc edit*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("edit")

proc update*(request:Request, params:Params):Future[Response] {.async.} =
  let v = newRequestValidation(params)
  v.required("name"); v.alphaNum("name")
  v.required("email"); v.email("email")
  v.required("password")
  if v.hasErrors():
    return render(Http422, %*{"errors": v.errors})

  try:
    let client = await newClient(request)
    if not await client.isLogin():
      raise newException(Exception, "ログインしていません")

    let loginId = await(client.get("id")).parseInt
    let id = params.getInt("id")
    let name = params.getStr("name")
    let email = params.getStr("email")
    let password = params.getStr("password")
    let usecase = newUserUsecase()
    usecase.update(loginId, id, name, email, password)
    return render(newJObject())
  except:
    let message = getCurrentExceptionMsg()
    return render(Http422, %*{"errors": {"domain":message}})

  return render("update")

# proc destroy*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("destroy")
