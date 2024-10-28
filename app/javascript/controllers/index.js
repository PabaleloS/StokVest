// Import and register all your controllers from the importmap via controllers/**/*_controller

import { application } from "./application"

import StokvelSubscriptionController from "./stokvel_subscription_controller.js"
application.register("stokvel-subscription", StokvelSubscriptionController)

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)
