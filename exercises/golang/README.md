before trying to compile move current directory under $GOPATH

    mv ./golang $GOPATH/src/github.com/dikderoy/imagen

then use dep in `$GOPATH/src/github.com/dikderoy/imagen`

    dep ensure

this will install dependencies