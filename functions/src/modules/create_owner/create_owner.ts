import * as functions from 'firebase-functions'
import { createStripeConnectAccount } from './create_stripe_connect_account'
import { checkExistance } from '../core/check_existance'
import { registerOwner } from './register_owner'

export const createOwner = functions
    .region('asia-northeast1')
    .runWith({ secrets: ['STRIPE_SECRET'] })
    .https.onCall(async (data, context) => {
        if (await checkExistance(data.uid, 'customers')) {
            return {
                statusCode: 200,
            }
        }

        const key = process.env.STRIPE_SECRET ?? ''
        const email = context.auth?.token.email ?? ''
        const idempotencyKey = data.idempotencyKey

        let connectAccountId: string
        try {
            connectAccountId = await createStripeConnectAccount(
                key,
                email,
                idempotencyKey,
            )
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

        const newOwner: Owner = {
            id: data.uid,
            userName: data.userName,
            email: data.email,
            connectAccountId: connectAccountId,
        }

        try {
            await registerOwner(newOwner)
        } catch (error) {
            if (error instanceof Error) {
                return {
                    statusCode: 401,
                    errorCode: `${error.message}`,
                }
            } else if (typeof error === 'string') {
                return {
                    statusCode: 401,
                    errorCode: `${error}`,
                }
            } else {
                return {
                    statusCode: 401,
                    errorCode: 'unexpected error',
                }
            }
        }

        return {
            statusCode: 200,
        }
    })
