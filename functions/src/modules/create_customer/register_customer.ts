import * as firestore from 'firebase-admin/firestore'

const customerConverter = {
    toFirestore(customer: Customer): firestore.DocumentData {
        return {
            id: customer.id,
            userName: customer.userName,
            email: customer.email,
            customerId: customer.customerId,
        }
    },
    fromFirestore(snapshot: firestore.QueryDocumentSnapshot): Customer | null {
        const data = snapshot.data() ?? null
        if (data == null) {
            return null
        }
        return {
            id: data.uid,
            userName: data.userName,
            email: data.email,
            customerId: data.customerId,
        }
    },
}

export const registerCustomer = async (customer: Customer): Promise<void> => {
    const db = firestore.getFirestore()

    const batch = db.batch()

    const newCustomerRef = db
        .collection('customers')
        .withConverter(customerConverter)
        .doc()

    batch.set(newCustomerRef, customer)

    await batch.commit()
}
