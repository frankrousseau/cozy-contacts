{settings} = require 'config'


module.exports = class SettingsView extends Mn.ItemView

    template: require 'views/templates/settings'

    tagName: 'section'

    className: 'settings'

    attributes:
        role: 'dialog'


    behaviors:
        Dialog: {}


    serializeData: ->
        _.extend {}, super, settings, locale: require('imports').locale
