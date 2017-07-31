#! /bin/sh

##########################################################################################
##########################################################################################
## Paramétrage rapide d’un Mac															##
## v201707311524																		##
##########################################################################################
## Anthony Nelzin-Santos																##
## https://anthony.nelzin.fr															##
##########################################################################################
## Licence CeCILL																		##
## http://www.cecill.info/licences/Licence_CeCILL_V2.1-fr.txt							##
##########################################################################################
##########################################################################################

##################################
## Ouverture d’une session sudo ##
##################################
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############
## Démarrage ##
###############

## Désactiver le son de démarrage
nvram SystemAudioVolume="%00"

## Activer le « powerchime » façon iOS
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && open /System/Library/CoreServices/PowerChime.app

## Paramétrer le nom de la machine
scutil --set ComputerName nomdelamachine
scutil --set HostName nomdelamachine
scutil --set LocalHostName nomdelamachine

##############
## Sécurité ##
##############

## Exiger le mot de passe immédiatement après la suspension d’activité
defaults write com.apple.screensaver askForPassword -int 1 && defaults write com.apple.screensaver askForPasswordDelay -int 0

## Configurer le pare-feu
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on &&/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on && /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on && /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off && /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off && pkill -HUP socketfilterfw

## Désactiver la connexion aux portails captifs
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

##########
## Dock ##
##########

## Vider le Dock (il sera rempli au fur et à mesure des usages, dans l’ordre alphabétique)
defaults write com.apple.dock persistent-apps -array

## Placer le Dock dans la bonne position
defaults write com.apple.dock orientation -string "left"

## Masquer/afficher le Dock automatiquement
defaults write com.apple.dock autohide -boolean yes

## Réduire les fenêtres dans l’icône de l’application
defaults write com.apple.dock minimize-to-application -bool true

## Relancer le Dock
killall Dock

############
## Finder ##
############

## Afficher les barres de défilement : toujours
defaults write -g AppleShowScrollBars -string "Always"

## Désactiver l’affichage du Bureau
defaults write com.apple.finder CreateDesktop -bool false

## Les nouvelles fenêtres de Finder affichent : Bureau
defaults write com.apple.finder NewWindowTarget -string "PfDe" && defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Desktop/"

## Présentation > Par liste
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

## Présentation > Afficher la barre du chemin d’accès
defaults write com.apple.finder ShowPathbar -bool true

## Présentation > Afficher la barre d’état
defaults write com.apple.finder ShowStatusBar -bool true

## Afficher toutes les extension des fichiers
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Ne pas avertir avant de modifier une extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## Afficher le panneau de sauvegarde étendu par défaut
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

## Couper le dialogue Time Machine à l’insertion d’un nouveau disque
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

## Relancer le Finder
killall Finder

#####################
## Mission Control ##
#####################

## Ne pas réarranger automatiquement les Spaces en fonction de votre utilisation la plus récente
defaults write com.apple.dock mru-spaces -bool false

## Grouper les fenêtres par application
defaults write com.apple.dock expose-group-by-app -bool true

## Coin actif > en bas à gauche : Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2 && defaults write com.apple.dock wvous-bl-modifier -int 0

## Coin actif > en haut à droite : mettre le moniteur en veille
defaults write com.apple.dock wvous-tr-corner -int 10 && defaults write com.apple.dock wvous-tr-modifier -int 0

##################
## Fond d’écran ##
##################
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Earth Horizon.jpg"'

######################
## Captures d’écran ##
######################

## Enregistrer les captures dans le dossier Documents
defaults write com.apple.screencapture location ~/Documents/Captures && killall SystemUIServer

## Au format JPG
defaults write com.apple.screencapture type -string "jpg"

#############
## Clavier ##
#############

## Activer l’accès au clavier complet
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

## Désactiver la correction automatique et les autres assistances
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false && defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false && defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false && defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false && defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false && defaults write -g ApplePressAndHoldEnabled -bool false

############
## Souris ##
############

## Sens du défilement : (vraiment) naturel
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

## Toucher pour cliquer
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 && defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true && defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

## Configurer la meilleure couleur de contraste
defaults write NSGlobalDomain AppleHighlightColor "0.968627 0.831373 1.000000"

############
## Safari ##
############

## Au démarrage, Safari ouvre : toutes les fenêtres de la dernier session
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

## Page d’accueil : vide
defaults write com.apple.Safari HomePage ""

## Ne pas ouvrir automatiquement les fichiers dits « fiables »
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean NO

## Ne pas remplir automatiquement les formulaires web
defaults write com.apple.Safari AutoFillFromAddressBook -bool false && defaults write com.apple.Safari AutoFillPasswords -bool false && defaults write com.apple.Safari AutoFillCreditCardData -bool false && defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

## Avertir lors de l’accès à un site web frauduleux
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

## Bloquer les fenêtres surgissantes
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false

## Ne pas autoriser les modules
defaults write com.apple.Safari WebKitPluginsEnabled -bool false && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

## Demander aux sites web de ne pas me suivre
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

## Afficher l’adresse complète du site web
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1

# La touche Tab permet de mettre en surbrillance les objets des pages web
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

## Afficher le menu Développement dans la barre des menus
defaults write com.apple.safari IncludeDevelopMenu -int 1

## Présentation > Afficher la barre d’état
defaults write com.apple.safari ShowOverlayStatusBar -int 1

##############
## Homebrew ##
##############

## Installer Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Installer Cask
brew tap caskroom/cask

## Installer applications avec Cask
brew cask install 1password alfred bbedit crashplan dropbox firefox libreoffice imageoptim sketch tower

## Installer utilitaires
brew install ffmpeg handbrake multimarkdown pandoc

## Lancement des applications pour se connecter aux services et entrer les licences
open -a 1Password \6 && open -a BBEdit && open -a Crashplan && open -a Dropbox && open -a Things && open -a Tower