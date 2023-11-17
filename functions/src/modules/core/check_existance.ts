import * as firestore from 'firebase-admin/firestore'

export const checkExistance = async (
    uid: string,
    collection: string,
): Promise<boolean> => {
    const qss = await firestore
        .getFirestore()
        .collection(collection)
        .where('uid', '==', uid)
        .get()

    return !qss.empty
}
