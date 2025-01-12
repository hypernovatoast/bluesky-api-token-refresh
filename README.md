Automatically refresh BlueSky API access tokens.

This script helps you automate the process of refreshing your BlueSky API access token.

PREREQUISITES

- You must already have a valid BlueSky access token and refresh token.
- As the root user (this folder is restricted with 600 permissions), place the tokens in the following locations after cloning the repository:
  - Access Token: ./secrets/bskyAccessToken.txt
  - Refresh Token: ./secrets/bskyRefreshToken.txt


USAGE

Once the required tokens are in place, you can use the token-refresh.sh script to refresh your access token. It is designed to run automatically via a Cron job.

NOTES ON TOKEN EXPIRY

The BlueSky API documentation does not specify exact expiration times for access and refresh tokens. Based on testing, hourly rotation is a safe practice and has not caused issues. However, you can adjust this schedule as needed.

CONFIGURATION OPTIONS

To avoid hardcoding sensitive values, this script uses environment variables for configuration. The following variables must be set in ./secrets/errorReporting.env:

    $errorRecipient: The email address to receive error notifications.
    $myUsername: The Linux username with a configured email client.

If you prefer not to use environment variables, you can modify the script directly to include these values.

EMAIL NOTIFICATIONS

This script uses mutt as the email client for error notifications. If you use a different email client, you may need to update the email-sending commands in the script accordingly.
Setting Up the Cron Job

To schedule the script, add a Cron job with the desired frequency. For example, to run the script hourly, you can add the following line to your crontab:

0 * * * * /path/to/token-refresh.sh  

DISCLAIMER

This script is provided as-is. Use it responsibly and ensure you handle your credentials securely. Godspeed
