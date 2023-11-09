import * as functions from 'firebase-functions'
import { createStripeCustomer } from './create_stripe_customer'
import { checkExistance } from '../core/check_existance'
import { registerCustomer } from './register_customer'

export const createCustomer = functions
    .region('asia-northeast1')
    .runWith({ secrets: ['STRIPE_SECRET'] })
    .https.onCall(async (data, context) => {
        if (await checkExistance(data.uid, 'owners')) {
            return {
                statusCode: 200,
            }
        }

        const key = process.env.STRIPE_SECRET ?? ''
        const email = context.auth?.token.email ?? ''
        const idempotencyKey = data.idempotencyKey

        let customerId: string
        try {
            customerId = await createStripeCustomer(key, email, idempotencyKey)
        } catch (error) {
            if (error instanceof Error) {
                return {
                    statusCode: 400,
                    errorCode: `${error.message}`,
                }
            } else if (typeof error === 'string') {
                return {
                    statusCode: 400,
                    errorCode: `${error}`,
                }
            } else {
                return {
                    statusCode: 400,
                    errorCode: 'unexpected error',
                }
            }
        }

        const newCustomer: Customer = {
            id: data.uid,
            userName: data.userName,
            email: data.email,
            customerId: customerId,
        }

        try {
            await registerCustomer(newCustomer)
        } catch (error) {
            if (error instanceof Error) {
                return {
                    statusCode: 400,
                    errorCode: `${error.message}`,
                }
            } else if (typeof error === 'string') {
                return {
                    statusCode: 400,
                    errorCode: `${error}`,
                }
            } else {
                return {
                    statusCode: 400,
                    errorCode: 'unexpected error',
                }
            }
        }

        return {
            statusCode: 200,
        }
    })
