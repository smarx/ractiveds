class RactiveDatastore
	constructor: (@appKey, @elementName, @template, @initialData) ->
		@client = new Dropbox.Client key: @appKey
		@client.authenticate interactive: false
		@authenticated = @client.isAuthenticated()
		@initialize() if @authenticated

	authenticate: -> @client.authenticate()

	initialize: ->
		@client.getDatastoreManager().openDefaultDatastore (error, datastore) =>
			ractive = new Ractive
				el: @elementName,
				template: @template

			update = (record) =>
				@suppress = true
				ractive.set record.getId(), record.get 'value'
				@suppress = false

			makeSetter = (key) =>
				(value) =>
					@set key, value unless @suppress

			@table = datastore.getTable 'ractivedatastore'
			for key, value of @initialData
				@table.getOrInsert key, value: value
				ractive.observe key, makeSetter(key), init: false

			for record in @table.query()
				update record

			datastore.recordsChanged.addListener (event) ->
				for record in event.affectedRecordsForTable 'ractivedatastore'
					update record

	set: (key, value) ->
		@table.get(key).set 'value', value

(exports ? this).RactiveDatastore = RactiveDatastore
