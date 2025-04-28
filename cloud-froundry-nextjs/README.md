# Install and setup cloud foundry CLI

## Install CLI (example for mac)
`brew install cloudfoundry/tap/cf-cli@8`


# create nextjs app
`npx create-next-app@latest`

# create manifest.yml in my-nextjs-app
```
---
applications:
  - name: myNextjsApp
    memory: 1024M
    disk_quota: 2024M
    instances: 1
    buildpacks:
      - nodejs_buildpack
    command: npm run start-cf
```

# create .cfignore in my-nextjs-app
```
node_modules
.next
```

# add node version to the package.json
```
  "engines": {
    "node": "22",
    "npm": "11"
  }
```

# Login cloud foundry cli
`cf login -a https://api.system.01.cf.eu01.stackit.cloud --sso`

# Push app to cloud foundry
```
cd my-nextjs-app
cf push
```

