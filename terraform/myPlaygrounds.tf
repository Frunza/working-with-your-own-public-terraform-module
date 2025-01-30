module "myPlaygroundFirst" {
  source  = "Frunza/playground/registry"
  version = "0.0.2"

  number1 = 8
  number2 = 3
}

module "myPlaygroundSecond" {
  source  = "Frunza/playground/registry"
  version = "0.0.2"

  number1 = module.myPlaygroundFirst.sum
  number2 = module.myPlaygroundFirst.difference
}
