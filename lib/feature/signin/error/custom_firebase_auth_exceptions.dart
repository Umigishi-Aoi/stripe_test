// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';

// 参考: https://firebase.google.com/docs/auth/admin/errors?hl=ja
enum CustomFirebaseAuthExceptions implements Exception {
  claimsTooLarge(
    message:
        'setCustomUserClaims() に渡されたクレーム ペイロードが、最大許容サイズ（1,000 バイト）を超えています。',
  ),
  emailAlreadyExists(
    message: '提供されたメールアドレスはすでに既存のユーザーによって使用されています。各ユーザーに固有のメールアドレスが必要です。',
  ),
  idTokenExpired(message: '指定された Firebase ID トークンは期限切れです。'),
  idTokenRevoked(message: 'Firebase ID トークンが取り消されました。'),
  insufficientPermission(
    message:
        'Admin SDK の初期化に使用された認証情報に、リクエストされた Authentication リソースにアクセスするための権限がありません。',
  ),
  internalError(message: 'リクエストの処理中に、認証サーバーで予期しないエラーが発生しました。'),
  invalidArgument(message: '無効な引数が Authentication メソッドに提供されました。'),
  invalidClaims(message: 'setCustomUserClaims() に渡されたカスタム クレーム属性が無効です。'),
  invalidContinueUri(message: '続行 URL は有効な URL 文字列でなければなりません。'),
  invalidCreationTime(message: '作成時刻は有効な UTC 日付文字列でなければなりません。'),
  invalidCredential(message: 'Admin SDK の認証に使用された認証情報は、目的のアクションの実行には使用できません。'),
  invalidDisabledField(message: 'disabled ユーザー プロパティに指定された値は無効です。'),
  invalidDisplayName(message: 'displayName ユーザー プロパティに指定された値は無効です。'),
  invalidDynamicLinkDomain(
    message: '指定されたダイナミック リンクのドメインは、現在のプロジェクトに対して構成されていないか、承認されていません。',
  ),
  invalidEmail(message: 'email ユーザー プロパティに指定された値は無効です。'),
  invalidEmailVerified(message: 'emailVerified ユーザー プロパティに指定された値は無効です。'),
  invalidHashAlgorithm(
    message:
        'algorithm	ハッシュ アルゴリズムは、サポートされているアルゴリズムのリスト内の文字列の 1 つと一致している必要があります。',
  ),
  invalidHashBlockSize(message: 'ハッシュのブロックサイズには有効な数値を指定してください。'),
  invalidHashDerivedLKeyLength(message: 'ハッシュ派生キーの長さには有効な数値を指定してください。'),
  invalidHashKey(message: 'ハッシュキーは有効なバイトバッファでなければなりません。'),
  invalidHashMemoryCost(message: 'ハッシュメモリのコストには有効な数値を指定してください。'),
  invalidHashParallelization(message: 'ハッシュ並列化には有効な数値を指定してください。'),
  invalidHashRounds(message: 'ハッシュ ラウンドには有効な数値を指定してください。'),
  invalidHashSaltSeparator(
    message: 'ハッシング アルゴリズムの salt separator フィールドは、有効なバイトバッファでなければなりません。',
  ),
  invalidIdToken(message: '指定された ID トークンは有効な Firebase ID トークンではありません。'),
  invalidLastSignInTime(message: '最終ログイン時間は、有効な UTC 日付文字列でなければなりません。'),
  invalidPageToken(message: 'listUsers() に指定されたネクスト ページトークンが無効です。'),
  invalidPassword(message: 'password ユーザー プロパティに指定された値は無効です。'),
  invalidaPasswordHash(message: 'パスワード ハッシュは有効なバイトバッファでなければなりません。'),
  invalidPasswordSalt(message: 'パスワード ソルトは有効なバイトバッファでなければなりません。'),
  invalidPhoneNumber(
    message: 'phoneNumber に指定された値は無効です。空でない E.164 標準準拠の ID 文字列を指定する必要があります。',
  ),
  invalidPhotoUrl(
    message: 'photoURL ユーザー プロパティに指定された値は無効です。文字列 URL を指定する必要があります。',
  ),
  invalidProviderData(
    message: 'providerData は、有効な UserInfo オブジェクトの配列でなければなりません。',
  ),
  invalidProviderId(
    message: 'providerId は、サポートされている有効なプロバイダ ID 文字列でなければなりません。',
  ),
  invalidOauthResponsetype(
    message: 'OAuth responseType を 1 つだけ true に設定する必要があります。',
  ),
  invalidSessionCookieDuration(
    message: 'セッション Cookie の期間には、5 分から 2 週間の間の有効な数値をミリ秒単位で指定してください。',
  ),
  invalidUid(message: 'uid は、128 文字以下の空でない文字列を指定する必要があります。'),
  invalidUserImport(message: 'インポート対象のユーザー レコードが無効です。'),
  maximumUserCountExceeded(message: 'インポートするユーザーの最大許容数を超えています。'),
  missingAndroidPkgName(
    message: 'Android アプリをインストールする必要がある場合は、Android パッケージ名を入力する必要があります。',
  ),
  missingContinueUri(message: 'リクエストで有効な続行 URL を提供する必要があります。'),
  missingHashAlgorithm(
    message: 'パスワード ハッシュを使用してユーザーをインポートするには、ハッシング アルゴリズムとそのパラメータを指定する必要があります。',
  ),
  missingIosBundleId(message: 'リクエストにバンドル ID が指定されていません。'),
  missingUid(message: '現在のオペレーションには uid 識別子が必要です。'),
  missingOauthClientSecret(
    message: 'OIDC コードフローを有効にするには、OAuth 構成クライアント シークレットが必要です。',
  ),
  networkRequestFailed(message: '接続がタイムアウトしました。'),
  operationNotAllowed(message: '提供されたログイン プロバイダは Firebase プロジェクトで無効になっています。'),
  phoneNumberAlreadyExists(
    message: '提供された phoneNumberはすでに既存のユーザーによって使用されています。',
  ),
  projectNotFound(
    message: 'Admin SDK を初期化するために使用された認証情報に対して Firebase プロジェクトが見つかりませんでした。',
  ),
  reservedClaims(
    message: 'setCustomUserClaims() に指定された 1 つ以上のカスタム ユーザー クレームが予約済みです。',
  ),
  sessionCookieExpired(message: '提供された Firebase セッションの Cookie は期限切れです。'),
  sessionCookieRevoked(message: 'Firebase セッション Cookie が取り消されました。'),
  tooManyRequests(message: 'リクエスト数が最大数を超えています。'),
  uidAlreadyExists(message: '提供された uid はすでに既存のユーザーによって使用されています。'),
  unauthorizedContinueUri(message: '続行 URL のドメインがホワイトリストに登録されていません。'),
  userNotFound(message: '提供された ID に対応する既存のユーザー レコードはありません。');

