#!/bin/bash

pushd ~

# cat > /home/${username}/taiga-front/app/config/main.coffee <<EOF
cat > /tmp/main.coffee <<EOF
config = {
    host: "${hostname}"
    scheme: "${scheme}"

    debug: true

    defaultLanguage: "en"
    languageOptions: {
        "en": "English"
    }

    publicRegisterEnabled: false
    privacyPolicyUrl: null
    termsOfServiceUrl: null
}

angular.module("taigaLocalConfig", []).value("localconfig", config)
EOF


if [ ! -e ~/.setup/taiga-front ]; then
    touch ~/.setup/taiga-front

    # Initial clear
    rm -rf taiga-front

    git clone https://github.com/taigaio/taiga-front.git taiga-front

    gem-install-if-needed sass
    npm-install-if-needed gulp bower

    pushd ~/taiga-front
    mv /tmp/main.coffee app/config

    sudo rm -rf /home/${username}/tmp
    npm install
    bower install
    gulp deploy
    popd
fi

popd



