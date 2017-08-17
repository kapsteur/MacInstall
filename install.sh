#!/bin/bash

##########################################################################################
##########################################################################################
## Paramétrage rapide d’un Mac															                            ##
## v201708161533																		                                    ##
##########################################################################################
## Garry POUPIN														                                              ##
## https://anthony.nelzin.fr															                              ##
##########################################################################################
## Licence CeCILL																		                                    ##
## http://www.cecill.info/licences/Licence_CeCILL_V2.1-fr.txt							              ##
##########################################################################################
##########################################################################################

echo "La configuration de cette machine va commencer."

##############
## Sécurité ##
##############

## Exiger le mot de passe immédiatement après la suspension d’activité
defaults write com.apple.screensaver askForPassword -int 1 && defaults write com.apple.screensaver askForPasswordDelay -int 0

## Configurer le pare-feu
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on &&/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on && /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on && /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off && /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off && pkill -HUP socketfilterfw

## Désactiver la connexion aux portails captifs
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

############
## Souris ##
############

## Toucher pour cliquer
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 && defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true && defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

##########
## Dock ##
##########

## Placer le Dock dans la bonne position
defaults write com.apple.dock orientation -string "right"

## Masquer/afficher le Dock automatiquement
defaults write com.apple.dock autohide -boolean yes

## Réduire les fenêtres dans l’icône de l’application
defaults write com.apple.dock minimize-to-application -bool true

## Relancer le Dock
killall Dock

#####################
## Mission Control ##
#####################

## Ne pas réarranger automatiquement les Spaces en fonction de votre utilisation la plus récente
defaults write com.apple.dock mru-spaces -bool false

## Grouper les fenêtres par application
defaults write com.apple.dock expose-group-by-app -bool true

## Coin actif > en bas à gauche : Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2 && defaults write com.apple.dock wvous-bl-modifier -int 0

############
## Finder ##
############

## Désactiver l’affichage du Bureau
defaults write com.apple.finder CreateDesktop -bool false

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


##############
## Terminal ##
##############

defaults write com.apple.Terminal "Default Window Settings" -string "Homebrew" && defaults write com.apple.Terminal "Startup Window Settings" -string "Homebrew"

##############
## Homebrew ##
##############

echo "La configuration de cette machine est terminée. L’installation des applications et des utilitaires va commencer."

## Installer Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Installer Cask
brew tap caskroom/cask

## Installer applications avec Cask
brew cask install 1password alfred dropbox firefox imageoptim chrome slack tripmode sequelpro vlc virtualbox sublime-text paw transmit reeder bear little-snitch spotify

## Installer utilitaires
brew tap homebrew/homebrew-php
brew install gti go php56 ruby node nginx

## Vider le Dock
defaults write com.apple.dock persistent-apps -array

## Relancer le Dock
killall Dock

## Lancement des applications pour se connecter aux services et entrer les licences
open -a 1Password \6 && open -a Dropbox

echo "L’installation des applications et des utilitaires est terminée. Au travail !"
