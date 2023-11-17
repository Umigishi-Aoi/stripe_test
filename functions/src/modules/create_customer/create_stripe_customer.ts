import Stripe from 'stripe'

export const createStripeCustomer = async (
    stripeKey: string,
    email: string,
    idempotencyKey: string,
): Promise<string> => {
    const stripe = new Stripe(stripeKey)

    const customer = await stripe.customers.create(
        { email: email },
        { idempotencyKey: idempotencyKey },
    )

    return customer.id
}
