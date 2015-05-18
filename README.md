# Docker base image management #

## Dependencies ##
Docker version 1.6 or higher

## How to build an image locally ##
**This should only be necessary if Dockerhub is down/broken/etc.**

1. find commit hash of desired version `$VERSION_NUM`

    ```bash
    git log --oneline -S version=$VERSION_NUM
    ```
1. checkout the commit

    ```bash
    git checkout $HASH_FROM_ABOVE
    ```
1. run the script

    ```bash
    ./build_image
    ```
    The script will output the tags of the images it has build.

## How to use by CI ##
```bash
./build_image --check-diff
```

## Known issues ##
`golang-base` images before version 8 are not supported by the `build_image`
script. Use `git tag` and `docker build` manually to build an image.
