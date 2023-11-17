import Stripe from 'stripe'

export const createStripeConnectAccount = async (
    stripeKey: string,
    email: string,
    idempotencyKey: string,
): Promise<string> => {
    const stripe = new Stripe(stripeKey)

    const owner = await stripe.accounts.create(
        {
            type: 'custom',
            country: 'JP',
            email: email,
            business_type: 'individual',
            capabilities: {
                card_payments: { requested: true },
                transfers: { requested: true },
            },
            individual: {
                email: email,
            },
            settings: {
                payouts: {
                    schedule: {
                        interval: 'manual',
                    },
                },
            },
        },
        { idempotencyKey: idempotencyKey },
    )

    return owner.id
}
