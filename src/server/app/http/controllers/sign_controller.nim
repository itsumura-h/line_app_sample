import json
# framework
import basolato/controller
import basolato/request_validation
import ../../core/usecases/sign_usecase

# proc index*(request:Request, params:Params):Future[Response] {.async.} =
#   return render("index")

# proc show*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("show")

# proc create*(request:Request, params:Params):Future[Response] {.async.} =
#   return render("create")

proc store*(request:Request, params:Params):Future[Response] {.async.} =
  let v = newRequestValidation(params)
  v.required("email"); v.email("email")
  v.required("password")
  if v.hasErrors:
    return render(Http422, %*{"errors":v.errors})
  
  try:
    let email = params.getStr("email")
    let password = params.getStr("password")
    let usecase = newSignUsecase()
    let user = usecase.signin(email, password)
    let client = await newClient(request)
    await client.login()
    await client.set("id", $user["id"].getInt)
    await client.set("name", user["name"].getStr)
  except:
    let message = getCurrentExceptionMsg()
    return render(Http422,%*{"errors": {"domain": message}})

  return render(newJObject())

# proc edit*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("edit")

# proc update*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("update")

# proc destroy*(request:Request, params:Params):Future[Response] {.async.} =
#   let id = params.getInt("id")
#   return render("destroy")
