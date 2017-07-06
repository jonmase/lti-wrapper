var React = require('react');
var ReactDOM = require('react-dom');
var injectTapEventPlugin = require('react-tap-event-plugin');
var Page = require('./page.jsx');

injectTapEventPlugin();

ReactDOM.render(
    <Page 
        title={"App Title"} 
        titleUrl={"/"} 
        items={null} 
    />, 
    document.getElementById('index')
);
