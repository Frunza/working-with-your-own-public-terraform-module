# Working with your own public terraform module

## Motivation

If you created your own `Terraform` module, how can you publish it to *hashicorp* and make it available to the whole world?

## Prerequisites

A Linux or MacOS machine for local development. If you are running Windows, you first need to set up the *Windows Subsystem for Linux (WSL)* environment.

You need `docker cli` and `docker-compose` on your machine for testing purposes, and/or on the machines that run your pipeline.
You can check both of these by running the following commands:
```sh
docker --version
docker-compose --version
```

You also need a module to publish. If you do not know how to create a `Terraform` module refer to this [tutorial](https://github.com/Frunza/create-terraform-module).

## Publishing

The fist step is to make your module publicly available. To publish your module to the [Terraform Registry](https://registry.terraform.io/), you must follow some [requirements](https://developer.hashicorp.com/terraform/registry/modules/publish#requirements).

Let's say you want to create a module for playing around. In this case you can create a `GitHub` repository named `terraform-registry-playground`.
The code inside the *git* repository must follow this [structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure). The module shown in the [tutorial](https://github.com/Frunza/create-terraform-module) would look as shown [here](https://github.com/Frunza/terraform-registry-playground).

To version your module you must tag the desired commits and push the tags to git. The tags must look like `vX.X.X`; for example: `v0.0.4`, `v2.0.1`

Now you have to link your `GitHub` module with the `Terraform Registry`. To do this, navigate to *https://registry.terraform.io/github/create* and select your module from the dropdown. If this is your first time using the `Terraform Registry` you have to create an account and link it with your `GitHub`.

After publishing your module, make sure that `Inputs` and `Outputs` are correctly shown. For example, see *https://registry.terraform.io/modules/Frunza/playground/registry/latest*

## Usage

Now you can reference your public `Terraform` module. Since sample module uses 2 numbers as input and 2 numbers as output, let's call the module 2 times, using the output from the first call as input for the second call:
```sh
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
```
Note how you reference the module. The `Terraform Registry` will also add a sample usage.

Since you probably want to make sure that everything works well, let's create some outputs to view the results:
```sh
output "myPlaygroundFirstSum" {
  value = module.myPlaygroundFirst.sum
}
output "myPlaygroundFirstDifference" {
  value = module.myPlaygroundFirst.difference
}

output "myPlaygroundSecondSum" {
  value = module.myPlaygroundSecond.sum
}
output "myPlaygroundSecondDifference" {
  value = module.myPlaygroundSecond.difference
}
```

In your `Terraform` usage project you can now call:
```sh
terraform init
terraform apply -auto-approve
```
but you should go via a docker container instead.