  const CustomFirebaseAuthExceptions({required this.message});

  factory CustomFirebaseAuthExceptions.from(FirebaseAuthException e) =>
      switch (e.code) {
        'claims-too-large' => CustomFirebaseAuthExceptions.claimsTooLarge,
        'email-already-exists' =>
          CustomFirebaseAuthExceptions.emailAlreadyExists,
        'id-token-expired' => CustomFirebaseAuthExceptions.idTokenExpired,
        'id-token-revoked' => CustomFirebaseAuthExceptions.idTokenRevoked,
        'insufficient-permission' =>
          CustomFirebaseAuthExceptions.insufficientPermission,
        'internal-error' => CustomFirebaseAuthExceptions.internalError,
        'invalid-argument' => CustomFirebaseAuthExceptions.invalidArgument,
        'invalid-claims' => CustomFirebaseAuthExceptions.invalidClaims,
        'invalid-continue-uri' =>
          CustomFirebaseAuthExceptions.invalidContinueUri,
        'invalid-creation-time' =>
          CustomFirebaseAuthExceptions.invalidCreationTime,
        'invalid-credential' => CustomFirebaseAuthExceptions.invalidCredential,
        'invalid-disabled-field' =>
          CustomFirebaseAuthExceptions.invalidDisabledField,
        'invalid-display-name' =>
          CustomFirebaseAuthExceptions.invalidDisplayName,
        'invalid-dynamic-link-domain' =>
          CustomFirebaseAuthExceptions.invalidDynamicLinkDomain,
        'invalid-email' => CustomFirebaseAuthExceptions.invalidEmail,
        'invalid-email-verified' =>
          CustomFirebaseAuthExceptions.invalidEmailVerified,
        'invalid-hash-algorithm' =>
          CustomFirebaseAuthExceptions.invalidHashAlgorithm,
        'invalid-hash-block-size' =>
          CustomFirebaseAuthExceptions.invalidHashBlockSize,
        'invalid-hash-derived-key-length' =>
          CustomFirebaseAuthExceptions.invalidHashDerivedLKeyLength,
        'invalid-hash-key' => CustomFirebaseAuthExceptions.invalidHashKey,
        'invalid-hash-memory-cost' =>
          CustomFirebaseAuthExceptions.invalidHashMemoryCost,
        'invalid-hash-parallelization' =>
          CustomFirebaseAuthExceptions.invalidHashParallelization,
        'invalid-hash-rounds' => CustomFirebaseAuthExceptions.invalidHashRounds,
        'invalid-hash-salt-separator' =>
          CustomFirebaseAuthExceptions.invalidHashSaltSeparator,
        'invalid-id-token' => CustomFirebaseAuthExceptions.invalidIdToken,
        'invalid-last-sign-in-time' =>
          CustomFirebaseAuthExceptions.invalidLastSignInTime,
        'invalid-page-token' => CustomFirebaseAuthExceptions.invalidPageToken,
        'invalid-password' => CustomFirebaseAuthExceptions.invalidPassword,
        'invalid-password-hash' =>
          CustomFirebaseAuthExceptions.invalidaPasswordHash,
        'invalid-password-salt' =>
          CustomFirebaseAuthExceptions.invalidPasswordSalt,
        'invalid-phone-number' =>
          CustomFirebaseAuthExceptions.invalidPhoneNumber,
        'invalid-photo-url' => CustomFirebaseAuthExceptions.invalidPhotoUrl,
        'invalid-provider-data' =>
          CustomFirebaseAuthExceptions.invalidProviderData,
        'invalid-provider-id' => CustomFirebaseAuthExceptions.invalidProviderId,
        'invalid-oauth-responsetype' =>
          CustomFirebaseAuthExceptions.invalidOauthResponsetype,
        'invalid-session-cookie-duration' =>
          CustomFirebaseAuthExceptions.invalidSessionCookieDuration,
        'invalid-uid' => CustomFirebaseAuthExceptions.invalidUid,
        'invalid-user-import' => CustomFirebaseAuthExceptions.invalidUserImport,
        'maximum-user-count-exceeded' =>
          CustomFirebaseAuthExceptions.maximumUserCountExceeded,
        'missing-android-pkg-name' =>
          CustomFirebaseAuthExceptions.missingAndroidPkgName,
        'missing-continue-uri' =>
          CustomFirebaseAuthExceptions.missingContinueUri,
        'missing-hash-algorithm' =>
          CustomFirebaseAuthExceptions.missingHashAlgorithm,
        'missing-ios-bundle-id' =>
          CustomFirebaseAuthExceptions.missingIosBundleId,
        'missing-uid' => CustomFirebaseAuthExceptions.missingUid,
        'missing-oauth-client-secret' =>
          CustomFirebaseAuthExceptions.missingOauthClientSecret,
        'network-request-failed' =>
          CustomFirebaseAuthExceptions.networkRequestFailed,
        'operation-not-allowed' =>
          CustomFirebaseAuthExceptions.operationNotAllowed,
        'phone-number-already-exists' =>
          CustomFirebaseAuthExceptions.phoneNumberAlreadyExists,
        'project-not-found' => CustomFirebaseAuthExceptions.projectNotFound,
        'reserved-claims' => CustomFirebaseAuthExceptions.reservedClaims,
        'session-cookie-expired' =>
          CustomFirebaseAuthExceptions.sessionCookieExpired,
        'session-cookie-revoked' =>
          CustomFirebaseAuthExceptions.sessionCookieRevoked,
        'too-many-requests' => CustomFirebaseAuthExceptions.tooManyRequests,
        'uid-already-exists' => CustomFirebaseAuthExceptions.uidAlreadyExists,
        'unauthorized-continue-uri' =>
          CustomFirebaseAuthExceptions.unauthorizedContinueUri,
        'user-not-found' => CustomFirebaseAuthExceptions.userNotFound,
        _ => throw ArgumentError(e.code),
      };

  final String message;
}
