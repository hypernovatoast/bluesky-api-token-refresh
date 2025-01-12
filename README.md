#bluesky-api-token-refresh

Automatically refresh BlueSky API access tokens

This script helps you automate the process of refreshing your BlueSky API access token.
Prerequisites

    You must already have a valid BlueSky access token and refresh token.
    Place the tokens in the following locations after cloning the repository:
        Access Token: ./secrets/bskyAccessToken.txt
        Refresh Token: ./secrets/bskyRefreshToken.txt

Ensure the ./secrets/ directory is secured appropriately (e.g., permissions set to 600 for sensitive files).
Usage

Once the required tokens are in place, you can use the token-refresh.sh script to refresh your access token. It is designed to run automatically via a Cron job.
Notes on Token Expiry

The BlueSky API documentation does not specify exact expiration times for access and refresh tokens. Based on testing, hourly rotation is a safe practice and has not caused issues. However, you can adjust this schedule as needed.
Configuration Options

To avoid hardcoding sensitive values, this script uses environment variables for configuration. The following variables must be set:

    $errorRecipient: The email address to receive error notifications.
    $myUsername: The Linux username with a configured email client.

If you prefer not to use environment variables, you can modify the script directly to include these values.
Email Notifications

This script uses mutt as the email client for error notifications. If you use a different email client, you may need to update the email-sending commands in the script accordingly.
Setting Up the Cron Job

To schedule the script, add a Cron job with the desired frequency. For example, to run the script hourly, you can add the following line to your crontab:

0 * * * * /path/to/token-refresh.sh  

Disclaimer

This script is provided as-is. Use it responsibly and ensure you handle your credentials securely.
