import * as functions from 'firebase-functions/v2/https'
import { createStripeCustomer } from './create_stripe_customer'
import { checkExistance } from '../core/check_existance'
import { registerCustomer } from './register_customer'

export const createCustomer = functions.onCall(
    { region: 'asia-northeast1', secrets: ['STRIPE_SECRET'] },
    async (request: functions.CallableRequest<CreateUserRequest>) => {
        if (await checkExistance(request.auth?.uid ?? '', 'owners')) {
            return {
                statusCode: 200,
            }
        }

        const key = process.env.STRIPE_SECRET ?? ''
        const email = request.auth?.token.email ?? ''
        const idempotencyKey = request.data.idempotencyKey

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
            id: request.auth?.uid ?? '',
            userName: request.data.userName,
            email: request.auth?.token.email ?? '',
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
    },
)
