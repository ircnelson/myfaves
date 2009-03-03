require 'jrails_in_place_editing'
require 'jrails_in_place_macros_helper'

ActionController::Base.send :include, InPlaceEditing
ActionController::Base.helper InPlaceMacrosHelper
