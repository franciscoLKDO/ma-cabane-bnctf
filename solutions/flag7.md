# Solution — Back to the Cabane

The connection record recovered in the previous step exposes the username
`thelkdo` and an MD5 password hash. Crack the weak hash with a dictionary tool
or identify the corresponding plaintext:

```text
hello there
```

Return to the webapp's login and authenticate with:

```text
Username: thelkdo
Password: hello there
```

The successful login response displays the final flag