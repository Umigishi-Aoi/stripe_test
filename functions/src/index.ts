import { initializeApp } from 'firebase-admin'
import { createCustomer } from './modules/create_customer/create_customer'
import { createOwner } from './modules/create_owner/create_owner'

initializeApp

export { createCustomer, createOwner }
