import * as firestore from 'firebase-admin/firestore'

const ownerConverter = {
    toFirestore(owner: Owner): firestore.DocumentData {
        return {
            id: owner.id,
            userName: owner.userName,
            email: owner.email,
            connectAccountId: owner.connectAccountId,
        }
    },
    fromFirestore(snapshot: firestore.QueryDocumentSnapshot): Owner | null {
        const data = snapshot.data() ?? null
        if (data == null) {
            return null
        }
        return {
            id: data.uid,
            userName: data.userName,
            email: data.email,
            connectAccountId: data.connectAccountId,
        }
    },
}

export const registerOwner = async (owner: Owner): Promise<void> => {
    const db = firestore.getFirestore()

    const batch = db.batch()

    const newOwnerRef = db
        .collection('owners')
        .withConverter(ownerConverter)
        .doc()

    batch.set(newOwnerRef, owner)

    await batch.commit()
}
