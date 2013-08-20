Ractive Datastore
-----------------

This project combines the DOM manipulation and data-binding of [Ractive.js](http://www.ractivejs.org) with the data sync capabilities of the [Dropbox Datastore API](https://www.dropbox.com/developers/datastore).

This combination makes it easy to build two-way databinding that syncs across devices.

Setup
-----

To use the Ractive Datastore library, download `ractivedatastore.js` and include it in your HTML after both the Ractive.js and Dropbox Datastore API libraries:

```html
<script src="https://www.dropbox.com/static/api/1/dropbox-datastores-0.1.0-b3.js"></script>
<script src="ractive.js"></script>
<script src="ractivedatastore.js"></script>
```

To build `ractivedatastore.js` yourself, just run `coffee -c ractivedatastore.coffee`.

Usage
-----

See the example at [ractiveds.site44.com](https://ractiveds.site44.com) for usage:

```html
<div id="content"></div>
<script id="template" type="text/ractive">
    <h2>Greeting: {{greeting}}, {{recipient}}!</h2>
    <label>Edit the values (two-way data binding!):</label>
    <input value="{{greeting}}" />
    <input value="{{recipient}}" />
</script>

<script>
    var rds = new RactiveDatastore(
        '<YOUR APP KEY>', // app key
        'content', // ID of element to populate with template
        '#template', // template string or tag ID
        { greeting: 'Hello', recipient: 'World' } // initial data
    );

    rds.authenticate();
</script>
```

Note that the Ractive Datastore library only supports **simple key/value pairs**. Nested data structures and lists (which are supported by Ractive itself) are not supported.
