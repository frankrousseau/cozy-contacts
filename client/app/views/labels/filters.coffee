{Filtered}  = BackboneProjections

PATTERN = /tag:(\w+)/i


module.exports = class LabelsFiltersToolView extends Mn.CompositeView

    template: require 'views/templates/labels/filters'

    tagName: 'fieldset'


    ui:
        navigate: 'a'

    behaviors:
        Navigator: {}


    childViewContainer: 'ul'

    childView: require 'views/labels/filter'


    modelEvents:
        'change:filter': 'toggleSelected'


    initialize: ->
        app     = require 'application'
        @collection = new Filtered app.tags,
            filter: (model) ->
                return unless app.contacts.length
                contacts = app.contacts.find (contact) ->
                    _.contains contact.attributes.tags, model.attributes.name
                !!contacts
        @collection.listenTo app.contacts,
            'reset':  @collection.update
            'update': @collection.update


    toggleSelected: (model, value) ->
        tag = value?.match(PATTERN)?[1]
        _id = if tag then @collection.find(name: tag).get('_id') else 'all'

        @$("[aria-checked]:not([for=filter-#{_id}])")
        .attr 'aria-checked', false

        @$("[for=filter-#{_id}]")
        .attr 'aria-checked', true