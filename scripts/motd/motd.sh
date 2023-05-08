#!/bin/bash
# ln -sf ${dotfiledir}/scripts/motd/motd.sh ${homedir}/.config/motd.sh

# * ASCII head
# https://patorjk.com/software/taag/#p=display&f=Doh&t=KENDEX                                                                                                  

 

echo '________            ____  __.                 .___              '
echo '\______ \ _____    |    |/ _|____   ____    __| _/____ ___  ___ '
echo ' |    |  \\__  \   |      <_/ __ \ /    \  / __ |/ __ \\  \/  / '
echo ' |    `   \/ __ \_ |    |  \  ___/|   |  \/ /_/ \  ___/ >    <  '
echo '/_______  (____  / |____|__ \___  >___|  /\____ |\___  >__/\_ \ '
echo '        \/     \/          \/   \/     \/      \/    \/      \/ '
echo $'\n'

# * Cowsay                                                                    
dadjoke | cowsay -f tux
