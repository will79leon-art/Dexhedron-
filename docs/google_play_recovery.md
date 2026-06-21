# Google Play subscriptions & purchases recovery

Steps to recover subscriptions, purchases, or to investigate billing issues:

1. Gather evidence
- User account email
- Order ID or purchaseToken
- Approximate timestamp and device info
- Screenshots and any error messages

2. Use Play Console
- Developer Console → Order Management to search by order ID or user email
- Use Play Developer API `purchases.subscriptions:get` for programmatic lookup (requires service account credentials and proper permissions)

3. Refunds and restores
- Refunds can be issued via Play Console
- Restores usually require the user to sign in with the same Google account that made the purchase

4. Contact Google Support
- Prepare developer account information and evidence of ownership

5. For automated investigations
- Keep server-side receipts and validate purchase tokens via the Google Play Developer API.
