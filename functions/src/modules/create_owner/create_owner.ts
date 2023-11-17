import * as functions from 'firebase-functions/v2/https'
import { createStripeConnectAccount } from './create_stripe_connect_account'
import { checkExistance } from '../core/check_existance'
import { registerOwner } from './register_owner'

export const createOwner = functions.onCall(
    { region: 'asia-northeast1', secrets: ['STRIPE_SECRET'] },
    async (request: functions.CallableRequest<CreateUserRequest>) => {
        try {
            if (await checkExistance(request.auth?.uid ?? '', 'owners')) {
                return {
                    statusCode: 200,
                }
            }
        } catch (error) {
            if (error instanceof Error) {
                return {
                    statusCode: 402,
                    errorCode: `${error.message}`,
                }
            } else if (typeof error === 'string') {
                return {
                    statusCode: 402,
                    errorCode: `${error}`,
                }
            } else {
                return {
                    statusCode: 402,
                    errorCode: 'unexpected error',
                }
            }
        }

        const key = process.env.STRIPE_SECRET ?? ''
        const email = request.auth?.token.email ?? ''
        const idempotencyKey = request.data.idempotencyKey

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
            id: request.auth?.uid ?? '',
            userName: request.data.userName,
            email: request.auth?.token.email ?? '',
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
    },
)
